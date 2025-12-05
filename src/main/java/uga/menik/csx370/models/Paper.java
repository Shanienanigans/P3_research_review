package uga.menik.csx370.models;

/**
 * Full representation of an uploaded research paper.
 */
public class Paper extends BasicPaper {

    private final String filePath;
    private final double averageScore;   // calculated from reviews
    private final int reviewCount;

    public Paper(String paperId,
                 String title,
                 String authors,
                 String abstractText,
                 String uploadDate,
                 User uploader,
                 String filePath,
                 double averageScore,
                 int reviewCount) {

        super(paperId, title, authors, abstractText, uploadDate, uploader);

        this.filePath = filePath;
        this.averageScore = averageScore;
        this.reviewCount = reviewCount;
    }

    public String getFilePath() { return filePath; }
    public double getAverageScore() { return averageScore; }
    public int getReviewCount() { return reviewCount; }
}
