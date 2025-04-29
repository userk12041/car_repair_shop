package com.boot.controller;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

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
//	
//	@GetMapping("/idCheck")
//    @ResponseBody
//	public String checkId(@RequestParam("user_id") String userId) {
//		if(userService.isUserIdAvailable(userId)) {
//			return "true";
//		}
//		else {
//			return "false";
//		}
//	}
//    @GetMapping("/nickCheck")
//    @ResponseBody
//    public String checkNick(@RequestParam("nickname") String nickname) {
//        if (userService.isNicknameAvailable(nickname)) {
//            return "usable";
//        } else {
//            return "unusable";
//        }
//    }

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
}
