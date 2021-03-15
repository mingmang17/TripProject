package com.mvc.service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.mvc.dao.BoardDAO;
import com.mvc.dto.BoardDTO;
import com.mvc.dto.CommentDTO;

public class BoardService {

	HttpServletRequest req=null;
	HttpServletResponse resp=null;
	String page="";
	String msg="";
	RequestDispatcher dis = null;
	
	public BoardService(HttpServletRequest req, HttpServletResponse resp) {
		this.req = req;
		this.resp = resp;
	}

	public void list() throws ServletException, IOException {
		
		String loginId = (String) req.getSession().getAttribute("loginId");
		
		if(loginId!=null) {
		String pageParam =  req.getParameter("page");
		System.out.println("page:"+pageParam);
		//한페이지 그룹 -> 1~10번
		int group =1;
		if(pageParam!=null) {
			group = Integer.parseInt(pageParam);
		}
		BoardDAO dao = new BoardDAO();
		HashMap<String, Object> map = dao.list(group);
		
		req.setAttribute("maxPage", map.get("maxPage"));
		req.setAttribute("list",map.get("list"));
		req.setAttribute("currPage", group);
		dis = req.getRequestDispatcher("boardList.jsp");
		dis.forward(req, resp);
		}else {
			resp.sendRedirect("index.jsp");
		}
	}

	public void write() throws ServletException, IOException {
		
		String loginId = (String) req.getSession().getAttribute("loginId");
		
		if(loginId!=null) { //로그인 체크
			//FileService에 우리는 파일과 관련된 내용을 추가할 예정
			FileService upload = new FileService(req);
			BoardDTO dto = upload.regist();
			System.out.println(dto.getOriFileName()+"=>"+dto.getNewFileName());//확인
			//DB저장(작성자,제목,내용 + 파일 이름)
			BoardDAO dao = new BoardDAO();
			
			page = "boardwriteForm.jsp";
			msg = "글 등록에 실패하였습니다.";
			
			long boardIdx = dao.write(dto);
//			HashMap<String, Object> map = new HashMap<String, Object>();
//			map.put("boardIdx",boardIdx);
//			Gson gson = new Gson();
//			String json = gson.toJson(map);
//			System.out.println(json);
//			resp.setContentType("text/html; charset=UTF-8");
//			resp.setHeader("Access-Control-Allow-origin", "*");
//			resp.getWriter().print(json);
			if(boardIdx>0) {
				page = "boardDetail?boardIdx="+boardIdx;
				msg = "글 등록에 성공하였습니다.";
			}
			req.setAttribute("msg", msg);
			dis = req.getRequestDispatcher(page);
			dis.forward(req, resp);		
		} else {
			resp.sendRedirect("index.jsp");
		}
		
	}

	public void detail() throws ServletException, IOException {
		
		String loginId = (String) req.getSession().getAttribute("loginId");
		
		if(loginId!=null) {
			BoardDAO dao = new BoardDAO();
			String boardIdx = req.getParameter("boardIdx");
			System.out.println("boardIdx: " +boardIdx);
			BoardDTO dto = dao.detail(boardIdx);
			System.out.println("oriFileName"+dto.getOriFileName());
			dao = new BoardDAO();
			ArrayList<CommentDTO> list = dao.comm_list(boardIdx);
			System.out.println("댓글리스트 사이즈: "+list.size());
			System.out.println("비활성화상태:"+dto.getDeactivate());
			String page="/boardList";
			
			if(dto!=null && dto.getDeactivate().equals("FALSE")) {	
				dao = new BoardDAO();
				dao.upHit(boardIdx);
				page="boarddetail.jsp";
				req.setAttribute("dto", dto);
				req.setAttribute("list", list);
			}		
			dis = req.getRequestDispatcher(page);
			dis.forward(req, resp); 
		}else{
			resp.sendRedirect("index.jsp");
		}
	}

