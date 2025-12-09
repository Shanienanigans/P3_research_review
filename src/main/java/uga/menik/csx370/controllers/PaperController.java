package uga.menik.csx370.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import jakarta.servlet.http.HttpServletResponse;

import java.io.File;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.UUID;
import java.util.List;

import uga.menik.csx370.models.Paper;
import uga.menik.csx370.models.Comment;
import uga.menik.csx370.models.User;
import uga.menik.csx370.services.PaperService;
import uga.menik.csx370.services.ReviewService;
import uga.menik.csx370.services.UserService;

@Controller
@RequestMapping("/papers")
public class PaperController {

    private final UserService userService;
    private final PaperService paperService;
    private final ReviewService reviewService;

    @Autowired
    public PaperController(UserService userService,
                           PaperService paperService,
                           ReviewService reviewService) {
        this.userService = userService;
        this.paperService = paperService;
        this.reviewService = reviewService;
    }

    /* -------------------------------------------------------------
       UPLOAD PAGE
    -------------------------------------------------------------- */
    @GetMapping("/upload")
    public ModelAndView uploadPage(@RequestParam(name="error", required=false) String error) {

        if (!userService.isAuthenticated()) {
            return new ModelAndView("redirect:/login");
        }

        ModelAndView mv = new ModelAndView("upload_paper_page");

        mv.addObject("isLoggedIn", true);
        mv.addObject("userFirstName", userService.getLoggedInUser().getFirstName());

        mv.addObject("errorMessage", error);
        return mv;
    }

    /* -------------------------------------------------------------
       HANDLE UPLOAD
    -------------------------------------------------------------- */
    @PostMapping("/upload")
    public String uploadPaper(@RequestParam("title") String title,
                              @RequestParam("abstract") String abstractText,
                              @RequestParam("authors") String authors,
                              @RequestParam("file") MultipartFile pdfFile) {

        if (!userService.isAuthenticated()) {
            return "redirect:/login";
        }

        try {
            String uploaderId = userService.getLoggedInUser().getUserId();

            String basePath = System.getProperty("user.dir") + "/uploads/";
            File uploadDir = new File(basePath);
            if (!uploadDir.exists()) uploadDir.mkdirs();

            String cleaned = pdfFile.getOriginalFilename().replaceAll("[^a-zA-Z0-9\\.\\-]", "_");
            String fileName = UUID.randomUUID() + "_" + cleaned;

            String filePath = basePath + fileName;

            pdfFile.transferTo(new File(filePath));

            paperService.uploadPaper(title, abstractText, authors, "uploads/" + fileName, uploaderId);

            return "redirect:/";

        } catch (IOException e) {
            e.printStackTrace();
            return "redirect:/papers/upload?error=" +
                    URLEncoder.encode("File upload failed.", StandardCharsets.UTF_8);

        } catch (Exception e) {
            e.printStackTrace();
            return "redirect:/papers/upload?error=" +
                    URLEncoder.encode("Failed to upload paper.", StandardCharsets.UTF_8);
        }
    }

    /* -------------------------------------------------------------
       VIEW PAPER PAGE  (THIS IS THE IMPORTANT FIX)
    -------------------------------------------------------------- */
    @GetMapping("/{paperId}")
    public ModelAndView viewPaper(@PathVariable String paperId) {

        ModelAndView mv = new ModelAndView("paper");

        Paper p = paperService.getPaperById(paperId);

        if (p == null) {
            mv.addObject("errorMessage", "Paper not found.");
            return mv;
        }

        mv.addObject("paper", p);
        mv.addObject("reviews", reviewService.getReviewsForPaper(paperId));

        // Login info
        if (userService.isAuthenticated()) {
            User user = userService.getLoggedInUser();
            mv.addObject("isLoggedIn", true);
            mv.addObject("userFirstName", user.getFirstName());

            // ⭐ ADD THIS — isOwner flag
            boolean isOwner = user.getUserId().equals(p.getUploader().getUserId());
            mv.addObject("isOwner", isOwner);

        } else {
            mv.addObject("isLoggedIn", false);
            mv.addObject("isOwner", false);  // guests are never owners
        }

        return mv;
    }


    /* -------------------------------------------------------------
       DOWNLOAD PDF
    -------------------------------------------------------------- */
    @GetMapping("/{paperId}/download")
    public void download(@PathVariable String paperId, HttpServletResponse response) {
        paperService.streamPdfToResponse(paperId, response);
    }

    /* -------------------------------------------------------------
       WRITE REVIEW
    -------------------------------------------------------------- */
    @GetMapping("/{paperId}/reviews/write")
    public ModelAndView writeReview(@PathVariable String paperId) {

        ModelAndView mv = new ModelAndView("review_form_page");
        mv.addObject("paperId", paperId);

        if (userService.isAuthenticated()) {
            mv.addObject("isLoggedIn", true);
            mv.addObject("userFirstName", userService.getLoggedInUser().getFirstName());
        } else {
            mv.addObject("isLoggedIn", false);
        }

        return mv;
    }

}
