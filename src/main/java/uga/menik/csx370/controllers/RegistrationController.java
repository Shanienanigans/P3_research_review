package uga.menik.csx370.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import uga.menik.csx370.services.UserService;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

@Controller
@RequestMapping("/register")
public class RegistrationController {

    private final UserService userService;

    @Autowired
    public RegistrationController(UserService userService) {
        this.userService = userService;
    }

    @GetMapping
    public ModelAndView webpage(@RequestParam(name = "error", required = false) String error) {
        ModelAndView mv = new ModelAndView("registration_page");
        mv.addObject("errorMessage", error);
        return mv;
    }

    @PostMapping
    public String register(@RequestParam("username") String username,
                           @RequestParam("password") String password,
                           @RequestParam("passwordRepeat") String passwordRepeat,
                           @RequestParam("firstName") String firstName,
                           @RequestParam("lastName") String lastName,
                           @RequestParam("institution") String institution,
                           @RequestParam("role") String role) throws UnsupportedEncodingException {

        if (password.trim().length() < 3) {
            String msg = URLEncoder.encode("Password must be at least 3 characters.", "UTF-8");
            return "redirect:/register?error=" + msg;
        }

        if (!password.equals(passwordRepeat)) {
            String msg = URLEncoder.encode("Passwords do not match.", "UTF-8");
            return "redirect:/register?error=" + msg;
        }

        try {
            boolean success = userService.registerUser(
                    username, password, firstName, lastName, institution, role
            );

            if (success) {
                return "redirect:/login";
            } else {
                String msg = URLEncoder.encode("Registration failed.", "UTF-8");
                return "redirect:/register?error=" + msg;
            }
        } catch (Exception e) {
            String msg = URLEncoder.encode("Error: " + e.getMessage(), "UTF-8");
            return "redirect:/register?error=" + msg;
        }
    }
}
