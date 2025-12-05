package uga.menik.csx370.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import org.springframework.beans.factory.annotation.Autowired;
import uga.menik.csx370.models.Paper;
import uga.menik.csx370.services.PaperService;
import uga.menik.csx370.services.UserService;
import uga.menik.csx370.models.BasicPaper;


import java.util.List;

/**
 * Home page – shows the most recent uploaded papers.
 */
@Controller
@RequestMapping("/")
public class HomeController {

    private final PaperService paperService;
    private final UserService userService;

    @Autowired
    public HomeController(PaperService paperService, UserService userService) {
        this.paperService = paperService;
        this.userService = userService;
    }

    /**
     * GET /
     * Show recent papers on the homepage.
     */
    @GetMapping
    public ModelAndView homepage(@RequestParam(name = "error", required = false) String error) {

        ModelAndView mv = new ModelAndView("home_page");

        // Add login info for top bar
        if (userService.isAuthenticated()) {
            mv.addObject("isLoggedIn", true);
            mv.addObject("userFirstName", userService.getLoggedInUser().getFirstName());
        } else {
            mv.addObject("isLoggedIn", false);
        }

        mv.addObject("papers", paperService.getAllBasicPapers());
        mv.addObject("errorMessage", error);

        return mv;
    }

}
