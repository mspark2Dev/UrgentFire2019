package poly.controller;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import poly.dto.BoardDTO;
import poly.dto.PageDTO;
import poly.service.IBoardService;
import poly.util.CmmUtil;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

@Controller
public class BoardController {

    private Logger log = Logger.getLogger(this.getClass());

    @Resource(name = "BoardService")
    private IBoardService boardService;

    @RequestMapping(value = "Board/BoardReg")
    public String RegBoard() {
        log.info(this.getClass().getName());

        return "review/reviewReg";
    }

    @RequestMapping(value = "Board/BoardList")
    public String review(Model model, HttpServletRequest request) throws Exception {
        log.info("리스트 조회 시작");
        log.info(this.getClass().getName());

        int page = Integer.parseInt(request.getParameter("Pno"));
        log.info("page : " + page);
        int listCnt = Integer.parseInt(boardService.getMaxseq());
        log.info("listCnt : " + listCnt);

            PageDTO paging = new PageDTO();

            paging.pageInfo(page, listCnt);
            HashMap<String, Integer> hMap = new HashMap<>();
            int i = paging.getStartList();
            log.info(i);
            int j = paging.getListSize();
            log.info(j);
            hMap.put("startlist", i);
            hMap.put("listsize", i + j);

            List<BoardDTO> bList = new ArrayList<>();

            try {
                bList = boardService.getBoardList(hMap);
                log.info(bList);
            } catch (Exception e) {
                e.printStackTrace();
                log.info("error");
            }

            log.info("리스트 조회 종료");

            model.addAttribute("bList", bList);
            model.addAttribute("paging", paging);

            return "review/reviewList";
    }

    @RequestMapping(value = "Board/BoardRegProc")
    public String BoardRegProc(HttpServletRequest request, Model model, HttpSession session) {
        log.info(this.getClass().getName());

        String title = request.getParameter("title");
        String content = request.getParameter("content");
        String regId = (String) session.getAttribute("userId");

        log.info(title);
        log.info(content);

        BoardDTO bDTO = new BoardDTO();
        bDTO.setContent(content);
        bDTO.setTitle(title);
        bDTO.setRegId(regId);

        int result = 0;

        try {
            result = boardService.insertBoardInfo(bDTO);
        } catch (Exception e) {
            e.printStackTrace();
        }

        if (result > 0) {
            model.addAttribute("url", "/Board/BoardList.do?Pno=1");
            model.addAttribute("msg", "등록되었습니다.");
        } else {
            model.addAttribute("url", "/Board/BoardReg.do");
            model.addAttribute("msg", "등록에 실패했습니다.");
        }

        return "/redirect";
    }

    @RequestMapping(value = "Board/BoardDetail")
    public String BoardDetail(HttpServletRequest request, Model model, HttpSession session) {
        log.info(this.getClass().getName());

        String seq = request.getParameter("seq");
        String maxseq = "";
        log.info(seq);

        BoardDTO bDTO = new BoardDTO();

        try {
            bDTO = boardService.getBoardDetail(seq);
            maxseq = boardService.getMaxseq();

            log.info(maxseq);
        } catch (Exception e) {
            e.printStackTrace();
        }

        model.addAttribute("bDTO", bDTO);
        session.setAttribute("maxseq", maxseq);

        log.info("BoardDetail 종료");

//        return "review/reviewDetail";

        return "/review/reviewDetail";
    }

    @RequestMapping(value = "Board/BoardNoticeY")
    public String BoardNotice(HttpServletRequest request, Model model) {
        log.info(this.getClass().getName());

        String seq = request.getParameter("seq");
        log.info("seq : " + seq);

        int result = 0;

        String referer = request.getHeader("REFERER");

        try {
            result = boardService.setNotice(seq);
            log.info(result);
        } catch (Exception e) {
            e.printStackTrace();
        }

        if (result > 0) {
            model.addAttribute("msg", "공지등록 되었습니다.");
            model.addAttribute("url", referer);
        } else {
            model.addAttribute("msg", "공지등록에 실패했습니다.");
            model.addAttribute("url", referer);
        }

        return "/redirect";
    }

    @RequestMapping(value = "Board/BoardNoticeN")
    public String BoardNoticeN(HttpServletRequest request, Model model) {
        log.info(this.getClass().getName());

        String seq = request.getParameter("seq");
        log.info("seq : " + seq);

        int result = 0;

        String referer = request.getHeader("REFERER");

        try {
            result = boardService.setNoticeN(seq);
            log.info(result);
        } catch (Exception e) {
            e.printStackTrace();
        }

        if (result > 0) {
            model.addAttribute("msg", "공지해제 되었습니다.");
            model.addAttribute("url", referer);
        } else {
            model.addAttribute("msg", "공지해제에 실패했습니다.");
            model.addAttribute("url", referer);
        }

        return "/redirect";
    }

    @RequestMapping(value = "Board/BoardDeleteProc")
    public String BoardDeleteProc(HttpServletRequest request, Model model) {
        log.info(this.getClass().getName());

        String seq = request.getParameter("seq");
        log.info("seq : " + seq);

        int result = 0;

        String referer = CmmUtil.nvl(request.getHeader("REFERER"));

        try {
            result = boardService.deleteBoardProc(seq);
            log.info(result);
        } catch (Exception e) {
            e.printStackTrace();
        }

        if (result > 0) {
            model.addAttribute("msg", "글삭제가 완료되었습니다.");
            model.addAttribute("url", "/Board/BoardList.do?Pno=1");
        } else {
            model.addAttribute("msg", "글삭제에 실패하였습니다.");
            model.addAttribute("url", referer);
        }

        return "/redirect";
    }

    @RequestMapping(value = "Board/BoardModify")
    public String BoardModify(HttpServletRequest request, Model model) {
        log.info(this.getClass().getName());

        String seq = request.getParameter("seq");
        log.info("seq : " + seq);

        BoardDTO bDTO = new BoardDTO();

        try {
            bDTO = boardService.getBoardDetail(seq);
        } catch (Exception e) {
            e.printStackTrace();
        }

        model.addAttribute("bDTO", bDTO);

        return "/review/reviewModify";
    }

    @RequestMapping(value = "Board/BoardModifyProc")
    public String BoardUpdateProc(HttpServletRequest request, Model model) {
        log.info(this.getClass());

        String title = request.getParameter("title");
        String content = request.getParameter("content");
        String seq = request.getParameter("seq");
        log.info(title);
        log.info(content);
        log.info(seq);

        BoardDTO bDTO = new BoardDTO();
        bDTO.setTitle(title);
        log.info(bDTO.getTitle());
        bDTO.setContent(content);
        log.info(bDTO.getContent());
        bDTO.setSeq(seq);
        log.info(bDTO.getSeq());

        String referer = CmmUtil.nvl(request.getHeader("REFERER"));

        int result = 0;

        try {
            result = boardService.UpdateBoardInfo(bDTO);
        } catch (Exception e) {
            e.printStackTrace();
        }
        if (result > 0) {
            model.addAttribute("msg", "글 수정이 완료되었습니다.");
            model.addAttribute("url", "/Board/BoardList.do?Pno=1");
        } else {
            model.addAttribute("msg", "글 수정에 실패했습니다.");
            model.addAttribute("url", referer);
        }
        return "/redirect";
    }
}
