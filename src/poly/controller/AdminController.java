package poly.controller;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import poly.dto.BoardDTO;
import poly.dto.PageDTO;
import poly.dto.UserDTO;
import poly.service.IAdminService;
import poly.service.IBoardService;
import poly.util.CmmUtil;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

@Controller
public class AdminController {

    private Logger log = Logger.getLogger(this.getClass());

    @Resource(name="AdminService")
    private IAdminService adminService;

    @Resource(name="BoardService")
    private IBoardService boardService;

    @RequestMapping(value = "admin")
    public String admin(Model model, HttpSession session) {
        log.info(this.getClass().getName());

        List<UserDTO> uList = new ArrayList<>();

        String usercnt = "";
        String boardcnt = "";

        try{
            uList = adminService.getUserList();
            usercnt = adminService.getUserCount();
            boardcnt = boardService.getMaxseq();
        } catch (Exception e){
            e.printStackTrace();
        }

        model.addAttribute("uList", uList);
        session.setAttribute("usercnt", usercnt);
        session.setAttribute("boardcnt", boardcnt);
//        model.addAttribute("usercnt", usercnt);
//        model.addAttribute("boardcnt", boardcnt);

        return "adminpage/adminmain";
    }

    @RequestMapping(value="adminboard")
    public String adminboard(Model model, HttpServletRequest request) throws Exception {
        log.info("admin 리스트 조회 시작");
        log.info(this.getClass().getName());

        int page = Integer.parseInt(request.getParameter("Pno"));
        log.info("page : " + page);
        int listCnt = Integer.parseInt(boardService.getMaxseq());
        log.info("listCnt : " + listCnt);

        String usercnt = "";

        PageDTO paging = new PageDTO();

        paging.pageInfo(page, listCnt);
        HashMap<String, Integer> hMap = new HashMap<>();
        int i = paging.getStartList();
        log.info(i);
        int j = paging.getListSize();
        log.info(j);
        hMap.put("startlist", i);
        hMap.put("listsize", i+j);

        List<BoardDTO> bList = new ArrayList<>();

        try {
            bList = boardService.getBoardList(hMap);
            usercnt = adminService.getUserCount();
        } catch (Exception e) {
            e.printStackTrace();
            log.info("error");
        }

        log.info("리스트 조회 종료");

        model.addAttribute("bList",bList);
        model.addAttribute("paging", paging);

        return "adminpage/adminboard";
    }

    @RequestMapping(value="admin/groupupd")
    @ResponseBody
    public String changeGroup(HttpServletRequest request, Model model){
        log.info(this.getClass().getName());

        String groupval = CmmUtil.nvl((String)request.getParameter("groupval"));
        String userNo = CmmUtil.nvl((String)request.getParameter("userseq"));

        int result = 0;

        HashMap gMap = new HashMap<String, String>();
        gMap.put("groupval", groupval);
        gMap.put("userNo", userNo);

        log.info("group : " + groupval);
        log.info("userNo : " + userNo);

        try{
            result = adminService.updateGroup(gMap);
            log.info(result);
        } catch (Exception e) {
            e.printStackTrace();
        }

        if(result>0) {
            return "1";
        }else{
            return "0";
        }
    }

    @RequestMapping(value="admin/info")
    public String admininfopage(){
        log.info(this.getClass());

        return "/adminpage/admininfo";
    }
}
