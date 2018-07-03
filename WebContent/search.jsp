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
//        search = "토이스토리";
       try {
           String text = URLEncoder.encode(search, "UTF-8");
           String apiURL = "https://openapi.naver.com/v1/search/news.json?query="+ text; // json 결과
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
			out.println(resp.toString());
			String json = resp.toString();
			
// 			Gson gson = new Gson();
			
			// json 문자열을 element 로 받아서 파싱(문자열 분석)
			JsonElement jelement = new JsonParser().parse(json);
			// json 형태의 오브젝트를 가져온다.
			JsonObject  jobject = jelement.getAsJsonObject();
			// imtes 안에 있는 배열을 가져오고
		    JsonArray jarray = jobject.getAsJsonArray("items");
			// 배열 순서 중에 get(반복문의 배열 안 인덱스 번호)를 가져와서
			for (int i=0; i<jarray.size(); i++) {
			    jobject = jarray.get(i).getAsJsonObject();
				// 그 위치의 title 이라는 키값으로 해당하는 데이터(값)을 가져 옴
			    String title = jobject.get("title").toString();
			    String link = jobject.get("link").toString();
			    String image = jobject.get("image").toString();
			    String subtitle = jobject.get("subtitle").toString();
			    String pubDate = jobject.get("pubDate").toString();
			    String director = jobject.get("director").toString();
			    String actor = jobject.get("actor").toString();
			    String userRating = jobject.get("userRating").toString();
			    
				// 가져온 값을 출력
				title = title.replaceAll("\"", "");
				title = title.replaceAll("<b>", "");
				title = title.replaceAll("</b>", "");
				
			    System.out.println(title);
			    System.out.println(link.replaceAll("\"", ""));
			    System.out.println(image.replaceAll("\"", ""));
			    System.out.println(subtitle.replaceAll("\"", ""));
			    System.out.println(pubDate.replaceAll("\"", ""));
			    System.out.println(director.replaceAll("\"", ""));
			    System.out.println(actor.replaceAll("\"", ""));
			    System.out.println(userRating.replaceAll("\"", ""));
			}
		    
// 			NaverApiVO [] volist = gson.fromJson(json, NaverApiVO[].class);
// 			List<NaverApiVO> movieList = Arrays.asList(volist);
// 			System.out.println(gson.toJson(movieList));
			
			
       } catch (Exception e) {
           System.out.println(e);
       }

%>