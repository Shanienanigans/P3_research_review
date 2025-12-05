package uga.menik.csx370.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

import uga.menik.csx370.models.User;
import uga.menik.csx370.models.Paper;
import uga.menik.csx370.services.UserService;
import uga.menik.csx370.services.PaperService;

@Controller
@RequestMapping("/users")
public class UserController {

    private final UserService userService;
    private final PaperService paperService;

    @Autowired
    public UserController(UserService userService, PaperService paperService) {
        this.userService = userService;
        this.paperService = paperService;
    }

    @GetMapping
    public ModelAndView listUsers() {
        ModelAndView mv = new ModelAndView("users_page");

        List<User> users = userService.getAllUsers();
        mv.addObject("users", users);

        mv.addObject("isNoContent", users.isEmpty());
        return mv;
    }

    @GetMapping("/{userId}")
    public ModelAndView userProfile(@PathVariable("userId") String userId) {

        ModelAndView mv = new ModelAndView("profile_page");

        User target = userService.getUserById(userId);
        mv.addObject("user", target);

        if (target == null) {
            mv.addObject("errorMessage", "User not found.");
            return mv;
        }

        List<Paper> uploads = paperService.getPapersByUploader(userId);
        mv.addObject("papers", uploads);
        mv.addObject("reviews", null);
        mv.addObject("isNoContent", uploads.isEmpty());

        return mv;
    }
}
