package egovframework.example.login.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.example.login.util.captchaServletUtil;
import jj.play.ns.nl.captcha.Captcha;

@Controller
@RequestMapping("/captcha")
public class CaptchaServlet extends HttpServlet {
 
    @Override
    @RequestMapping("/getImg.do")
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
 
        try {
            // 200 * 50 에해당하는 이미지 사이즈를 지정하고, 자동가입방지 문자 길이를 설정한다.
            Captcha captcha = new Captcha.Builder(150, 40)
                                    .addText()
                                    .addBackground()
                                    .addNoise()
                                    .addBorder()
                                    .build();
 
            response.setHeader("Cache-Control", "no-store");
            response.setHeader("Pragma", "no-cache");
            // 캐쉬를 지우기 위해 헤더값을 설정
            response.setDateHeader("Expires", 0);
            // 리턴값을 image형태로 설정
            response.setContentType("image/jpeg");
            // Image를 write 한다
            captchaServletUtil.writeImage(response, captcha.getImage());
            // 세션에 자동가입방지 문자를 저장한다.
            request.getSession().setAttribute("correctAnswer", captcha.getAnswer());
            System.out.println("captcha 자동가입방지 문자 : " + captcha.getAnswer());
        } catch (Exception e) {
            System.out.println(e.getMessage());
            System.out.println(e.getStackTrace());
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            return;
        }
 
    }
 
}