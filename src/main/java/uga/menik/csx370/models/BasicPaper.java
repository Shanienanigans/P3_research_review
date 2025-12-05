package uga.menik.csx370.models;

/**
 * Minimal representation of a paper for lists (home page, all papers, search).
 */
public class BasicPaper {

    private final String paperId;
    private final String title;
    private final String authors;
    private final String abstractText;
    private final String uploadDate;
    private final User uploader;

    // for Thumbnail filename (thumb1.jpg, thumb2.jpg…)
    private String thumbnail;

    // for mustache template
    private double avgScore;
    private int reviewCount;

    public BasicPaper(String paperId,
                      String title,
                      String authors,
                      String abstractText,
                      String uploadDate,
                      User uploader) {

        this.paperId = paperId;
        this.title = title;
        this.authors = authors;
        this.abstractText = abstractText;
        this.uploadDate = uploadDate;
        this.uploader = uploader;
    }

    public String getPaperId() {
        return paperId;
    }

    public String getTitle() {
        return title;
    }

    public String getAuthors() {
        return authors;
    }

    public String getAbstractText() {
        return abstractText;
    }

    public String getUploadDate() {
        return uploadDate;
    }

    public User getUploader() {
        return uploader;
    }

    // -----------------------------------------
    // THUMBNAIL
    // -----------------------------------------
    public String getThumbnail() {
        return thumbnail;
    }

    public void setThumbnail(String thumbnail) {
        this.thumbnail = thumbnail;
    }

    // -----------------------------------------
    // AVG SCORE + REVIEW COUNT (Used in mustache)
    // -----------------------------------------
    public double getAvgScore() {
        return avgScore;
    }

    public void setAvgScore(double avgScore) {
        this.avgScore = avgScore;
    }

    public int getReviewCount() {
        return reviewCount;
    }

    public void setReviewCount(int reviewCount) {
        this.reviewCount = reviewCount;
    }

    // -----------------------------------------
    // SHORT ABSTRACT SNIPPET
    // -----------------------------------------
    public String getAbstractSnippet() {
        if (abstractText == null) return "";
        if (abstractText.length() <= 180) return abstractText;
        return abstractText.substring(0, 180) + "...";
    }
}
