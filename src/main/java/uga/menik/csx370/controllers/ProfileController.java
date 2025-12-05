package uga.menik.csx370.controllers;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import uga.menik.csx370.models.Paper;
import uga.menik.csx370.models.Review;
import uga.menik.csx370.models.User;
import uga.menik.csx370.services.PaperService;
import uga.menik.csx370.services.ReviewService;
import uga.menik.csx370.services.UserService;

@Controller
@RequestMapping("/profile")
public class ProfileController {

    private final UserService userService;
    private final PaperService paperService;
    private final ReviewService reviewService;

    @Autowired
    public ProfileController(UserService userService,
                             PaperService paperService,
                             ReviewService reviewService) {
        this.userService = userService;
        this.paperService = paperService;
        this.reviewService = reviewService;
    }

    @GetMapping
    public ModelAndView profileOfLoggedInUser() {

        User current = userService.getLoggedInUser();
        ModelAndView mv = profileOfSpecificUser(current.getUserId());

        //  Add login info
        mv.addObject("isLoggedIn", true);
        mv.addObject("userFirstName", current.getFirstName());

        return mv;
    }

    @GetMapping("/{userId}")
    public ModelAndView profileOfSpecificUser(@PathVariable("userId") String userId) {

        ModelAndView mv = new ModelAndView("profile_page");

        User user = userService.getUserById(userId);
        mv.addObject("user", user);

        // login info
        if (userService.isAuthenticated()) {
            mv.addObject("isLoggedIn", true);
            mv.addObject("userFirstName", userService.getLoggedInUser().getFirstName());
        } else {
            mv.addObject("isLoggedIn", false);
        }

        if (user == null) {
            mv.addObject("errorMessage", "User not found.");
            return mv;
        }

        // Get papers & reviews
        List<Paper> uploads = paperService.getPapersByUploader(userId);
        mv.addObject("papers", uploads);

        List<Review> reviews = reviewService.getReviewsByUser(userId);
        mv.addObject("reviews", reviews);

        // Is the viewing user the owner of the profile?
        String loggedId = userService.isAuthenticated()
                ? userService.getLoggedInUser().getUserId()
                : null;

        boolean isOwner = loggedId != null && loggedId.equals(userId);
        mv.addObject("isOwner", isOwner);

        mv.addObject("isNoContent", uploads.isEmpty() && reviews.isEmpty());

        return mv;
    }
}
