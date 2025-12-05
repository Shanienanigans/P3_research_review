package uga.menik.csx370.models;

/**
 * Represents the score a reviewer assigns to a specific review criterion.
 */
public class ReviewCriterionScore {

    private final String reviewId;
    private final String criterionId;
    private final int score;        // 1–5
    private final String notes;     

    public ReviewCriterionScore(String reviewId,
                                String criterionId,
                                int score,
                                String notes) {

        this.reviewId = reviewId;
        this.criterionId = criterionId;
        this.score = score;
        this.notes = notes;
    }

    public String getReviewId() { return reviewId; }
    public String getCriterionId() { return criterionId; }
    public int getScore() { return score; }
    public String getNotes() { return notes; }
}
