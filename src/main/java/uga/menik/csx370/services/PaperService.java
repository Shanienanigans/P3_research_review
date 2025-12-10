package uga.menik.csx370.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import uga.menik.csx370.models.*;

import javax.sql.DataSource;

import java.io.File;
import java.sql.*;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.Collections;
import java.util.List;
import java.util.Map;

import jakarta.servlet.http.HttpServletResponse;


/**
 * Handles all paper-related operations in the Open Research Review Platform:
 * upload, list, search, sort, detail view, and paper comments.
 */
@Service
public class PaperService {

    private final DataSource dataSource;
    private final UserService userService;

    // ------------------ Thumbnails ------------------
    private static final String[] THUMBS = {
            "thumb1.jpg",
            "thumb2.jpg",
            "thumb3.jpg",
            "thumb4.jpg"
    };

    private String pickThumbnailForPaper(String paperId) {
        int i = Math.abs(paperId.hashCode()) % THUMBS.length;
        return THUMBS[i];
    }
    // ------------------------------------------------

    @Autowired
    public PaperService(DataSource dataSource, UserService userService) {
        this.dataSource = dataSource;
        this.userService = userService;
    }


    // ---------------------------------------------------------
    // 1. UPLOAD PAPER
    // ---------------------------------------------------------
    public boolean uploadPaper(String title,
                               String abstractText,
                               String authors,
                               String filePath,
                               String uploaderId) {

        final String sql = """
            INSERT INTO paper (title, abstract, authors, filePath, uploaderId)
            VALUES (?, ?, ?, ?, ?)
        """;

        try (Connection conn = dataSource.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, title);
            ps.setString(2, abstractText);
            ps.setString(3, authors);
            ps.setString(4, filePath);
            ps.setString(5, uploaderId);

            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }


