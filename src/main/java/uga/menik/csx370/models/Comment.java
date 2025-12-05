package uga.menik.csx370.models;

/**
 * Represents a user comment on a paper (discussion comment, not a review).
 */
public class Comment {

    private final String commentId;
    private final String paperId;   // foreign key to Paper
    private final String userId;    // user who wrote the comment
    private final String content;
    private final String createdAt;

    public Comment(String commentId,
                   String paperId,
                   String userId,
                   String content,
                   String createdAt) {

        this.commentId = commentId;
        this.paperId = paperId;
        this.userId = userId;
        this.content = content;
        this.createdAt = createdAt;
    }

    public String getCommentId() { return commentId; }
    public String getPaperId() { return paperId; }
    public String getUserId() { return userId; }
    public String getContent() { return content; }
    public String getCreatedAt() { return createdAt; }
}
