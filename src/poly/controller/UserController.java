package poly.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import poly.dto.BoardDTO;
import poly.dto.PageDTO;
import poly.dto.UserDTO;
import poly.service.IBoardService;
import poly.service.IUserService;
import poly.service.impl.UserService;
import poly.util.CmmUtil;
import poly.util.EncryptUtil;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

@Controller
public class UserController {
	
	@Autowired
	private UserService userService;
	
	private Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name="UserService")
	private IUserService userservice;

	@Resource(name="BoardService")
	private IBoardService boardService;
	
	@RequestMapping(value="login")
	public String login() {
		log.info(this.getClass());

		return "/user/login";
	}
	
	@RequestMapping(value="register")
	public String register() {
		log.info(this.getClass());
		
		return "/user/register";
	}

	@RequestMapping(value="mypage")
	public String mypage(HttpServletRequest request, Model model, HttpSession session)throws Exception {
		log.info("리스트 조회 시작");
		log.info(this.getClass().getName());

		int page = Integer.parseInt(request.getParameter("Pno"));
		log.info("page : " + page);
		String userId = CmmUtil.nvl((String) session.getAttribute("userId"));
		log.info(userId);
		int listCnt = boardService.getMyMaxseq(userId);

		log.info("listCnt : " + listCnt);

		PageDTO paging = new PageDTO();

		paging.pageInfo(page, listCnt);
		HashMap<String, Object> hMap = new HashMap<>();
		int i = paging.getStartList();
		log.info(i);
		int j = paging.getListSize();
		log.info(j);
		hMap.put("startlist", i);
		hMap.put("listsize", i+j);
		hMap.put("userId", userId);

		List<BoardDTO> bList = new ArrayList<>();

		try {
			bList = boardService.getMyBoardList(hMap);
			log.info(bList);
		} catch (Exception e) {
			e.printStackTrace();
			log.info("error");
		}

		log.info("리스트 조회 종료");
		if(bList == null) {
			model.addAttribute("bList", "0");
			model.addAttribute("paging", "0");


		} else {
			model.addAttribute("bList", bList);
			model.addAttribute("paging", paging);
		}

		return "user/mypage";
	}

	@RequestMapping(value="inform")
	public String inform() {
		log.info(this.getClass());

		return "/user/inform";
	}

	@RequestMapping(value="deluser")
	public String deluser() {
		log.info(this.getClass());

		return "/user/deluser";
	}
	
	@RequestMapping("/userRegProc")
	public String userRegProc(HttpServletRequest request, Model model) throws Exception{

		String userId = request.getParameter("userId");
		String userEmail = request.getParameter("userEmail");
		String userPassword = request.getParameter("userPassword");

		log.info("userId 확인: "+userId);
		log.info("userEmail 확인: "+userEmail);
		log.info("userPassword 확인: "+userPassword);
		
		UserDTO uDTO = new UserDTO();
		uDTO.setUserId(userId);
		uDTO.setUserEmail(userEmail);
		
		uDTO.setUserPassword(EncryptUtil.encHashSHA256(userPassword));
		// 비밀번호 db 저장시 SHA256 암호화
		log.info("userPassword 암호화 확인 : " + uDTO.getUserPassword());
		
		int result = 0;
		
		result = userservice.userRegProc(uDTO);
		log.info("결과값: "+result);
		
		String msg, url;
		if(result == 1) {
			msg="회원가입성공";
			url="/index.do";
			model.addAttribute("msg",msg);
			model.addAttribute("url",url);
		} else {
			msg="회원가입실패";
			url="/index.do";
			model.addAttribute("msg",msg);
			model.addAttribute("url",url);
		}
		return "/redirect";
	}
	
	@RequestMapping("/userLogin")
	public String userLogin(HttpServletRequest request, HttpSession session, Model model) throws Exception{
		
		String userId = request.getParameter("userId");
		String userPassword = request.getParameter("userPassword");
		
		log.info("userId 확인: "+userId);
		log.info("userPassword 확인: "+userPassword);
		
		UserDTO uDTO = new UserDTO();
		uDTO.setUserId(userId);
		
		uDTO.setUserPassword(EncryptUtil.encHashSHA256(userPassword));
		log.info(uDTO.getUserPassword());
		// 암호화 된 password를 찾기 위해 입력값을 동일한 방법으로 암호화하여 db와 비교
		
		uDTO = userservice.getuserinfo(uDTO);
		
		
		if(uDTO == null) {
			model.addAttribute("msg", "회원정보가 없습니다.");
			model.addAttribute("url", "/index.do");
		} else {
			if(uDTO.getUserGroup().equals("3")) {
				model.addAttribute("msg", "활동 정지상태입니다. 관리자에게 문의해주세요.");
				model.addAttribute("url", "/index.do");
				session.invalidate();
			} else {
				model.addAttribute("msg", "로그인 성공");
				model.addAttribute("url", "/index.do");
				session.setAttribute("userId", uDTO.getUserId());
				session.setAttribute("userGroup", uDTO.getUserGroup());
				session.setAttribute("userEmail", uDTO.getUserEmail());
				log.info("성공");
			}
		}
		
		return "/redirect";
	}

	// 아이디 중복검사
	@RequestMapping(value = "/idCheck", method = RequestMethod.POST)
	public @ResponseBody String idCheck(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String userid = CmmUtil.nvl(request.getParameter("userid"));
		log.info("userid : " + userid);
		int count = userService.idcheck(userid);
		// String test ="ok";
		log.info("count : " + count);
		// return test;

		if (count == 0) {
			return "0";
		} else {
			return "1";
		}
	}

	@RequestMapping("/logout")
	public String logout(HttpSession session, Model model) throws Exception{

		session.invalidate();
		model.addAttribute("msg", "로그아웃 되었습니다.");
		model.addAttribute("url", "/index.do");
		return "/redirect";
	}

	@RequestMapping(value="delUserProc")
	public String delUserProc(HttpServletRequest request,HttpSession session, Model model) throws Exception{
		String userId = (String)session.getAttribute("userId");
		String userPassword = request.getParameter("userPassword");

		log.info(userId);
		log.info(userPassword);

		UserDTO uDTO = new UserDTO();
		uDTO.setUserId(userId);
		uDTO.setUserPassword(EncryptUtil.encHashSHA256(userPassword));

		log.info(uDTO.getUserId());
		log.info(uDTO.getUserPassword());

		int count = userservice.checkPw(uDTO);
		log.info(count);

		if(count == 0){
			model.addAttribute("msg", "비밀번호가 일치하지 않습니다.");
			model.addAttribute("url","/deluser.do");
		} else {
			model.addAttribute("msg","회원탈퇴가 완료되었습니다.");
			model.addAttribute("url","/index.do");
			session.invalidate();
		}

		return "/redirect";
	}

	@RequestMapping(value="updatePasswd")
	public String updatePasswd(HttpServletRequest request, HttpSession session ,Model model) throws Exception {
		String userId = (String)session.getAttribute("userId");
		String userPassword = request.getParameter("userPassword");
		String updatePassword = request.getParameter("new-password");

		log.info("userId : " + userId);
		log.info("userPassword : " + userPassword);
		log.info("updatePassword : " + updatePassword);

		UserDTO uDTO = new UserDTO();
		uDTO.setUserId(userId);
		uDTO.setUserPassword(EncryptUtil.encHashSHA256(userPassword));
		uDTO.setUpdatePassword(EncryptUtil.encHashSHA256(updatePassword));

		int count = userservice.updatePw(uDTO);
		log.info(count);

		String referer = CmmUtil.nvl((String)request.getHeader("REFERER"));

		if (count == 0){
			model.addAttribute("msg", "비밀번호가 일치하지 않습니다.");
			model.addAttribute("url", referer);
			System.out.println("변경 실패");
		} else {
			model.addAttribute("msg", "비밀번호가 변경이 완료되었습니다. 다시 로그인 해주세요.");
			model.addAttribute("url", "/index.do");
			session.invalidate();
			System.out.println("변경 성공");
		}

		return "/redirect";
	}

	@RequestMapping(value="updateEmail")
	public String updateEmail(HttpServletRequest request, HttpSession session ,Model model) throws Exception {
		String userId = (String)session.getAttribute("userId");
		String userEmail = request.getParameter("userEmail");

		log.info("userId : " + userId);
		log.info("userEmail : " + userEmail);

		UserDTO uDTO = new UserDTO();
		uDTO.setUserId(userId);
		uDTO.setUserEmail(userEmail);

		int count = userservice.updateEmail(uDTO);
		log.info(count);

		String referer = CmmUtil.nvl((String) request.getHeader("REFERER"));

		if (count == 0){
			model.addAttribute("msg", "시스템 오류");
			model.addAttribute("url", referer);
			System.out.println("변경 실패");
		} else {
			model.addAttribute("msg", "이메일 변경이 완료되었습니다.");
			model.addAttribute("url", referer);
			System.out.println("변경 성공");
		}

		return "/redirect";
	}

	@RequestMapping(value = "accsearch")
	public String accsearch() {

		log.info(this.getClass().getName());

		return "user/accountsearch";
	}

	@RequestMapping(value = "accsearch_r")
	public String accsearch_r(HttpServletRequest request, Model model) {
		log.info(this.getClass().getName());

		String userEmail = CmmUtil.nvl((String)request.getParameter("userEmail"));
		log.info(userEmail);

		String res = "";

		try{
			res = userService.getUserId(userEmail);
			log.info(res);
		} catch (Exception e){
			e.printStackTrace();
		}

		if(res!=null){
			model.addAttribute("msg", "회원님의 계정은  " + res + " 입니다.");
			model.addAttribute("url", "/login.do");
		} else {
			model.addAttribute("msg", "일치하는 회원정보가 없습니다.");
			model.addAttribute("url", "/login.do");
		}

		return "redirect";
	}

	@RequestMapping(value = "passwdsearch")
	public String passwdsearch() {
		log.info(this.getClass().getName());

		return "user/passwordsearch";
	}

	@RequestMapping(value = "resetpasswd")
	public String resetpasswd(HttpServletRequest request, Model model)throws Exception {
		log.info(this.getClass().getName());

		String userId = CmmUtil.nvl((String)request.getParameter("userId"));
		String userPassword = CmmUtil.nvl((String)request.getParameter("reset_pass"));

		UserDTO uDTO = new UserDTO();
		uDTO.setUserId(userId);
		uDTO.setUserPassword(EncryptUtil.encHashSHA256(userPassword));

		int res = 0;

		try{
			res = userService.resetPassword(uDTO);
		} catch (Exception e){
			e.printStackTrace();
		}

		if(res>0){
			model.addAttribute("msg", "비밀번호 변경이 완료되었습니다.");
			model.addAttribute("url","/login.do");
		} else {
			model.addAttribute("msg","비밀번호 변경에 실패했습니다. 다시 시도해 주세요.");
			model.addAttribute("url","/login.do");
		}

		return "redirect";
	}

}