	public void del() throws IOException, ServletException {//비활성화
		String loginId = (String) req.getSession().getAttribute("loginId");
		String isManager = (String) req.getSession().getAttribute("isManager");
		String boardIdx = req.getParameter("boardIdx");
		String id = req.getParameter("id");
		if(loginId.equals(id) || isManager.equals("true")) {//작성자와 로그인아이디가 같거나 관리자 이면
		System.out.println("delete idx : "+boardIdx);
		System.out.println("삭제할 글 작성자 아이디:"+id);	
		FileService upload = new FileService(req);

		BoardDAO dao = new BoardDAO();
		String newFileName = dao.getFileName(boardIdx);//파일명추출

		dao = new BoardDAO();
		msg="삭제 실패했습니다.";
		page="boardList";
		if(dao.del(boardIdx,newFileName)>0) {
			msg="삭제가 완료되었습니다.";
		}
		req.setAttribute("msg", msg);
		dis = req.getRequestDispatcher(page);
		dis.forward(req, resp);
//		if(success>0 && newFileName!=null) {//비활성화해도 파일은 남아있게 삭제하는부분 주석 처리
//			System.out.println("파일 삭제");
//			upload.delete(newFileName);
//		}
		
		}
	}

	public void updateForm() throws ServletException, IOException {
		
		String loginId = (String) req.getSession().getAttribute("loginId");
		String boardIdx = req.getParameter("boardIdx");
		String id = req.getParameter("id");
		BoardDAO dao = new BoardDAO();
		BoardDTO dto = dao.detail(boardIdx);
		page = "/boardList";
		if(loginId.equals(id) && dto.getDeactivate().equals("FALSE")) {//로그인아이디와 작성자 아이디가 같고 비활성화상태가 아니면
			page="boardUpdateForm.jsp";
			req.setAttribute("dto", dto);
		}
		dis = req.getRequestDispatcher(page);
		dis.forward(req, resp);
		
	}

	public void update() throws IOException {
		String loginId = (String) req.getSession().getAttribute("loginId");
		
		if(loginId!=null) {
			FileService upload = new FileService(req);
			BoardDTO dto = upload.regist();
			BoardDAO dao = new BoardDAO();
			dao.update(dto);
			if(dto.getOriFileName()!=null) {
				//업로드 파일이 있다면 기존파일 지우기, 새로운 내용을 photo에 update
				int boardIdx= dto.getBoardIdx();
				dao = new BoardDAO();
				String delFileName = dao.getFileName(String.valueOf(boardIdx));
				System.out.println("삭제할 파일명: "+ delFileName);
				dao = new BoardDAO();
				dao.updateFileName(delFileName,dto);
				
				//파일삭제
				if(delFileName!=null) {
					upload.delete(delFileName);				
				}
			}
			
			resp.sendRedirect("boardDetail?boardIdx="+dto.getBoardIdx());
		} else {
			resp.sendRedirect("index.jsp");
		}
	}

	public void commentWrite() throws ServletException, IOException {
		String comment = req.getParameter("comment");
		String boardIdx = req.getParameter("boardIdx");
		System.out.println("댓글내용:"+comment);
		System.out.println("boardIdx:"+boardIdx);
		
		String loginId = (String) req.getSession().getAttribute("loginId");
		
		if(loginId!=null) {
			BoardDAO dao = new BoardDAO();
			dao.upDown(boardIdx); //댓글등록할때도 조회수가 올라가버려서
			page="boardDetail";
			msg="댓글등록에 실패하였습니다.";
			dao = new BoardDAO();
			if(dao.commentWrite(boardIdx,comment,loginId)) {
				msg="댓글이 등록되었습니다.";
			}
			req.setAttribute("msg", msg);
			dis = req.getRequestDispatcher(page);
			dis.forward(req, resp);
			
		}else {
			resp.sendRedirect("index.jsp");
		}
		
	}

