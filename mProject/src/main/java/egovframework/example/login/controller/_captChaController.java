package egovframework.example.login.controller;

import java.awt.Color;
import java.awt.Font;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.OutputStream;
import java.util.Arrays;
import java.util.List;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.google.gson.JsonObject;

import nl.captcha.Captcha;
import nl.captcha.backgrounds.GradiatedBackgroundProducer;
import nl.captcha.text.producer.DefaultTextProducer;
import nl.captcha.text.renderer.DefaultWordRenderer;




@Controller
@RequestMapping("/captcha123")
public class _captChaController {
	
	@Autowired
    private HttpServletRequest request;
	
	@RequestMapping("/getImg")
	public void getImg(final HttpServletResponse response) throws IOException{
		System.out.println("test1");
		int width = Integer.parseInt(request.getParameter("width")!=null ? request.getParameter("width") : "150");
		int height = Integer.parseInt(request.getParameter("width")!=null ? request.getParameter("height") : "20");
		int size = Integer.parseInt(request.getParameter("width")!=null ? request.getParameter("size") : "30");

		List<java.awt.Color> textColors = Arrays.asList(Color.BLACK);
		List<java.awt.Font> textFonts = Arrays.asList(
			new Font("Arial", Font.ITALIC, size), 
			new Font("Courier", Font.PLAIN, size));
		
		try{
    		Captcha captcha = new Captcha.Builder(width, height)
    			/*defulat로 5개의 랜덤한 알파벳과 숫자를 생성*/
    			.addText(new DefaultTextProducer(), new DefaultWordRenderer(textColors, textFonts))
    			.addBackground(new GradiatedBackgroundProducer()) /*Gradiated백그라운드 효과 추가*/
    			.addNoise()    /*한번 호출할 떄마다 하나의 라인이 추가된다*/
    			//.gimp() /*그림자 효과 추가*/
    			.addBorder()  /*검정 테두리 선 생성*/
    			.build();  /*필수 호출함수*/
    	
    	    response.setHeader("Cache-Control", "no-store");
            response.setHeader("Pragma", "no-cache");

            // 캐쉬를 지우기 위해 헤더값을 설정
            response.setDateHeader("Expires", 0);

            // 리턴값을 image형태로 설정
            response.setContentType("image/jpeg");

            // Image를 write 한다
            writeImage(response, captcha.getImage());

            // 세션에 자동가입방지 문자를 저장한다.
            request.getSession().setAttribute(Captcha.NAME, captcha);
    	}catch(Exception e){
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            return;
    	}
    }

	

	@RequestMapping("/isCorrect")

	public String isCorrect(String answer, ModelMap model){
		Captcha captcha = (Captcha) request.getSession().getAttribute(Captcha.NAME);
		boolean result = false;
		if(captcha.isCorrect(answer)){
			result = true;
		}
		JsonObject obj = new JsonObject();
		obj.addProperty("result", result);
		model.addAttribute( "obj", obj ); 
		return "obj";
	}

    

    public static void writeImage(HttpServletResponse response, BufferedImage bi) {

        response.setHeader("Cache-Control", "private,no-cache,no-store");
        response.setContentType("image/png");
        
        try {
            writeImage(response.getOutputStream(), bi);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }



    public static void writeImage(OutputStream os, BufferedImage bi) {

        try {
            ImageIO.write(bi, "png", os);
            os.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
