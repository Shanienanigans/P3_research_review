package uga.menik.csx370.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import uga.menik.csx370.models.BasicPaper;
import uga.menik.csx370.models.User;
import uga.menik.csx370.services.FollowService;
import uga.menik.csx370.services.PaperService;
import uga.menik.csx370.services.UserService;

import java.util.*;

@Controller
public class HomeController {

    private final PaperService paperService;
    private final UserService userService;
    private final FollowService followService;

    @Autowired
    public HomeController(PaperService paperService,
                          UserService userService,
                          FollowService followService) {
        this.paperService = paperService;
        this.userService = userService;
        this.followService = followService;
    }

    @GetMapping("/")
    public ModelAndView home(@RequestParam(value = "error", required = false) String error) {

        ModelAndView mv = new ModelAndView("home_page");

        // 登录信息（给 top bar 用）
        User loggedIn = userService.getLoggedInUser();
        if (loggedIn != null) {
            mv.addObject("isLoggedIn", true);
            mv.addObject("userFirstName", loggedIn.getFirstName());
        } else {
            mv.addObject("isLoggedIn", false);
        }

        mv.addObject("errorMessage", error);

        // 拿到所有论文（按时间倒序）
        List<BasicPaper> papers = paperService.getAllBasicPapers();
        boolean noContent = (papers == null || papers.isEmpty());
        mv.addObject("isNoContent", noContent);

        if (noContent) {
            // 一个论文都没有，直接返回
            return mv;
        }

        // ===============================
        // 计算“我关注的作者”的论文
        // ===============================
        String loggedInId = (loggedIn != null) ? loggedIn.getUserId() : null;
        Set<String> followedIds = new HashSet<>();

        if (loggedInId != null) {
            followedIds.addAll(followService.getFollowedUserIds(loggedInId));
        }

        // 首页需要两个 list：followedPapers + otherPapers
        List<Map<String, Object>> followedModels = new ArrayList<>();
        List<Map<String, Object>> otherModels = new ArrayList<>();

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

            boolean isOwner = (loggedInId != null &&
                    loggedInId.equals(p.getUploader().getUserId()));
            map.put("isOwner", isOwner);

            boolean isFollowed = (loggedInId != null &&
                    followedIds.contains(p.getUploader().getUserId()));
            map.put("isFollowed", isFollowed);

            // 关注作者的论文，最多 5 篇
            if (isFollowed && followedModels.size() < 5) {
                followedModels.add(map);
            } else {
                otherModels.add(map);
            }
        }

        mv.addObject("hasFollowedPapers", !followedModels.isEmpty());
        mv.addObject("followedPapers", followedModels);
        mv.addObject("otherPapers", otherModels);

        return mv;
    }
}