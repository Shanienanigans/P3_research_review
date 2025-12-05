package uga.menik.csx370.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import uga.menik.csx370.services.UserService;

@Controller
public class LogoutController {

    private final UserService userService;

    public LogoutController(UserService userService) {
        this.userService = userService;
    }

    @GetMapping("/logout")
    public String logout() {
        userService.unAuthenticate();
        return "redirect:/login";
    }
}
