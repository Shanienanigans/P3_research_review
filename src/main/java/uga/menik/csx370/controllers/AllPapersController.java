package uga.menik.csx370.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import uga.menik.csx370.models.BasicPaper;
import uga.menik.csx370.models.User;
import uga.menik.csx370.services.PaperService;
import uga.menik.csx370.services.UserService;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

        User loggedIn = userService.getLoggedInUser();
        String loggedInId = (loggedIn != null) ? loggedIn.getUserId() : null;

        var papers = paperService.getAllBasicPapers();

        // ⭐ Transform each paper into a model Map to include `isOwner`
        List<Map<String, Object>> paperModels = new ArrayList<>();

        for (BasicPaper p : papers) {
            Map<String, Object> map = new HashMap<>();

            map.put("paperId", p.getPaperId());
            map.put("title", p.getTitle());
            map.put("abstractSnippet", p.getAbstractSnippet());
            map.put("thumbnail", p.getThumbnail());
            map.put("uploadDate", p.getUploadDate());
            map.put("avgScore", p.getAvgScore());
            map.put("reviewCount", p.getReviewCount());
            map.put("uploader", p.getUploader());

            // ⭐ IMPORTANT: determine whether logged-in user uploaded this paper
            boolean isOwner = (loggedInId != null &&
                    loggedInId.equals(p.getUploader().getUserId()));
            map.put("isOwner", isOwner);

            paperModels.add(map);
        }

        ModelAndView mv = new ModelAndView("all_papers_page");
        mv.addObject("papers", paperModels);
        mv.addObject("isNoContent", papers.isEmpty());

        if (loggedIn != null) {
            mv.addObject("isLoggedIn", true);
            mv.addObject("userFirstName", loggedIn.getFirstName());

            var user = userService.getLoggedInUser();
            // add：role info// add：role info
            String role = user.getRole();  // "researcher" / "reviewer" / "admin"
            mv.addObject("userRole", role);
            mv.addObject("isResearcher", "researcher".equalsIgnoreCase(role));
            mv.addObject("isReviewer", "reviewer".equalsIgnoreCase(role));
            mv.addObject("isAdmin", "admin".equalsIgnoreCase(role));

        } else {
            mv.addObject("isLoggedIn", false);
        }

        return mv;
    }
}

