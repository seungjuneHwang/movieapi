package com.test.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.io.BufferedReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
/**
 * Servlet implementation class NMovieServlet
 */
@WebServlet("/nmovie")
public class NMovieServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public NMovieServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
//		response.getWriter().append("Served at: ").append(request.getContextPath());
		// 한글 처리
		request.setCharacterEncoding("utf-8");
		//search 값이 넘오는거 처리
		String search = request.getParameter("search");
		
		   String clientId = "";//애플리케이션 클라이언트 아이디값";
	       String clientSecret = "";//애플리케이션 클라이언트 시크릿값";
	       
	       // html 에서 찍을 문자열 변수
	       String jsonStr = null;
	       try {
	           String text = URLEncoder.encode(search, "UTF-8");
	           String apiURL = "https://openapi.naver.com/v1/search/movie.json?query="+ text; // json 결과
	           //String apiURL = "https://openapi.naver.com/v1/search/blog.xml?query="+ text; // xml 결과
	           URL url = new URL(apiURL);
	           HttpURLConnection con = (HttpURLConnection)url.openConnection();
	           con.setRequestMethod("GET");
	           con.setRequestProperty("X-Naver-Client-Id", clientId);
	           con.setRequestProperty("X-Naver-Client-Secret", clientSecret);
	           int responseCode = con.getResponseCode();
	           BufferedReader br;
	           if(responseCode==200) { // 정상 호출!
	               br = new BufferedReader(new InputStreamReader(con.getInputStream()));
	           } else {  // 에러 발생
	               br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
	           }
	           String inputLine;
	           StringBuffer resp = new StringBuffer();
	           while ((inputLine = br.readLine()) != null) {
	               resp.append(inputLine);
	           }
	           br.close();
//	            System.out.println(resp.toString());
//	            jsonStr = resp.toString();
				response.setCharacterEncoding("utf-8");
				response.setContentType("application/json; charset=UTF-8");
				PrintWriter out  = response.getWriter();
				out.println(resp.toString());
	       } catch (Exception e) {
	           System.out.println(e);
	       }
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
