<%@page import="com.google.gson.reflect.TypeToken"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.google.gson.JsonParser"%>
<%@page import="com.google.gson.JsonElement"%>
<%@page import="com.google.gson.JsonArray"%>
<%@page import="com.google.gson.JsonObject"%>
<%@page import="com.test.vo.NaverApiVO"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.List"%>
<%@page import="com.test.vo.MovieVO"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.net.URL"%>
<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	// 한글 처리
	request.setCharacterEncoding("utf-8");
	//search 값이 넘오는거 처리
	String search = request.getParameter("search");
	
	   String clientId = "";//애플리케이션 클라이언트 아이디값";
       String clientSecret = "";//애플리케이션 클라이언트 시크릿값";
       
       // html 에서 찍을 문자열 변수
       String jsonStr = null;
       // 임시 고정 값
       search = "토이스토리";
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
//            System.out.println(resp.toString());
//            jsonStr = resp.toString();
			response.setCharacterEncoding("utf-8");
			response.setContentType("application/json; charset=UTF-8");
			
		
			resp.setLength(resp.length()-1);
			int end = resp.indexOf("[");
			resp.delete(0, end-1);
// 			out.println(resp.toString());
			String json = resp.toString();
			
			Gson gson = new Gson();
			// 이거 써도 되고
// 			MovieVO[] arr = gson.fromJson(json, MovieVO[].class);
// 			List<MovieVO> mcList = Arrays.asList(arr);

			// 이거 써도 되고
			TypeToken<List<MovieVO>> token = new TypeToken<List<MovieVO>>() {};
			List<MovieVO> mcList = gson.fromJson(json, token.getType());
			
			for (MovieVO vo : mcList) {
				System.out.println(vo.getTitle());
				System.out.println(vo.getImage());
				System.out.println(vo.getLink());
			}
	
			
       } catch (Exception e) {
           System.out.println(e);
       }

%>