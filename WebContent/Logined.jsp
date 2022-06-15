<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*" %>
<html>
<head>
<title>쿠키를 이용한 세션관리</title>
</head>

	<%
		// 로컬변수에 파라티터 값을 저장: remember, id, pwd
		String remember = request.getParameter("remember");
		
		// 로컬변수에 파라티터 값을 저장: id
		String id = request.getParameter("id");
		session.setAttribute("ID", request.getParameter("id"));
		// Session name: ID
		// Session value: id
		
		// 로컬변수에 파라티터 값을 저장: pwd
		String pwd = request.getParameter("pwd");
		session.setAttribute("PWD", request.getParameter("pwd"));
		// Session name: PWD
		// Session value: pwd
		
		// Generate Cookies: remember, id, pwd, status
		Cookie cookieRemember;
		Cookie cookieId;
		Cookie cookiePwd;
		Cookie cookieStatus;
		
		if(remember != null && remember.equals("keep")){
			cookieRemember = new Cookie("remember","keep");
		}else{
			cookieRemember = new Cookie("remember","temp");
		}
		
		cookieId = new Cookie("id",id);
		cookiePwd = new Cookie("pwd",pwd);
		cookieStatus = new Cookie("status","login");
		
		// 쿠키 반환
		response.addCookie(cookieRemember);
		response.addCookie(cookieId);
		response.addCookie(cookiePwd);
		response.addCookie(cookieStatus);
		
		// [JAVA ~ Database Sync. Scope]
		
		// Set DB Variable
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try{
			
			// JDBC Driver Loading
			Class.forName("com.mysql.jdbc.Driver");
			Class.forName("com.mysql.cj.jdbc.Driver");
			
			// Connect Database Server
			conn = DriverManager.getConnection(
			"jdbc:mysql://localhost:3306/jspbook?characterEncoding=UTF-8&serverTimezone=UTC",
			"jspbook",
			"1234");
			
			// Set Statement and SELECT SQL
			pstmt = conn.prepareStatement("SELECT * FROM MEMBER WHERE ID = ? ");
			pstmt.setString(1, id);
			
			// Return SQL Result on ResultSet
			rs = pstmt.executeQuery();
			
			// Conditional Statement for User Authentication
			if(rs.next()){
				if(id.equals(rs.getString(1)) == true && pwd.equals(rs.getString(2)) == true){
				// id, pwd가 모두 일치하는 경우
					rs.close();
				}else if(pwd.equals(rs.getString(2)) == false || id.equals(rs.getString(1)) == false){
				// id 혹은 pwd가 일치하는 않는 경우
					response.sendRedirect("Login.jsp");
				}
			}else{
			// id와 pwd가 모두 일치하지 않는 경우, 회원가입 페이지로 전송
				response.sendRedirect("join.html");
			}
			
		}catch(SQLException e){
			e.getMessage();
		}finally{
			if(conn != null)try{conn.close();}catch(SQLException e){}
			if(pstmt != null)try{pstmt.close();}catch(SQLException e){}
			if(rs != null)try{rs.close();}catch(SQLException e){}
		}
	%>
	
	<%
		// status 로컬변수 초기화
		String status;
	
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
				
				if(cookies[i].getName().equals("remember")){
					remember = cookies[i].getValue();
				}
			}
		}
	%>

<body>

	<table border="1">
	
	<tr>
	<td colspan="2" align="center">
	<%=session.getAttribute("ID") %>! 티바트에 온 것을 환영해~!
	</td>
	</tr>
	
	<tr>
	<td colspan="2" align="right">
	<form action="Logout.jsp" method="post">
	<input type="submit" value="로그아웃"/>
	</form>
	</td>
	</tr>
	
	</table>

</body>
</html>