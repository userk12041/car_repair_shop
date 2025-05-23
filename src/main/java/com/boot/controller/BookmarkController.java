package com.boot.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.boot.service.BookmarkService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class BookmarkController {
	@Autowired
	BookmarkService bookmarkService;
	
	@PostMapping("/bookmark/toggle")
	@ResponseBody
	public Map<String, Object> toggleBookmark(@RequestParam int shopId, HttpSession session) {
		String userId = (String) session.getAttribute("loginId");
	    Map<String, Object> result = new HashMap<>();
	    if (userId == null) {
	        result.put("success", false);
	        result.put("message", "로그인이 필요합니다.");
	        return result;
	    }
	    log.info("controller");
	    boolean isBookmarked = bookmarkService.toggleBookmark(userId, shopId);
	    log.info("controller service 다음");
	    result.put("success", true);
	    result.put("bookmarked", isBookmarked);
	    return result;
	}


}
