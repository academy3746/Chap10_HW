<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<html>
<head>
<title>쿠키를 이용한 세션관리</title>
</head>

	<%
		// 로컬변수를 각각 null값으로 초기화
		String id = null;
		String pwd = null;
		String remember = null;
		String status = null;
		
		// 내장객체를 통한 쿠키 반환: id, pwd, remember
		Cookie[] cookies = request.getCookies();
		
		if(cookies != null && cookies.length > 0){
			for(int i=0 ; i<cookies.length ; i++){
				
				if(cookies[i].getName().equals("id")){
					id = cookies[i].getValue();
				}
				
				if(cookies[i].getName().equals("pwd")){
					pwd = cookies[i].getValue();
				}
				
				if(cookies[i].getName().equals("remember") 
				&& cookies[i].getValue().equals("keep")){
					remember = cookies[i].getValue();
				}
			}
		}
	%>
	
	<%
		// 세션 소거 및 초기화
		if(session != null && remember == null){
			session.invalidate();
		}
	%>

<body>

	여행자! 아이디와 비밀번호를 입력해줄래?<hr/>
	
	<form action="Logined.jsp" method="post">
	<table border="1">
	
	<tr>
	<td align="center">아이디</td>
	<td>
	<input type="text" name="id" value="<%=(remember == null)? "" : id %>"/>
	</td>
	</tr>
	
	<tr>
	<td align="center">비밀번호</td>
	<td>
	<input type="password" name="pwd" value="<%=(remember == null)? "" : pwd %>"/>
	</td>
	</tr>
	
	<tr>
	<td colspan="2" align="right">
	<input type="checkbox" name="remember" value="keep" 
	<%=(remember == null)? "" : "checked=\"checked\"" %>/>
	아이디 / 비밀번호 저장
	</td>
	</tr>
	
	<tr>
	<td colspan="2" align="right">
	<a href="join.html">[회원가입]</a>
	<input type="submit" value="로그인"/>
	</td>
	</tr>
	
	</table>
	</form>

</body>
</html>