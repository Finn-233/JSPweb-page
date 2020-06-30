<%@ page import="java.sql.ResultSet" %>
<%@ page import="data.db" %><%--
  Created by IntelliJ IDEA.
  User: ttang
  Date: 2020-05-18
  Time: 15:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>登录验证</title>
</head>
<body>
<div style="width: 600px;margin: 10px auto;line-height: 40px;">
    <h3>登录验证</h3>
    <span class="msg">
        <%
            request.setCharacterEncoding("UTF-8");
            String msg = "";
            String back = "&emsp;<a href='javascript:window.history.back();'>后退</a>";

            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String rembmer = request.getParameter("rembmer");

            if (username == null || username.trim().equals("")) {
                msg = "请输入用户名！" + back;
                out.print(msg);
                return;
            }
            username = username.trim();
            if (password == null || password.equals("")) {
                msg = "请输入密码！" + back;
                out.print(msg);
                return;
            }

            String sql = "";
            ResultSet rs = null;

            sql = "SELECT * FROM photoworld.tb_user WHERE photoworld.tb_user.username=? and photoworld.tb_user.password=?;";
            rs = db.select(sql, username, password);

            if (rs == null) {
                msg = "数据库操作发生错误！" + back;
                out.print(msg);
                return;
            }
            if (!rs.next()) {
                db.close();
                msg = "登录失败！所输入的用户名或密码不正确！" + back;
                out.print(msg);
                return;
            }

            String userid = rs.getString("userid"); //读取字段
            String mark = rs.getString("mark");
            String head_portrait = rs.getString("head_portrait");
            String mailbox = rs.getString("mailbox");
            db.close();


            //把东西写入session，以保持用户登录
            session.setAttribute("loginUserid", userid); //用户id，添加到session
            session.setAttribute("loginpassword", password);//密码
            session.setAttribute("loginUsername", username); //用户名
            session.setAttribute("loginMark", mark); //用户身份
            session.setAttribute("loginhead", head_portrait); //用户头像
            session.setAttribute("loginmailbox", mailbox); //用户邮箱
            session.setAttribute("Rembmer", rembmer);//是否记住密码
            response.sendRedirect("main.jsp"); //登录成功网页转向
        %>
    </span>

</div>
</body>
</html>
