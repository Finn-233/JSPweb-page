<%--
  Created by IntelliJ IDEA.
  User: ttang
  Date: 2020-06-03
  Time: 14:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>注销登录</title>
    <link rel="stylesheet" href="css/css.css">
</head>
<body>
<div style="width: 600px;margin: 10px auto;line-height: 40px;">
    <h3>注销登录</h3>
    <span class="msg">
    <%
        String rembmer = "", loginpassword = "", loginUsername = "";
        rembmer = (String) session.getAttribute("Rembmer");
        loginpassword = session.getAttribute("loginpassword").toString();
        loginUsername = session.getAttribute("loginUsername").toString();

        if (rembmer == null) {
            session.invalidate();
        } else if (rembmer.equals("rembmer")){
            session.setAttribute("username", loginUsername);
            session.setAttribute("password", loginpassword);
        }else {
            session.invalidate();
        }
    %>
        注销登录成功！&emsp;
    </span>
    <%
        response.sendRedirect("index.jsp");
    %>

</div>
</body>
</html>
