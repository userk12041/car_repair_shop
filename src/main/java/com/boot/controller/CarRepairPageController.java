package com.boot.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.boot.dao.CarRepairDAO;
import com.boot.dto.CarRepairDTO;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/repairShop")
@RequiredArgsConstructor
public class CarRepairPageController {

    private final CarRepairDAO carRepairDAO;

    @GetMapping("/view")
    public String detailPage(@RequestParam("id") int id, Model model) {
        CarRepairDTO shop = carRepairDAO.getRepairById(id);
        model.addAttribute("shop", shop);
        return "view";  // view.jsp 로 이동
    }
}