	public void commentUpdateForm() throws ServletException, IOException {
		String loginId = (String) req.getSession().getAttribute("loginId");
		String id = req.getParameter("id");
		String reIdx = req.getParameter("reIdx");
		String boardIdx = req.getParameter("boardIdx");
		System.out.println(id+"/"+reIdx+"/"+boardIdx+"/"+loginId);
		BoardDAO dao = new BoardDAO();
		CommentDTO commentUpdatedto = dao.commentUpdateForm(reIdx);
		dao = new BoardDAO();
		dao.upDown(boardIdx); //댓글수정할때도 조회수가 올라가버려서
		page = "/boardDetail?boardIdx="+boardIdx;
		if(loginId.equals(id)) {//로그인아이디와 작성자 아이디가 같으면
			req.setAttribute("commentUpdatedto", commentUpdatedto);
		}
		dis = req.getRequestDispatcher(page);
		dis.forward(req, resp);
		
	}

	public void commentUpdate() throws ServletException, IOException {
		String loginId = (String) req.getSession().getAttribute("loginId");
		String id = req.getParameter("id");
		String reIdx = req.getParameter("reIdx");
		String boardIdx = req.getParameter("boardIdx");
		String comment = req.getParameter("comment");
		System.out.println(id+"/"+reIdx+"/"+boardIdx+"/"+loginId);
		
		if(loginId.equals(id)) {
			BoardDAO dao = new BoardDAO();
			dao.upDown(boardIdx); //댓글수정할때도 조회수가 올라가버려서
			page="/boardDetail?boardIdx="+boardIdx;
			msg="댓글 수정에 실패하였습니다.";
			dao = new BoardDAO();
			if(dao.commentUpdate(reIdx, comment)) {
				msg="댓글 수정이 완료되었습니다.";
			}
			req.setAttribute("msg", msg);
			dis = req.getRequestDispatcher(page);
			dis.forward(req, resp);
		}		
	}

	public void commentDel() throws ServletException, IOException {
		String loginId = (String) req.getSession().getAttribute("loginId");
		String isManager = (String) req.getSession().getAttribute("isManager");
		String id = req.getParameter("id");
		String reIdx = req.getParameter("reIdx");
		String boardIdx = req.getParameter("boardIdx");
		System.out.println(id+"/"+reIdx+"/"+boardIdx+"/"+loginId);
		page="/boardDetail?boardIdx="+boardIdx;
		BoardDAO dao = new BoardDAO();
		dao.upDown(boardIdx); //댓글삭제할때도 조회수가 올라가버려서
		if(loginId.equals(id) || isManager.equals("true")) {//본인이거나 관리자일때
			msg="댓글 삭제에 실패했습니다.";
			dao = new BoardDAO();
			if(dao.commentDel(reIdx)) {
				msg="댓글 삭제에 성공했습니다.";
			}
		}
		req.setAttribute("msg",msg);
		dis = req.getRequestDispatcher(page);
		dis.forward(req, resp);
	}

	public void boardSearch() throws ServletException, IOException {
		String searchType = req.getParameter("searchType");
		String keyword = req.getParameter("keyword");
		System.out.println(searchType+"/"+keyword);
		String pageParam =  req.getParameter("page");
		System.out.println("page:"+pageParam);
		int group =1;
		if(pageParam!=null) {
			group = Integer.parseInt(pageParam);
		}
		BoardDAO dao = new BoardDAO();
		String url = "searchType=" + searchType + "&keyword=" + keyword;
		
		HashMap<String, Object> map = dao.boardSearch(group,searchType,keyword);
		System.out.println(map.get("maxPage"));
		req.setAttribute("maxPage", map.get("maxPage"));
		req.setAttribute("url", url);
		req.setAttribute("list",map.get("list"));
		req.setAttribute("currPage", group);
		dis = req.getRequestDispatcher("boardList.jsp");
		dis.forward(req, resp);
	}
}