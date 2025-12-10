package uga.menik.csx370.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import uga.menik.csx370.models.User;
import uga.menik.csx370.services.FollowService;
import uga.menik.csx370.services.UserService;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

/**
 * Authors 页面：
 * - /authors  列出所有作者 + 搜索
 * - 在列表里点击可以进入 /profile/{userId}
 * - 支持 Follow / Unfollow 作者
 */
@Controller
@RequestMapping("/authors")
public class AuthorsController {

    private final UserService userService;
    private final FollowService followService;

    @Autowired
    public AuthorsController(UserService userService,
                             FollowService followService) {
        this.userService = userService;
        this.followService = followService;
    }

    /**
     * GET /authors
     * 显示所有作者或搜索结果
     */
    @GetMapping
    public ModelAndView listAuthors(
            @RequestParam(name = "q", required = false) String query) {

        String trimmed = (query == null) ? "" : query.trim();

        // 1. 基础作者列表
        List<User> baseAuthors;
        if (trimmed.isEmpty()) {
            // 所有 role='author' 的用户
            baseAuthors = userService.getResearchers();
        } else {
            // 搜索作者
            baseAuthors = userService.searchAuthors(trimmed);
        }

        // 2. 当前登录用户 & 已关注列表
        String currentUserId = null;
        Set<String> followedIds = new HashSet<>();

        if (userService.isAuthenticated()) {
            currentUserId = userService.getLoggedInUser().getUserId();
            followedIds.addAll(followService.getFollowedUserIds(currentUserId));
        }

        // 3. 构造给 Mustache 用的 authors 数组，每个元素有：
        //    userId / firstName / lastName / institution / profileImagePath
        //    isSelf / isFollowed
        List<Map<String, Object>> authors = new ArrayList<>();

        for (User u : baseAuthors) {
            Map<String, Object> row = new HashMap<>();
            row.put("userId", u.getUserId());
            row.put("firstName", u.getFirstName());
            row.put("lastName", u.getLastName());
            row.put("institution", u.getInstitution());
            row.put("role", u.getRole());
            row.put("profileImagePath", u.getProfileImagePath());

            boolean isSelf = currentUserId != null && currentUserId.equals(u.getUserId());
            boolean isFollowed = currentUserId != null && followedIds.contains(u.getUserId());

            row.put("isSelf", isSelf);
            row.put("isFollowed", isFollowed);

            authors.add(row);
        }

        ModelAndView mv = new ModelAndView("authors_page");
        mv.addObject("authors", authors);
        mv.addObject("query", trimmed);
        mv.addObject("isNoContent", authors.isEmpty());

        // 顶部导航栏需要的登录信息
        if (userService.isAuthenticated()) {
            mv.addObject("isLoggedIn", true);
            mv.addObject("userFirstName", userService.getLoggedInUser().getFirstName());
        } else {
            mv.addObject("isLoggedIn", false);
        }

        return mv;
    }

    /**
     * POST /authors/{userId}/follow
     * 在 Authors 列表中点击 follow/unfollow 后处理提交
     */
    @PostMapping("/{userId}/follow")
    public String followAuthor(@PathVariable("userId") String authorId,
                               @RequestParam("action") String action) {

        if (!userService.isAuthenticated()) {
            // 未登录则跳转登录
            return "redirect:/login";
        }

        String currentUserId = userService.getLoggedInUser().getUserId();

        if ("follow".equalsIgnoreCase(action)) {
            followService.follow(currentUserId, authorId);
        } else if ("unfollow".equalsIgnoreCase(action)) {
            followService.unfollow(currentUserId, authorId);
        }

        // 回到作者列表（简单处理，不保留原搜索条件）
        return "redirect:/authors";
    }
}