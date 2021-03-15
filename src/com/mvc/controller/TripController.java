package com.mvc.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mvc.service.TripService;

@WebServlet({"/themeContentList","/areaContentList","/resultList","/search"})
public class TripController extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		String subAddr = req.getRequestURI().substring(req.getContextPath().length());
		
		TripService service = new TripService(req,resp);

		switch(subAddr) {
			case "/themeContentList":
				System.out.println("contentList 요청");
				service.contentList();
				break;
				
			case "/areaContentList":
				System.out.println("areaContentList 요청");
				service.areaContentList();
				break;
				
			case "/resultList":
				System.out.println("resultList 요청");
				service.resultList();
				break;
				
			case "/search":
				System.out.println("search 요청");
				service.search();
				break;
		}
	}
	
}