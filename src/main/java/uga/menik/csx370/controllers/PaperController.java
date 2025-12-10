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

        var user = userService.getLoggedInUser();
        // add：role info// add：role info
        String role = user.getRole();  // "researcher" / "reviewer" / "admin"
        mv.addObject("userRole", role);
        mv.addObject("isResearcher", "researcher".equalsIgnoreCase(role));
        mv.addObject("isReviewer", "reviewer".equalsIgnoreCase(role));
        mv.addObject("isAdmin", "admin".equalsIgnoreCase(role));


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
            
            // add：role info// add：role info
            String role = user.getRole();  // "researcher" / "reviewer" / "admin"
            mv.addObject("userRole", role);
            mv.addObject("isResearcher", "researcher".equalsIgnoreCase(role));
            mv.addObject("isReviewer", "reviewer".equalsIgnoreCase(role));
            mv.addObject("isAdmin", "admin".equalsIgnoreCase(role));
            
            // 判断是否是这篇论文的作者（按你 uploadPaper 里用的 uploaderId 来比）
            //boolean isAuthor = p.getUploaderId().equals(user.getUserId());
            boolean isAuthor = p.getUploader().getUserId().equals(user.getUserId());
            mv.addObject("isAuthor", isAuthor);
       
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

    /* -------------------------------------------------------------
       DISCUSSION POST
    -------------------------------------------------------------- */
    @PostMapping("/{paperId}/discussion/add")
    public String addDiscussion(@PathVariable String paperId,
                                @RequestParam String comment) {

        System.out.println("DISCUSSION COMMENT RECEIVED: " + comment);

        return "redirect:/papers/" + paperId;
    }



    /* -------------------------------------------------------------
       EDIT PAPER PAGE (only author or admin)
    -------------------------------------------------------------- */
    @GetMapping("/{paperId}/edit")
    public ModelAndView editPaperPage(@PathVariable String paperId,
                                      @RequestParam(name = "error", required = false) String error) {

        if (!userService.isAuthenticated()) {
            return new ModelAndView("redirect:/login");
        }

        var user = userService.getLoggedInUser();
        String role = user.getRole();

        Paper p = paperService.getPaperById(paperId);
        if (p == null) {
            return new ModelAndView("redirect:/?error=Paper+not+found");
        }

        boolean isAuthor = p.getUploader().getUserId().equals(user.getUserId());
        boolean isAdmin = "admin".equalsIgnoreCase(role);

        // 只有作者本人或 admin 可以编辑
        if (!isAuthor && !isAdmin) {
            return new ModelAndView("redirect:/papers/" + paperId);
        }

        ModelAndView mv = new ModelAndView("edit_paper_page");
        mv.addObject("paper", p);

        mv.addObject("isLoggedIn", true);
        mv.addObject("userFirstName", user.getFirstName());
        mv.addObject("userRole", role);
        mv.addObject("isResearcher", "researcher".equalsIgnoreCase(role) || "author".equalsIgnoreCase(role));
        mv.addObject("isReviewer", "reviewer".equalsIgnoreCase(role));
        mv.addObject("isAdmin", isAdmin);

        mv.addObject("isAuthor", isAuthor);
        mv.addObject("errorMessage", error);

        return mv;
    }


    /* -------------------------------------------------------------
       HANDLE EDIT SUBMIT
    -------------------------------------------------------------- */
    @PostMapping("/{paperId}/edit")
    public String editPaper(@PathVariable String paperId,
                            @RequestParam("title") String title,
                            @RequestParam("abstract") String abstractText,
                            @RequestParam("authors") String authors,
                            @RequestParam(value = "file", required = false) MultipartFile pdfFile) {

        if (!userService.isAuthenticated()) {
            return "redirect:/login";
        }

        var user = userService.getLoggedInUser();
        String role = user.getRole();

        Paper p = paperService.getPaperById(paperId);
        if (p == null) {
            return "redirect:/?error=Paper+not+found";
        }

        boolean isAuthor = p.getUploader().getUserId().equals(user.getUserId());
        boolean isAdmin = "admin".equalsIgnoreCase(role);
        if (!isAuthor && !isAdmin) {
            return "redirect:/papers/" + paperId;
        }

        try {
            String newFilePath = null;

            // 如果上传了新 PDF，则保存新文件并更新路径
            if (pdfFile != null && !pdfFile.isEmpty()) {
                String basePath = System.getProperty("user.dir") + "/uploads/";
                File uploadDir = new File(basePath);
                if (!uploadDir.exists()) uploadDir.mkdirs();

                String cleaned = pdfFile.getOriginalFilename().replaceAll("[^a-zA-Z0-9\\.\\-]", "_");
                String fileName = UUID.randomUUID() + "_" + cleaned;
                String filePath = basePath + fileName;

                pdfFile.transferTo(new File(filePath));
                newFilePath = "uploads/" + fileName;
            }

            boolean ok = paperService.updatePaper(paperId, title, abstractText, authors, newFilePath);
            if (!ok) {
                return "redirect:/papers/" + paperId + "/edit?error=" +
                        URLEncoder.encode("Failed to update paper.", StandardCharsets.UTF_8);
            }

            return "redirect:/papers/" + paperId;

        } catch (Exception e) {
            e.printStackTrace();
            return "redirect:/papers/" + paperId + "/edit?error=" +
                    URLEncoder.encode("Failed to update paper.", StandardCharsets.UTF_8);
        }
    }


}
