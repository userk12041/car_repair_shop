package com.boot.controller;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.boot.dto.UserDTO;
import com.boot.service.UserService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class UserController {
	@Autowired
	private UserService userService;
	
	@GetMapping("/register")
	public String registerForm() {
		return "register";
	}
	
	@GetMapping("/idCheck")
	@ResponseBody
	public String checkId(@RequestParam("user_id") String userId) {
	    if (userService.isUserIdAvailable(userId)) {
	        return "usable";      // 사용 가능한 아이디
	    } else {
	        return "duplicate";   // 이미 사용 중인 아이디
	    }
	}

	@GetMapping("/nickCheck")
	@ResponseBody
	public String checkNick(@RequestParam("nickname") String nickname) {
	    if (userService.isNicknameAvailable(nickname)) {
	        return "usable";      // 사용 가능
	    } else {
	        return "duplicate";   // 이미 사용 중 (프론트와 일치)
	    }
	}


    @PostMapping("/registerOk")
    public String registerUser(@RequestParam HashMap<String, String> param) {
    	log.info("@# param->"+param);
        UserDTO userDTO = new UserDTO();
        userDTO.setUserId(param.get("user_id"));
        userDTO.setPassword(param.get("password"));
        userDTO.setNickname(param.get("nickname"));
        userDTO.setPhoneNumber(param.get("phone_number"));
        userDTO.setEmail(param.get("email"));
        userDTO.setRegion(param.get("address")); // 주소를 region 필드에 저장

        userService.register(userDTO);

        return "redirect:/login";
    }
    
    @GetMapping("/login")
    public String LoginForm() {
        return "login"; // login.jsp 파일명 (확장자 생략 가능)
    }
    
    @PostMapping("/login_yn")
    public String loginCheck(@RequestParam String user_id,
                             @RequestParam String password,
                             HttpSession session,
                             Model model) {
        UserDTO user = userService.login(user_id, password);
        
        
        if (user != null) {
        	log.info("@# user 객체 => " + user);
        	log.info("@# user.getUserId() => " + user.getUserId());

            session.setAttribute("loginId", user.getUserId());
            log.info("@# session loginId=>"+session.getAttribute("loginId"));
            return "redirect:/main";  // main.jsp 매핑
        } else {
            model.addAttribute("loginError", "아이디 또는 비밀번호가 틀렸습니다.");
            return "login";  // 다시 로그인 페이지로
        }
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/main";
    }
    
    
    

}
