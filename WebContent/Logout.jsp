<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<html>
<head>
<title>세션 내장객체를 이용한 세션관리</title>
</head>

	<%
		// 각 로컬변수를 null값으로 초기화
		String id = null;
		String pwd = null;
		String remember = null;
		String status = null;
		
		// 내장객체를 통한 쿠키 반환: id, pwd, remember, status
		Cookie[] cookies = request.getCookies();
		
		if(cookies != null && cookies.length > 0){
			for(int i=0 ; i<cookies.length ; i++){
				
				if(cookies[i].getName().equals("id")){
					id = cookies[i].getValue();
				}
				
				if(cookies[i].getName().equals("pwd")){
					pwd = cookies[i].getValue();
				}
				
				if(cookies[i].getName().equals("remember")){
					remember = cookies[i].getValue();
				}
				
				if(cookies[i].getName().equals("status") 
				&& cookies[i].getValue().equals("login")){
					status = cookies[i].getValue();
					cookies[i].setValue("logout");
					// status의 쿠키 값을 "logout"으로 변경
					cookies[i].setMaxAge(0);
					// 쿠키의 유효시간을 0으로 셋팅, 강제 초기화
					
					response.addCookie(cookies[i]);
				}
			}
		}
	%>

<body>

	정상적으로 로그아웃 되었어! 이용해줘서 고마워~!<hr/>
	
	다시 로그인 하려면...<br/>

	<%
		pageContext.include("/Login.jsp");
	%>

<hr/>
<form action="Login.jsp" method="post">
<input type="submit" value="첫 화면으로"/>
</form>
</body>
</html>