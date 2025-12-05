package uga.menik.csx370.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import uga.menik.csx370.services.PaperService;
import uga.menik.csx370.services.UserService;

@Controller
public class AllPapersController {

    private final PaperService paperService;
    private final UserService userService;

    @Autowired
    public AllPapersController(PaperService paperService, UserService userService) {
        this.paperService = paperService;
        this.userService = userService;
    }

    @GetMapping("/papers")
    public ModelAndView listAllPapers() {

        var papers = paperService.getAllBasicPapers();

        ModelAndView mv = new ModelAndView("all_papers_page");
        mv.addObject("papers", papers);
        mv.addObject("isNoContent", papers.isEmpty());

        if (userService.isAuthenticated()) {
            mv.addObject("isLoggedIn", true);
            mv.addObject("userFirstName", userService.getLoggedInUser().getFirstName());
        } else {
            mv.addObject("isLoggedIn", false);
        }

        return mv;
    }
}
