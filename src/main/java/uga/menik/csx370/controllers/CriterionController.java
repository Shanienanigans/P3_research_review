package uga.menik.csx370.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.List;

import uga.menik.csx370.models.Criterion;
import uga.menik.csx370.services.CriterionService;
import uga.menik.csx370.services.UserService;

/**
 * Admin-only criterion management.
 */
@Controller
@RequestMapping("/criteria")
public class CriterionController {

    private final CriterionService criterionService;
    private final UserService userService;

    @Autowired
    public CriterionController(CriterionService criterionService,
                               UserService userService) {
        this.criterionService = criterionService;
        this.userService = userService;
    }

    /**
     * GET /criteria — List all criteria (admin only)
     */
    @GetMapping
    public ModelAndView showCriteriaPage(
            @RequestParam(name = "error", required = false) String error) {

        ModelAndView mv = new ModelAndView("criteria_page");

        // Very simple admin check (userId="1" for admin)
        if (!userService.isAuthenticated() ||
            !userService.getLoggedInUser().getRole().equals("admin")) {

            mv.addObject("errorMessage", "Only admin users can manage review criteria.");
            return mv;
        }

        List<Criterion> list = criterionService.getAllCriteria();
        mv.addObject("criteria", list);

        if (error != null) mv.addObject("errorMessage", error);

        return mv;
    }

    /**
     * POST /criteria/add
     */
    @PostMapping("/add")
    public String addCriterion(@RequestParam("name") String name,
                               @RequestParam("description") String description) {

        try {
            criterionService.addCriterion(name.trim(), description.trim());
        } catch (Exception e) {
            String msg = URLEncoder.encode("Failed to add criterion.", StandardCharsets.UTF_8);
            return "redirect:/criteria?error=" + msg;
        }

        return "redirect:/criteria";
    }

    /**
     * POST /criteria/delete
     */
    @PostMapping("/delete")
    public String deleteCriterion(@RequestParam("id") String id) {

        try {
            criterionService.deleteCriterion(id);
        } catch (Exception e) {
            String msg = URLEncoder.encode("Failed to delete criterion.", StandardCharsets.UTF_8);
            return "redirect:/criteria?error=" + msg;
        }

        return "redirect:/criteria";
    }
}
