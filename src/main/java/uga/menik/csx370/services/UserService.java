package uga.menik.csx370.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.context.annotation.SessionScope;
import uga.menik.csx370.models.User;

import javax.sql.DataSource;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Handles user authentication, registration, and retrieval
 * for the Open Research Review Platform.
 */
@Service
@SessionScope
public class UserService {

    private final DataSource dataSource;
    private final BCryptPasswordEncoder passwordEncoder;

    // Cached user for this session
    private User loggedInUser = null;

    @Autowired
    public UserService(DataSource dataSource) {
        this.dataSource = dataSource;
        this.passwordEncoder = new BCryptPasswordEncoder();
    }

    // ---------------------------------------------------------
    // AUTHENTICATION
    // ---------------------------------------------------------

    /**
     * Attempts to authenticate a user by username + password.
     * On success, sets loggedInUser and returns true.
     */
    public boolean authenticate(String username, String password) throws SQLException {

        final String sql = """
            SELECT userId,
                   username,
                   password,
                   firstName,
                   lastName,
                   institution,
                   role
            FROM user
            WHERE username = ?
        """;

        try (Connection conn = dataSource.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, username);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    String storedHash = rs.getString("password");

                    if (passwordEncoder.matches(password, storedHash)) {
                        // In our model, "email" is mapped from username
                        loggedInUser = new User(
                                rs.getString("userId"),
                                rs.getString("firstName"),
                                rs.getString("lastName"),
                                rs.getString("username"),   // email
                                rs.getString("institution"),
                                rs.getString("role")
                        );
                        return true;
                    }
                }
            }
        }

        return false;
    }

    public void unAuthenticate() {
        loggedInUser = null;
    }

    public boolean isAuthenticated() {
        return loggedInUser != null;
    }

    public User getLoggedInUser() {
        return loggedInUser;
    }

    // ---------------------------------------------------------
    // REGISTRATION
    // ---------------------------------------------------------

    /**
     * Registers a new user.
     * username is also used as email in the User model.
     */
    public boolean registerUser(String username,
                                String password,
                                String firstName,
                                String lastName,
                                String institution,
                                String role) throws SQLException {

        final String sql = """
            INSERT INTO user (username, password, firstName, lastName, institution, role)
            VALUES (?, ?, ?, ?, ?, ?)
        """;

        try (Connection conn = dataSource.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, username);
            stmt.setString(2, passwordEncoder.encode(password));
            stmt.setString(3, firstName);
            stmt.setString(4, lastName);
            stmt.setString(5, institution);
            stmt.setString(6, role);

            return stmt.executeUpdate() > 0;
        }
    }

    // ---------------------------------------------------------
    // USER LOOKUP
    // ---------------------------------------------------------

    public User getUserById(String userId) {

        final String sql = """
            SELECT userId,
                   username,
                   firstName,
                   lastName,
                   institution,
                   role
            FROM user
            WHERE userId = ?
        """;

        try (Connection conn = dataSource.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, userId);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return new User(
                            rs.getString("userId"),
                            rs.getString("firstName"),
                            rs.getString("lastName"),
                            rs.getString("username"),   // email
                            rs.getString("institution"),
                            rs.getString("role")
                    );
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    // ---------------------------------------------------------
    // LIST ALL USERS
    // ---------------------------------------------------------

    public List<User> getAllUsers() {

        List<User> users = new ArrayList<>();

        final String sql = """
            SELECT userId,
                   username,
                   firstName,
                   lastName,
                   institution,
                   role
            FROM user
            ORDER BY lastName ASC, firstName ASC
        """;

        try (Connection conn = dataSource.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                users.add(new User(
                        rs.getString("userId"),
                        rs.getString("firstName"),
                        rs.getString("lastName"),
                        rs.getString("username"),   // email
                        rs.getString("institution"),
                        rs.getString("role")
                ));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return users;
    }

    // ---------------------------------------------------------
    // FILTER USERS BY ROLE
    // ---------------------------------------------------------

    public List<User> getReviewers() {
        return getUsersByRole("reviewer");
    }

    public List<User> getResearchers() {
        return getUsersByRole("author"); 
    }

    public List<User> getAdmins() {
        return getUsersByRole("admin");
    }

    private List<User> getUsersByRole(String role) {

        List<User> users = new ArrayList<>();

        final String sql = """
            SELECT userId,
                   username,
                   firstName,
                   lastName,
                   institution,
                   role
            FROM user
            WHERE role = ?
            ORDER BY lastName ASC, firstName ASC
        """;

        try (Connection conn = dataSource.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, role);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    users.add(new User(
                            rs.getString("userId"),
                            rs.getString("firstName"),
                            rs.getString("lastName"),
                            rs.getString("username"),   // email
                            rs.getString("institution"),
                            rs.getString("role")
                    ));
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return users;
    }
}
