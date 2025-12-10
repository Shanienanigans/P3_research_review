package uga.menik.csx370.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.sql.DataSource;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * (follow table).
 */
@Service
public class FollowService {

    private final DataSource dataSource;

    @Autowired
    public FollowService(DataSource dataSource) {
        this.dataSource = dataSource;
    }

    /**
     * if followerId followed followeeId
     */
    public boolean isFollowing(String followerId, String followeeId) {
        final String sql = "SELECT COUNT(*) FROM follow WHERE followerId = ? AND followeeId = ?";

        try (Connection conn = dataSource.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, followerId);
            stmt.setString(2, followeeId);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    /**
     * Insert record
     */
    public void follow(String followerId, String followeeId) {
        if (followerId == null || followeeId == null) return;
        if (followerId.equals(followeeId)) return;

        final String sql = """
            INSERT IGNORE INTO follow (followerId, followeeId)
            VALUES (?, ?)
        """;

        try (Connection conn = dataSource.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, followerId);
            stmt.setString(2, followeeId);
            stmt.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * delete record
     */
    public void unfollow(String followerId, String followeeId) {
        if (followerId == null || followeeId == null) return;

        final String sql = "DELETE FROM follow WHERE followerId = ? AND followeeId = ?";

        try (Connection conn = dataSource.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, followerId);
            stmt.setString(2, followeeId);
            stmt.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * Return list of userIds that followerId is following
     */
    public List<String> getFollowedUserIds(String followerId) {
        List<String> ids = new ArrayList<>();

        final String sql = "SELECT followeeId FROM follow WHERE followerId = ?";

        try (Connection conn = dataSource.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, followerId);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    ids.add(rs.getString("followeeId"));
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return ids;
    }
}