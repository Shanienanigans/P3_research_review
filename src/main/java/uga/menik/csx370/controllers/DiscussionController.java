package uga.menik.csx370.controllers;

import uga.menik.csx370.models.Comment;
import uga.menik.csx370.models.Paper;
import uga.menik.csx370.models.User;

import uga.menik.csx370.services.PaperService;
import uga.menik.csx370.services.UserService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@Controller
@RequestMapping("/discussion")
public class DiscussionController {

    @Autowired
    private PaperService paperService;

    @Autowired
    private UserService userService;

    /* -------------------------------------------------------------
    VIEW DISCUSSION PAGE FOR A PAPER
    -------------------------------------------------------------- */
    @GetMapping("/{paperId}")
public ModelAndView viewDiscussion(@PathVariable String paperId) {

    ModelAndView mv = new ModelAndView("discussion_page");

    // Load paper
    Paper paper = paperService.getPaperById(paperId);
    mv.addObject("paper", paper);

    // Load comments (already built via PaperService)
    List<Comment> comments = paperService.getCommentsForPaper(paperId);
    mv.addObject("comments", comments);

    mv.addObject("paperId", paperId);

    boolean loggedIn = userService.isAuthenticated();
    mv.addObject("isLoggedIn", loggedIn);

    if (loggedIn) {
        User user = userService.getLoggedInUser();
        mv.addObject("userFirstName", userService.getLoggedInUser().getFirstName());
    }

    return mv;
}




    /* -------------------------------------------------------------
    ADD NEW COMMENT OR REPLY TO A DISCUSSION THREAD
    -------------------------------------------------------------- */
    @PostMapping("/{paperId}/add")
    public String addComment(@PathVariable String paperId,
                            @RequestParam String comment,
                            @RequestParam(required = false) String parentCommentId) {

        if (!userService.isAuthenticated()) {
            return "redirect:/login";
        }

        // INSERT top-level comment or reply
        paperService.addComment(
                paperId,
                userService.getLoggedInUser().getUserId(),
                comment,
                parentCommentId 
        );

        return "redirect:/discussion/" + paperId;
    }

}
