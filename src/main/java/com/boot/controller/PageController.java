package com.boot.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class PageController {

    @GetMapping("/map")
    public String mapPage() {
        return "map";  // /WEB-INF/views/map.jsp 로 이동
    }
}
