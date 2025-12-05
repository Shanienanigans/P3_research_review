package uga.menik.csx370.models;

/**
 * Represents a review criterion such as Clarity, Novelty, Methodology, etc.
 */
public class Criterion {

    private final String criterionId;
    private final String name;
    private final String description;

    public Criterion(String criterionId, String name, String description) {
        this.criterionId = criterionId;
        this.name = name;
        this.description = description;
    }

    public String getCriterionId() { return criterionId; }
    public String getName() { return name; }
    public String getDescription() { return description; }
}
