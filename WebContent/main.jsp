<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>메인 페이지</title>
</head>
<body>
<h1> 영화 검색 사이트 </h1>
<h3>검색할 영화를 입력 하세요.</h3>
<form action="nmovie">
	<input type="text" name="search">
	<input type="submit" value="검색">
</form>
<h1> 뉴스 검색 사이트 </h1>
<h3>검색할 뉴스를 입력 하세요.</h3>
<form action="search2.jsp">
	<input type="text" name="search">
	<input type="submit" value="검색">
</form>


<h1> 레시피 블로그 </h1>
<h3> 원하는 재료를 체크 하세요.</h3>
<form action="search3.jsp">
	<input type="checkbox" name="menu" value="당근"> 당근 &nbsp;&nbsp;
	<input type="checkbox" name="menu" value="아보카도"> 아보카도&nbsp;&nbsp;
	<input type="checkbox" name="menu" value="올리브유"> 올리브유&nbsp;&nbsp;
	<br>
	<input type="checkbox" name="menu" value="라면"> 라면&nbsp;&nbsp;
	<input type="checkbox" name="menu" value="마늘"> 마늘&nbsp;&nbsp;
	<input type="checkbox" name="menu" value="양파"> 양파<br>
	<input type="submit" value="레시피보기">
</form>
</body>
</html>