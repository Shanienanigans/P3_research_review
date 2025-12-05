package uga.menik.csx370.models;

/**
 * Represents a user of the Open Research Review Platform.
 */
public class User {

    private final String userId;
    private final String firstName;
    private final String lastName;
    private final String email;
    private final String institution;
    private final String role;  // researcher, reviewer, admin
    private final String profileImagePath;

    public User(String userId,
                String firstName,
                String lastName,
                String email,
                String institution,
                String role,
                String profileImagePath) {

        this.userId = userId;
        this.firstName = firstName;
        this.lastName = lastName;
        this.email = email;
        this.institution = institution;
        this.role = role;
        this.profileImagePath = profileImagePath;
    }

    /**
     * Convenience constructor where profile image is auto-generated.
     */
    public User(String userId,
                String firstName,
                String lastName,
                String email,
                String institution,
                String role) {

        this(userId, firstName, lastName, email, institution, role, getAvatarPath(userId));
    }

    /**
     * Generates an avatar path from userId.
     */
    private static String getAvatarPath(String userId) {
        int fileNo = (userId.hashCode() % 20) + 1;
        return "/avatars/avatar_" + fileNo + ".png";
    }

    public String getUserId() { return userId; }
    public String getFirstName() { return firstName; }
    public String getLastName() { return lastName; }
    public String getEmail() { return email; }
    public String getInstitution() { return institution; }
    public String getRole() { return role; }
    public String getProfileImagePath() { return profileImagePath; }

    public String getFullName() {
        return firstName + " " + lastName;
    }
}
