package uga.menik.csx370.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import uga.menik.csx370.models.*;

import javax.sql.DataSource;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Handles submitting reviews, retrieving them, and saving criterion scores.
 */
@Service
public class ReviewService {

    private final DataSource dataSource;
    private final UserService userService;

    @Autowired
    public ReviewService(DataSource dataSource, UserService userService) {
        this.dataSource = dataSource;
        this.userService = userService;
    }

    // ---------------------------------------------------------
    // 1. ADD REVIEW (simple version)
    // ---------------------------------------------------------
    public boolean addReview(String paperId,
                             String reviewerId,
                             int overallScore,
                             int confidence,
                             String verdict,
                             String feedback) throws SQLException {

        final String sql = """
            INSERT INTO review (paperId, reviewerId, overallScore, confidence, verdict, feedback)
            VALUES (?, ?, ?, ?, ?, ?)
        """;

        try (Connection conn = dataSource.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, paperId);
            ps.setString(2, reviewerId);
            ps.setInt(3, overallScore);
            ps.setInt(4, confidence);
            ps.setString(5, verdict);
            ps.setString(6, feedback);

            return ps.executeUpdate() > 0;
        }
    }

    // ---------------------------------------------------------
    // 2. ADD REVIEW WITH CRITERION SCORES (optional UI)
    // ---------------------------------------------------------
    public String addReviewWithScores(String paperId,
                                      String reviewerId,
                                      int overallScore,
                                      int confidence,
                                      String verdict,
                                      String feedback,
                                      List<String> criterionIds,
                                      List<Integer> scores) throws SQLException {

        Connection conn = dataSource.getConnection();
        conn.setAutoCommit(false);

        String reviewId = null;

        try {
            // Insert review
            final String insertReview = """
                INSERT INTO review (paperId, reviewerId, overallScore, confidence, verdict, feedback)
                VALUES (?, ?, ?, ?, ?, ?)
            """;

            try (PreparedStatement ps = conn.prepareStatement(insertReview, Statement.RETURN_GENERATED_KEYS)) {

                ps.setString(1, paperId);
                ps.setString(2, reviewerId);
                ps.setInt(3, overallScore);
                ps.setInt(4, confidence);
                ps.setString(5, verdict);
                ps.setString(6, feedback);
                ps.executeUpdate();

                try (ResultSet keys = ps.getGeneratedKeys()) {
                    if (keys.next()) reviewId = keys.getString(1);
                }
            }

            // Save criterion scores
            if (reviewId != null && criterionIds != null && scores != null) {
                saveCriterionScores(conn, reviewId, criterionIds, scores);
            }

            conn.commit();
            return reviewId;

        } catch (Exception e) {
            conn.rollback();
            e.printStackTrace();
            return null;

        } finally {
            conn.setAutoCommit(true);
            conn.close();
        }
    }

    private void saveCriterionScores(Connection conn,
                                     String reviewId,
                                     List<String> criterionIds,
                                     List<Integer> scores) throws SQLException {

        final String sql = """
            INSERT INTO review_criterion_score (reviewId, criterionId, score)
            VALUES (?, ?, ?)
        """;

        try (PreparedStatement ps = conn.prepareStatement(sql)) {

            for (int i = 0; i < criterionIds.size(); i++) {
                ps.setString(1, reviewId);
                ps.setString(2, criterionIds.get(i));
                ps.setInt(3, scores.get(i));
                ps.addBatch();
            }

            ps.executeBatch();
        }
    }

    // ---------------------------------------------------------
    // 3. GET REVIEWS FOR A PAPER
    // ---------------------------------------------------------
    public List<Review> getReviewsForPaper(String paperId) {

        final String sql = """
            SELECT r.reviewId,
                   r.paperId,
                   r.reviewerId,
                   r.overallScore,
                   r.confidence,
                   r.verdict,
                   r.feedback,
                   DATE_FORMAT(CONVERT_TZ(r.createdAt, '+00:00', '-04:00'),
                               '%b %e, %Y %l:%i %p') AS reviewDate
            FROM review r
            WHERE r.paperId = ?
            ORDER BY r.createdAt DESC
        """;

        List<Review> list = new ArrayList<>();

        try (Connection conn = dataSource.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, paperId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {

                    User reviewer = userService.getUserById(rs.getString("reviewerId"));
                    List<ReviewCriterionScore> scores =
                            getCriterionScores(conn, rs.getString("reviewId"));

                    list.add(new Review(
                            rs.getString("reviewId"),
                            rs.getString("paperId"),
                            reviewer,
                            rs.getInt("overallScore"),
                            rs.getInt("confidence"),
                            rs.getString("verdict"),
                            rs.getString("feedback"),
                            rs.getString("reviewDate"),
                            scores
                    ));
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // ---------------------------------------------------------
    // 4. GET REVIEWS FOR A USER
    // ---------------------------------------------------------
    public List<Review> getReviewsByUser(String userId) {

        final String sql = """
            SELECT r.reviewId,
                   r.paperId,
                   r.reviewerId,
                   r.overallScore,
                   r.confidence,
                   r.verdict,
                   r.feedback,
                   DATE_FORMAT(CONVERT_TZ(r.createdAt, '+00:00', '-04:00'),
                               '%b %e, %Y %l:%i %p') AS reviewDate
            FROM review r
            WHERE r.reviewerId = ?
            ORDER BY r.createdAt DESC
        """;

        List<Review> list = new ArrayList<>();

        try (Connection conn = dataSource.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, userId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {

                    User reviewer = userService.getUserById(rs.getString("reviewerId"));
                    List<ReviewCriterionScore> scores =
                            getCriterionScores(conn, rs.getString("reviewId"));

                    list.add(new Review(
                            rs.getString("reviewId"),
                            rs.getString("paperId"),
                            reviewer,
                            rs.getInt("overallScore"),
                            rs.getInt("confidence"),
                            rs.getString("verdict"),
                            rs.getString("feedback"),
                            rs.getString("reviewDate"),
                            scores
                    ));
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // ---------------------------------------------------------
    // 5. INTERNAL: GET CRITERION SCORES
    // ---------------------------------------------------------
    private List<ReviewCriterionScore> getCriterionScores(Connection conn,
                                                          String reviewId) throws SQLException {

        final String sql = """
            SELECT reviewId, criterionId, score
            FROM review_criterion_score
            WHERE reviewId = ?
        """;

        List<ReviewCriterionScore> scores = new ArrayList<>();

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, reviewId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    scores.add(new ReviewCriterionScore(
                            rs.getString("reviewId"),
                            rs.getString("criterionId"),
                            rs.getInt("score"),
                            ""
                    ));
                }
            }
        }

        return scores;
    }


    public String getPaperTitle(String paperId) {
        final String sql = "SELECT title FROM paper WHERE paperId = ?";
        try (Connection conn = dataSource.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, paperId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getString("title");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return "(Unknown Paper)";
    }

}
