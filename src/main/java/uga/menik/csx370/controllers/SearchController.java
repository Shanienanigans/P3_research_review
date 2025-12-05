package uga.menik.csx370.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import uga.menik.csx370.services.PaperService;

@Controller
public class SearchController {

    private final PaperService paperService;

    @Autowired
    public SearchController(PaperService paperService) {
        this.paperService = paperService;
    }

    @GetMapping("/search")
    public ModelAndView search(@RequestParam("query") String query) {

        ModelAndView mv = new ModelAndView("search_results_page");

        String trimmed = query.trim();
        var results = paperService.searchPapers(trimmed);

        mv.addObject("query", trimmed);
        mv.addObject("papers", results);
        mv.addObject("isNoContent", results.isEmpty());

        return mv;
    }
}
