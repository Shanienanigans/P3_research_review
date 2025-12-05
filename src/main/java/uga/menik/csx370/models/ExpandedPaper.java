package uga.menik.csx370.models;

import java.util.List;

/**
 * Full detailed view of a paper including reviews and comments.
 */
public class ExpandedPaper extends Paper {

    private final List<Comment> comments;
    private final List<Review> reviews;

    public ExpandedPaper(
            String paperId,
            String title,
            String authors,
            String abstractText,
            String uploadDate,
            User uploader,
            String filePath,
            double averageScore,
            int reviewCount,
            List<Comment> comments,
            List<Review> reviews) {

        super(paperId, title, authors, abstractText, uploadDate, uploader,
                filePath, averageScore, reviewCount);

        this.comments = comments;
        this.reviews = reviews;
    }

    public List<Comment> getComments() {
        return List.copyOf(comments);
    }

    public List<Review> getReviews() {
        return List.copyOf(reviews);
    }
}
