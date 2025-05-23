package com.boot.controller;

import java.util.HashMap;
import java.util.Map;

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
        userDTO.setRegionDetail(param.get("detailaddress"));
        
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
            session.setAttribute("loginNickname", user.getNickname());
            session.setAttribute("loginRole", user.getRole());
            
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
    @GetMapping("/find-id")
    public String findIdForm() {
        return "findId"; // findId.jsp
    }

    @PostMapping("/find-id")
    public String findId(@RequestParam String email,
                         @RequestParam String phone_number,
                         Model model) {
        String userId = userService.findUserIdByEmailAndPhone(email, phone_number);
        if (userId != null) {
            model.addAttribute("foundId", userId);
        } else {
            model.addAttribute("notFound", true);
        }
        return "findId";
    }
    @GetMapping("/find-password")
    public String findPwForm() {
        return "findPassword"; // findPassword.jsp
    }

    @PostMapping("/find-password")
    public String findPw(@RequestParam String user_id,
                         @RequestParam String email,
                         Model model) {
        boolean match = userService.verifyUserIdAndEmail(user_id, email);
        if (match) {
            model.addAttribute("userId", user_id);
            return "resetPassword"; // 비밀번호 재설정 폼으로 이동
        } else {
            model.addAttribute("notFound", true);
            return "findPassword";
        }
    }

    @PostMapping("/reset-password")
    public String resetPassword(@RequestParam String user_id,
                                @RequestParam String newPassword) {
        userService.updatePassword(user_id, newPassword);
        return "redirect:/login";
    }

    @GetMapping("/loginCheck")
    @ResponseBody
    public Map<String, Object> checkLogin(HttpSession session) {
        Map<String, Object> response = new HashMap<>();

        // 예: 세션에서 로그인된 userId 가져오기
        String userId = (String) session.getAttribute("loginId");

        if (userId != null) {
            response.put("isLoggedIn", true);
            response.put("userId", userId);
        } else {
            response.put("isLoggedIn", false);
        }
        return response;
    }

}
