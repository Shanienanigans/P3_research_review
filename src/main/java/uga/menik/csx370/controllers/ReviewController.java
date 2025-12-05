package uga.menik.csx370.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import uga.menik.csx370.services.ReviewService;
import uga.menik.csx370.services.UserService;

/**
 * Handles adding and viewing reviews.
 */
@Controller
@RequestMapping("/reviews")
public class ReviewController {

    private final ReviewService reviewService;
    private final UserService userService;

    @Autowired
    public ReviewController(ReviewService reviewService, UserService userService) {
        this.reviewService = reviewService;
        this.userService = userService;
    }

    /** Show review form */
    @GetMapping("/add/{paperId}")
    public ModelAndView addReviewPage(@PathVariable("paperId") String paperId) {

        ModelAndView mv = new ModelAndView("add_review_page");
        mv.addObject("paperId", paperId);

        //  Add login info
        if (userService.isAuthenticated()) {
            mv.addObject("isLoggedIn", true);
            mv.addObject("userFirstName", userService.getLoggedInUser().getFirstName());
        } else {
            mv.addObject("isLoggedIn", false);
        }

        return mv;
    }


    /** View all reviews for a paper */
    @GetMapping("/{paperId}")
    public ModelAndView viewReviews(@PathVariable("paperId") String paperId) {

        ModelAndView mv = new ModelAndView("reviews_page");

        mv.addObject("paperId", paperId);
        mv.addObject("reviews", reviewService.getReviewsForPaper(paperId));

        //  Add login info
        if (userService.isAuthenticated()) {
            mv.addObject("isLoggedIn", true);
            mv.addObject("userFirstName", userService.getLoggedInUser().getFirstName());
        } else {
            mv.addObject("isLoggedIn", false);
        }

        return mv;
    }


    /** Submit review — using ONLY overall fields (no criterion scores) */
    @PostMapping("/add/{paperId}")
    public String submitReview(@PathVariable("paperId") String paperId,
                               @RequestParam("overallScore") int overallScore,
                               @RequestParam("confidence") int confidence,
                               @RequestParam("verdict") String verdict,
                               @RequestParam("textFeedback") String feedback) {

        try {
            String reviewerId = userService.getLoggedInUser().getUserId();

            //  Call the ReviewService method
            reviewService.addReview(
                    paperId,
                    reviewerId,
                    overallScore,
                    confidence,
                    verdict,
                    feedback
            );

            return "redirect:/papers/" + paperId;

        } catch (Exception e) {
            e.printStackTrace();
            return "redirect:/papers/" + paperId + "?error=Review+submission+failed";
        }
    }
}
