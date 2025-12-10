package uga.menik.csx370.models;

import java.util.List;

/**
 * Represents a user comment on a paper (discussion comment, not a review).
 */
public class Comment {

    private final String commentId;
    private final String paperId;
    private final String userId;
    private final String content;
    private final String createdAt;
    private final User user;

    private final String parentCommentId; // null if top-level


    private List<Comment> replies;

    private int replyCount;


    public Comment(String commentId,
                   String paperId,
                   String userId,
                   String content,
                   String createdAt,
                   User user,
                   String parentCommentId) {

        this.commentId = commentId;
        this.paperId = paperId;
        this.userId = userId;
        this.content = content;
        this.createdAt = createdAt;
        this.user = user;
        this.parentCommentId = parentCommentId;

        this.replyCount = 0; // default
    }

    public String getCommentId() { return commentId; }
    public String getPaperId() { return paperId; }
    public String getUserId() { return userId; }
    public String getContent() { return content; }
    public String getCreatedAt() { return createdAt; }
    public User getUser() { return user; }
    public String getParentCommentId() { return parentCommentId; }

    public List<Comment> getReplies() { return replies; }
    public void setReplies(List<Comment> replies) { 
        this.replies = replies;
        this.replyCount = (replies != null ? replies.size() : 0);
    }

    public int getReplyCount() {
        return replyCount;
    }

    public void setReplyCount(int replyCount) {
        this.replyCount = replyCount;
    }
}
