package poly.controller;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import poly.dto.MailDTO;
import poly.service.IMailService;
import poly.util.CmmUtil;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Arrays;

@Controller
public class MailController {
    private Logger log = Logger.getLogger(this.getClass());

    @Resource(name="MailService")
    private IMailService mailService;

    @RequestMapping(value = "mail/sendMail")
    @ResponseBody
    public String sendMail(HttpServletRequest request, HttpServletResponse response, ModelMap model)throws Exception{
        log.info(this.getClass().getName() + "mail.sendMail start!");

        String toMail = CmmUtil.nvl(request.getParameter("userEmail"));
        String contents = randomCord().replaceAll(", ", "");
        log.info("toMail : " + toMail);
        log.info("contents : " + contents);

        MailDTO pDTO = new MailDTO();

        pDTO.setToMail(toMail);
        pDTO.setContents(contents);

        int res = mailService.doSendMail(pDTO);

        if (res==1){
            log.info(this.getClass().getName() + "mail.sendMail success!!!");
            String result = contents.substring(1,7);
            System.out.println("result : " + result);
            return result;
        } else {
            log.info(this.getClass().getName() + "mail.sendMail fail!!!");
            return "0";
        }

    }

    public static String randomCord() {
        int[] x = new int[6];

        for(int i=0; i<6; i++){
            double dValue = Math.random();
            x[i] = (int)(dValue*10);
        }
        String cord = Arrays.toString(x);

        return cord;
    }
}


