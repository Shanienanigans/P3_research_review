package uga.menik.csx370.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import uga.menik.csx370.models.Paper;
import uga.menik.csx370.models.User;

import javax.sql.DataSource;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Provides lists of papers for the homepage (latest papers).
 * NOTE: This service is optional and can be replaced by PaperService.getAllPapers().
 */
@Service
public class PaperFeedService {

    private final DataSource dataSource;
    private final UserService userService;

    @Autowired
    public PaperFeedService(DataSource dataSource, UserService userService) {
        this.dataSource = dataSource;
        this.userService = userService;
    }

    /**
     * Returns the latest papers with basic metadata and aggregated review stats.
     */
    public List<Paper> getRecentPapers(int limit, int offset) {

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
                     p.filePath, uploadDate, p.uploaderId
            ORDER BY p.uploadedAt DESC
            LIMIT ? OFFSET ?
        """;

        List<Paper> papers = new ArrayList<>();

        try (Connection conn = dataSource.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, limit);
            ps.setInt(2, offset);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    User uploader = userService.getUserById(rs.getString("uploaderId"));

                    papers.add(new Paper(
                            rs.getString("paperId"),
                            rs.getString("title"),
                            rs.getString("authors"),
                            rs.getString("abstractText"),
                            rs.getString("uploadDate"),
                            uploader,
                            rs.getString("filePath"),
                            rs.getDouble("avgScore"),
                            rs.getInt("reviewCount")
                    ));
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return papers;
    }
}
