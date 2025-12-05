package uga.menik.csx370.models;

import java.util.List;

/**
 * Represents a review submitted by a user for a specific paper.
 */
public class Review {

    private final String reviewId;
    private final String paperId;
    private final User reviewer;

    private final int overallScore;     // 1–5
    private final int confidence;       // 1–5
    private final String verdict;       // e.g., "Accept", "Reject", etc.

    private final String feedback;      // Full text review
    private final String reviewDate;

    private final List<ReviewCriterionScore> criteriaScores;

    public Review(String reviewId,
                  String paperId,
                  User reviewer,
                  int overallScore,
                  int confidence,
                  String verdict,
                  String feedback,
                  String reviewDate,
                  List<ReviewCriterionScore> criteriaScores) {

        this.reviewId = reviewId;
        this.paperId = paperId;
        this.reviewer = reviewer;
        this.overallScore = overallScore;
        this.confidence = confidence;
        this.verdict = verdict;
        this.feedback = feedback;
        this.reviewDate = reviewDate;
        this.criteriaScores = criteriaScores;
    }

    public String getReviewId() { return reviewId; }
    public String getPaperId() { return paperId; }
    public User getReviewer() { return reviewer; }
    public int getOverallScore() { return overallScore; }
    public int getConfidence() { return confidence; }
    public String getVerdict() { return verdict; }
    public String getFeedback() { return feedback; }
    public String getReviewDate() { return reviewDate; }

    public List<ReviewCriterionScore> getCriteriaScores() {
        return List.copyOf(criteriaScores);
    }
}