    // ---------------------------------------------------------
    // 2. GET A SINGLE PAPER (ExpandedPaper)
    // ---------------------------------------------------------
    public ExpandedPaper getPaper(String paperId) {

        final String sql = """
            SELECT p.paperId,
                   p.title,
                   p.abstract AS abstractText,
                   p.authors,
                   p.filePath,
                   DATE_FORMAT(
                        CONVERT_TZ(p.uploadedAt, '+00:00', '-04:00'),
                        '%b %e, %Y %l:%i %p'
                   ) AS uploadDate,
                   p.uploaderId,
                   COALESCE(AVG(r.overallScore), 0) AS avgScore,
                   COUNT(r.reviewId)              AS reviewCount
            FROM paper p
            LEFT JOIN review r ON r.paperId = p.paperId
            WHERE p.paperId = ?
            GROUP BY p.paperId, p.title, abstractText, p.authors,
                     p.filePath, p.uploadedAt, uploadDate, p.uploaderId
        """;

        try (Connection conn = dataSource.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, paperId);

            try (ResultSet rs = ps.executeQuery()) {
                if (!rs.next())
                    return null;

                User uploader = userService.getUserById(rs.getString("uploaderId"));
                List<Comment> comments = getCommentsForPaper(paperId);
                List<Review> reviews = getReviewsForPaper(paperId);

                ExpandedPaper paper = new ExpandedPaper(
                        rs.getString("paperId"),
                        rs.getString("title"),
                        rs.getString("authors"),
                        rs.getString("abstractText"),
                        rs.getString("uploadDate"),
                        uploader,
                        rs.getString("filePath"),
                        rs.getDouble("avgScore"),
                        rs.getInt("reviewCount"),
                        comments,
                        reviews
                );

                // assign thumbnail
                paper.setThumbnail(pickThumbnailForPaper(paper.getPaperId()));

                return paper;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }


    // ---------------------------------------------------------
    // LIST ALL PAPERS as BasicPaper (homepage + all papers page)
    // ---------------------------------------------------------
    public List<BasicPaper> getAllBasicPapers() {

        final String sql = """
            SELECT p.paperId,
                p.title,
                p.authors,
                p.abstract AS abstractText,
                DATE_FORMAT(
                        CONVERT_TZ(p.uploadedAt, '+00:00', '-04:00'),
                        '%b %e, %Y %l:%i %p'
                ) AS uploadDate,
                p.uploaderId,
                COALESCE(AVG(r.overallScore), 0) AS avgScore,
                COUNT(r.reviewId)              AS reviewCount
            FROM paper p
            LEFT JOIN review r ON r.paperId = p.paperId
            GROUP BY p.paperId, p.title, abstractText, p.authors,
                    p.uploadedAt, uploadDate, p.uploaderId
            ORDER BY p.uploadedAt DESC
        """;

        List<BasicPaper> list = new ArrayList<>();

        try (Connection conn = dataSource.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {

                User uploader = userService.getUserById(rs.getString("uploaderId"));

                BasicPaper bp = new BasicPaper(
                    rs.getString("paperId"),
                    rs.getString("title"),
                    rs.getString("authors"),
                    rs.getString("abstractText"),
                    rs.getString("uploadDate"),
                    uploader
                );

                // Thumbnail
                bp.setThumbnail(pickThumbnailForPaper(rs.getString("paperId")));

                // Scores
                bp.setAvgScore(rs.getDouble("avgScore"));
                bp.setReviewCount(rs.getInt("reviewCount"));

                list.add(bp);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
    

    // ---------------------------------------------------------
    // LATEST PAPERS for HOME PAGE (top N)
    // ---------------------------------------------------------
    public List<BasicPaper> getLatestBasicPapers(int limit) {

        // 已经按 uploadedAt DESC 排好序
        List<BasicPaper> all = getAllBasicPapers();

        if (all == null) {
            return Collections.emptyList();
        }

        if (all.size() <= limit) {
            return all;
        }

        return all.subList(0, limit);   // 只取前 limit 条
    }

    // ---------------------------------------------------------
    // SEARCH PAPERS (title, authors, abstract)
    // ---------------------------------------------------------
    public List<BasicPaper> searchPapers(String query) {
        try (Connection conn = dataSource.getConnection()) {

            String sql = """
                SELECT 
                    p.paperId,
                    p.title,
                    p.authors,
                    p.abstract AS abstractText,
                    DATE_FORMAT(
                        CONVERT_TZ(p.uploadedAt, '+00:00', '-04:00'),
                        '%b %e, %Y %l:%i %p'
                    ) AS uploadDate,

                    u.userId,
                    u.firstName,
                    u.lastName,
                    u.role,
                    u.institution,
                    u.profileImagePath,

                    COALESCE(AVG(r.overallScore), 0) AS avgScore,
                    COUNT(r.reviewId) AS reviewCount

                FROM paper p
                JOIN user u ON p.uploaderId = u.userId
                LEFT JOIN review r ON r.paperId = p.paperId

                WHERE 
                    LOWER(p.title) LIKE LOWER(?)
                    OR LOWER(p.authors) LIKE LOWER(?)
                    OR LOWER(p.abstract) LIKE LOWER(?)

                GROUP BY 
                    p.paperId, p.title, abstractText, uploadDate,
                    u.userId, u.firstName, u.lastName,
                    u.role, u.institution, u.profileImagePath

                ORDER BY p.uploadedAt DESC
            """;

            PreparedStatement ps = conn.prepareStatement(sql);
            String q = "%" + query + "%";
            ps.setString(1, q);
            ps.setString(2, q);
            ps.setString(3, q);

            ResultSet rs = ps.executeQuery();

            List<BasicPaper> results = new ArrayList<>();

            while (rs.next()) {

                User uploader = new User(
                    rs.getString("userId"),
                    rs.getString("firstName"),
                    rs.getString("lastName"),
                    null,                       // email DOES NOT exist in DB
                    rs.getString("institution"),
                    rs.getString("role"),
                    rs.getString("profileImagePath")
                );



                BasicPaper bp = new BasicPaper(
                    rs.getString("paperId"),
                    rs.getString("title"),
                    rs.getString("authors"),
                    rs.getString("abstractText"),
                    rs.getString("uploadDate"),
                    uploader
                );

                bp.setAvgScore(rs.getDouble("avgScore"));
                bp.setReviewCount(rs.getInt("reviewCount"));
                bp.setThumbnail(pickThumbnailForPaper(bp.getPaperId()));


                results.add(bp);
            }

            return results;

        } catch (Exception e) {
            e.printStackTrace();
            return List.of();
        }
    }


    // ---------------------------------------------------------
    // 5. SORT PAPERS 
    // ---------------------------------------------------------
    public List<Paper> sortPapers(String sortBy) {

        String order = switch (sortBy == null ? "" : sortBy.toLowerCase()) {
            case "title"   -> "p.title ASC";
            case "authors" -> "p.authors ASC";
            case "score"   -> "avgScore DESC";
            default        -> "p.uploadedAt DESC";
        };

        final String sql = """
            SELECT p.paperId,
                   p.title,
                   p.authors,
                   p.abstract AS abstractText,
                   p.filePath,
                   DATE_FORMAT(
                        CONVERT_TZ(p.uploadedAt, '+00:00', '-04:00'),
                        '%b %e, %Y %l:%i %p'
                   ) AS uploadDate,
                   p.uploaderId,
                   COALESCE(AVG(r.overallScore), 0) AS avgScore,
                   COUNT(r.reviewId)              AS reviewCount
            FROM paper p
            LEFT JOIN review r ON r.paperId = p.paperId
            GROUP BY p.paperId, p.title, abstractText, p.authors,
                     p.filePath, p.uploadedAt, uploadDate, p.uploaderId
            ORDER BY %s
        """.formatted(order);

        List<Paper> papers = new ArrayList<>();

        try (Connection conn = dataSource.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                User uploader = userService.getUserById(rs.getString("uploaderId"));

                Paper paper = new Paper(
                        rs.getString("paperId"),
                        rs.getString("title"),
                        rs.getString("authors"),
                        rs.getString("abstractText"),
                        rs.getString("uploadDate"),
                        uploader,
                        rs.getString("filePath"),
                        rs.getDouble("avgScore"),
                        rs.getInt("reviewCount")
                );

                paper.setThumbnail(pickThumbnailForPaper(paper.getPaperId()));
                papers.add(paper);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return papers;
    }


    // ---------------------------------------------------------
    // 6. PAPERS BY UPLOADER
    // ---------------------------------------------------------
    public List<Paper> getPapersByUploader(String userId) {

        final String sql = """
            SELECT p.paperId,
                   p.title,
                   p.authors,
                   p.abstract AS abstractText,
                   p.filePath,
                   DATE_FORMAT(
                        CONVERT_TZ(p.uploadedAt, '+00:00', '-04:00'),
                        '%b %e, %Y %l:%i %p'
                   ) AS uploadDate,
                   p.uploaderId,
                   COALESCE(AVG(r.overallScore), 0) AS avgScore,
                   COUNT(r.reviewId)              AS reviewCount
            FROM paper p
            LEFT JOIN review r ON r.paperId = p.paperId
            WHERE p.uploaderId = ?
            GROUP BY p.paperId, p.title, abstractText, p.authors,
                     p.filePath, p.uploadedAt, uploadDate, p.uploaderId
            ORDER BY p.uploadedAt DESC
        """;

        List<Paper> list = new ArrayList<>();

        try (Connection conn = dataSource.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, userId);

            try (ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {

                    User uploader = userService.getUserById(rs.getString("uploaderId"));

                    Paper paper = new Paper(
                            rs.getString("paperId"),
                            rs.getString("title"),
                            rs.getString("authors"),
                            rs.getString("abstractText"),
                            rs.getString("uploadDate"),
                            uploader,
                            rs.getString("filePath"),
                            rs.getDouble("avgScore"),
                            rs.getInt("reviewCount")
                    );

                    paper.setThumbnail(pickThumbnailForPaper(paper.getPaperId()));
                    list.add(paper);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }


    // ---------------------------------------------------------
    // 7. COMMENTS (with threaded replies + reply counts)
    // ---------------------------------------------------------
    public List<Comment> getCommentsForPaper(String paperId) {

        final String sql = """
            SELECT c.commentId,
                c.paperId,
                c.userId,
                c.content,
                DATE_FORMAT(
                        CONVERT_TZ(c.createdAt, '+00:00', '-04:00'),
                        '%b %e, %Y %l:%i %p'
                ) AS createdAt,
                c.parentCommentId
            FROM comment c
            WHERE c.paperId = ?
            ORDER BY c.createdAt ASC
        """;

        // Store all comments so we can attach replies to parents
        Map<String, Comment> all = new LinkedHashMap<>();

        try (Connection conn = dataSource.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, paperId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Comment c = new Comment(
                    rs.getString("commentId"),
                    rs.getString("paperId"),
                    rs.getString("userId"),
                    rs.getString("content"),
                    rs.getString("createdAt"),
                    userService.getUserById(rs.getString("userId")),
                    rs.getString("parentCommentId")
                );

                c.setReplies(new ArrayList<>());  // initialize empty list
                all.put(c.getCommentId(), c);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }


        // ---------------------------------------------------------
        // STEP 1 — attach each reply to its parent
        // ---------------------------------------------------------
        for (Comment c : all.values()) {
            String parentId = c.getParentCommentId();

            if (parentId != null) {
                Comment parent = all.get(parentId);
                if (parent != null) {
                    parent.getReplies().add(c);
                }
            }
        }


        // ---------------------------------------------------------
        // STEP 2 — collect ONLY top-level comments
        // ---------------------------------------------------------
        List<Comment> topLevel = new ArrayList<>();

        for (Comment c : all.values()) {
            if (c.getParentCommentId() == null) {
                topLevel.add(c);
            }
        }


        // ---------------------------------------------------------
        // STEP 3 — recursively compute reply counts for each thread
        // ---------------------------------------------------------
        for (Comment c : topLevel) {
            computeReplyCounts(c);
        }

        return topLevel;
    }



    // ---------------------------------------------------------
    // Recursive helper: compute replyCount for each comment
    // replyCount = total number of replies in this entire thread
    // ---------------------------------------------------------
    private int computeReplyCounts(Comment c) {

        if (c.getReplies() == null || c.getReplies().isEmpty()) {
            c.setReplyCount(0);
            return 0;
        }

        int total = c.getReplies().size(); // direct replies

        // include deeper replies
        for (Comment child : c.getReplies()) {
            total += computeReplyCounts(child);
        }

        c.setReplyCount(total);
        return total;
    }



    // ---------------------------------------------------------
    // INSERT NEW COMMENT OR REPLY
    // ---------------------------------------------------------
    public boolean addComment(String paperId, String userId, String content, String parentCommentId) {

        final String sql = """
            INSERT INTO comment (paperId, userId, content, parentCommentId)
            VALUES (?, ?, ?, ?)
        """;

        try (Connection conn = dataSource.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, paperId);
            ps.setString(2, userId);
            ps.setString(3, content);

            if (parentCommentId == null || parentCommentId.isBlank()) {
                ps.setNull(4, Types.INTEGER);
            } else {
                ps.setString(4, parentCommentId);
            }

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }


    // ---------------------------------------------------------
    // 8. REVIEWS (internal helpers)
    // ---------------------------------------------------------
    private List<Review> getReviewsForPaper(String paperId) {

        final String sql = """
            SELECT r.reviewId,
                   r.paperId,
                   r.reviewerId,
                   r.overallScore,
                   r.confidence,
                   r.verdict,
                   r.comments,
                   DATE_FORMAT(
                        CONVERT_TZ(r.createdAt, '+00:00', '-04:00'),
                        '%b %e, %Y %l:%i %p'
                   ) AS reviewDate
            FROM review r
            WHERE r.paperId = ?
            ORDER BY r.createdAt DESC
        """;

        List<Review> reviews = new ArrayList<>();

        try (Connection conn = dataSource.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, paperId);

            try (ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {

                    User reviewer = userService.getUserById(rs.getString("reviewerId"));
                    List<ReviewCriterionScore> scores =
                        getCriterionScoresForReview(conn, rs.getString("reviewId"));

                    reviews.add(new Review(
                            rs.getString("reviewId"),
                            rs.getString("paperId"),
                            reviewer,
                            rs.getInt("overallScore"),
                            rs.getInt("confidence"),
                            rs.getString("verdict"),
                            rs.getString("comments"),
                            rs.getString("reviewDate"),
                            scores
                    ));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return reviews;
    }


    private List<ReviewCriterionScore> getCriterionScoresForReview(
            Connection conn, String reviewId) throws SQLException {

        final String sql = """
            SELECT reviewId,
                   criterionId,
                   score
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
                            ""  // notes not stored
                    ));
                }
            }
        }

        return scores;
    }

    // ---------------------------------------------------------
    // GET PAPER BY ID (simple version for paper_page.mustache)
    // ---------------------------------------------------------
    public Paper getPaperById(String paperId) {

        final String sql = """
            SELECT p.paperId,
                p.title,
                p.authors,
                p.abstract AS abstractText,
                p.filePath,
                DATE_FORMAT(
                        CONVERT_TZ(p.uploadedAt, '+00:00', '-04:00'),
                        '%b %e, %Y %l:%i %p'
                ) AS uploadDate,
                p.uploaderId,
                COALESCE(AVG(r.overallScore), 0) AS avgScore,
                COUNT(r.reviewId)              AS reviewCount
            FROM paper p
            LEFT JOIN review r ON r.paperId = p.paperId
            WHERE p.paperId = ?
            GROUP BY p.paperId, p.title, abstractText, p.authors,
                    p.filePath, p.uploadedAt, uploadDate, p.uploaderId
        """;

        try (Connection conn = dataSource.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, paperId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {

                    User uploader = userService.getUserById(rs.getString("uploaderId"));

                    Paper p = new Paper(
                            rs.getString("paperId"),
                            rs.getString("title"),
                            rs.getString("authors"),
                            rs.getString("abstractText"),
                            rs.getString("uploadDate"),
                            uploader,
                            rs.getString("filePath"),
                            rs.getDouble("avgScore"),
                            rs.getInt("reviewCount")
                    );

                    p.setThumbnail(pickThumbnailForPaper(paperId));
                    return p;
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }


    // ---------------------------------------------------------
    // STREAM PDF TO BROWSER
    // ---------------------------------------------------------
    public void streamPdfToResponse(String paperId, HttpServletResponse response) {

        String sql = "SELECT filePath FROM paper WHERE paperId = ?";

        try (Connection conn = dataSource.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, paperId);

            try (ResultSet rs = ps.executeQuery()) {
                if (!rs.next()) return;

                String storedPath = rs.getString("filePath");
                File file = new File(System.getProperty("user.dir") + "/" + storedPath);

                if (!file.exists()) return;

                response.setContentType("application/pdf");
                response.setHeader("Content-Disposition","attachment; filename=\"" + file.getName() + "\"");

                java.nio.file.Files.copy(
                        file.toPath(),
                        response.getOutputStream()
                );

                response.flushBuffer();
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }



    // ---------------------------------------------------------
    // 1.b UPDATE PAPER (title / abstract / authors / optional file)
    // ---------------------------------------------------------
    public boolean updatePaper(String paperId,
                               String title,
                               String abstractText,
                               String authors,
                               String newFilePathOrNull) {

        String sql;

        // 如果有新的 PDF 路径，就一起更新 filePath
        if (newFilePathOrNull != null) {
            sql = """
                UPDATE paper
                SET title = ?, abstract = ?, authors = ?, filePath = ?
                WHERE paperId = ?
            """;
        } else {
            // 否则只改元数据
            sql = """
                UPDATE paper
                SET title = ?, abstract = ?, authors = ?
                WHERE paperId = ?
            """;
        }

        try (Connection conn = dataSource.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, title);
            ps.setString(2, abstractText);
            ps.setString(3, authors);

            if (newFilePathOrNull != null) {
                ps.setString(4, newFilePathOrNull);
                ps.setString(5, paperId);
            } else {
                ps.setString(4, paperId);
            }

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }


    
}
