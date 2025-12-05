package uga.menik.csx370.controllers;

import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.sql.SQLException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import uga.menik.csx370.services.UserService;

@Controller
@RequestMapping("/login")
public class LoginController {

    private final UserService userService;

    @Autowired
    public LoginController(UserService userService) {
        this.userService = userService;
    }

    /** Show login page */
    @GetMapping
    public ModelAndView webpage(@RequestParam(name = "error", required = false) String error) {
        ModelAndView mv = new ModelAndView("login_page");

        mv.addObject("loggedIn", userService.isAuthenticated());
        mv.addObject("errorMessage", error);

        return mv;
    }

    /** Handle login attempt */
    @PostMapping
    public String login(@RequestParam("username") String username,
                        @RequestParam("password") String password) {

        try {
            boolean ok = userService.authenticate(username, password);

            if (ok) {
                return "redirect:/";
            } else {
                return "redirect:/login?error=" +
                        URLEncoder.encode("Invalid username or password.", StandardCharsets.UTF_8);
            }

        } catch (SQLException e) {
            return "redirect:/login?error=" +
                    URLEncoder.encode("Authentication failed.", StandardCharsets.UTF_8);
        }
    }

    /** xplicit logout endpoint */
    @GetMapping("/logout")
    public String logout() {
        userService.unAuthenticate();
        return "redirect:/login";
    }
}
