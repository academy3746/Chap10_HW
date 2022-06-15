<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%request.setCharacterEncoding("utf-8");%>
<%@ page import="java.sql.*" %>
<html>
<head>

	<%
		String id = request.getParameter("id");
		String name = request.getParameter("name");
		String sex = request.getParameter("sex");
		String pwd = request.getParameter("pwd");
		String pwc = request.getParameter("pwc");
		String addr = request.getParameter("addr");
		String tel = request.getParameter("tel");
		String mail = request.getParameter("mail");
		
		// [JAVA ~ Database Sync. Scope]
				
		// Set DB Variable
		Connection conn = null;
		PreparedStatement pstmt = null;
		int rowNum;
		
		try{
			// JDBC Driver Loading
			Class.forName("com.mysql.jdbc.Driver");
			Class.forName("com.mysql.cj.jdbc.Driver");
			
			// Connect Database
			conn = DriverManager.getConnection(
			"jdbc:mysql://localhost:3306/jspbook?characterEncoding=UTF-8&serverTimezone=UTC",
			"jspbook",
			"1234");
			
			if(pwc.equals(pwd)){
				// Set Statement to Insert SQL
				pstmt = conn.prepareStatement("INSERT INTO MEMBER" 
				+ "(ID,PASSWORD,NAME,SEX,ADDRESS,TEL,EMAIL)" 
				+ "VALUES(?,?,?,?,?,?,?)");
				
				pstmt.setString(1, id);
				pstmt.setString(2, pwd);
				pstmt.setString(3, name);
				pstmt.setString(4, sex);
				pstmt.setString(5, addr);
				pstmt.setString(6, tel);
				pstmt.setString(7, mail);
				
				// Return SQL Result on ResultSet
				rowNum = pstmt.executeUpdate();
				
			}else{
				response.sendRedirect("join.html");
			}
			
		}catch(SQLException e){
			e.getMessage();
		}finally{
			if(conn != null)try{conn.close();}catch(SQLException e){}
			if(pstmt != null)try{pstmt.close();}catch(SQLException e){}
		}
	%>

<title>User Info.</title>
</head>
<body>

	<h2>작성하신 내용은 다음과 같습니다.</h2>
	
	이름: ${param.name}<hr/>
	
	<c:choose>
		<c:when test="${param.sex == 0}">
			성별: Male<hr/>
		</c:when>
		<c:otherwise>
			성별: Female<hr/>
		</c:otherwise>
	</c:choose>
	
	아이디: ${param.id}<hr/>
	
	주소: ${param.addr}<hr/>
	
	전화번호: ${param.tel}<hr/>
	
	이메일주소: ${param.mail}<hr/>
	
<form action="Login.jsp" method="post">
<input type="submit" value="로그인 화면으로">
<a href="join.html">[취소]</a>
</form>
</body>
</html>