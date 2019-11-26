package poly.controller;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import poly.dto.NlpDTO;
import poly.service.INlpService;
import poly.util.CmmUtil;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Controller
public class NlpController {
    private Logger log = Logger.getLogger(this.getClass());

    @Resource(name = "NlpService")
    private INlpService nlpService;

    @RequestMapping(value = "nlp/wordAnalysis")
    @ResponseBody
    public String wordAnalysis(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception{

        log.info(this.getClass().getName() + ".wordAnalysis start!");

        String seq = CmmUtil.nvl(request.getParameter("seq"));

        String text = nlpService.getBoardContent(seq);

        String text_message = "";

        if(text.matches(".*[ㄱ-ㅎㅏ-ㅣ가-힣]+.*")) {
            String text2 = text.replaceAll("[^ㄱ-ㅎㅏ-ㅣ가-힣\\s]+", "");
            text_message = text2.trim();
            log.info("텍스트 내용 : " + text_message);
        } else {
            text_message = "영어 분석";
        }

        NlpDTO pDTO = new NlpDTO();

        pDTO.setWord(text_message);

        int point = nlpService.preProcessWordAnalysisForMind(pDTO);
        log.info(point);

        if (point < 0) {
            return "-1";
        }else if (point == 0) {
            return "0";
        } else {
            return "1";
        }
    }
}
