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
    <title>用户删除</title>
    <link rel="stylesheet" href="css/css.css">
</head>
<body>
<div style="width: 600px;margin: 10px auto;line-height: 40px;">
    <h3>用户删除</h3>
    <span class="msg">
        <%
            request.setCharacterEncoding("UTF-8");
            String msg = "";
            String back = "&emsp;<a href='javascript:window.history.back();'>后退</a>";
            if (session.getAttribute("loginUsername") == null) {
                msg = "您的登录已失效！请重新登录。";
                msg += "&emsp;<a href=index.jsp>登录</a>";//首页链接
                out.print(msg);
                return;
            }

            String loginUsername = session.getAttribute("loginUsername").toString();
            String loginMark = session.getAttribute("loginMark").toString();
            if (!loginMark.equals("admin")) {
                msg = "您的权限不足！";
                msg += "&emsp;<a href= 'main.jsp'>用户功能</a>";
                out.print(msg);
                return;
            }
            String userid = request.getParameter("userid");
            try {
                Integer.parseInt(userid);
            } catch (Exception e) {
                msg = "参数错误" + back;
                out.print(msg);
                return;
            }
            String sql = "";


            sql = "delete from tb_user where userid=?";
            int count = db.delete(sql, userid);
            if (count == 0) {
                msg = "删除用户信息失败！，请重试。" + back;
                out.print(msg);
                return;
            }
            msg = "删除用户信息成功！";
            out.print(msg);
        %>
    </span>

    <br>
    <a href="userAdmin.jsp">返回用户管理</a>
</div>
</body>
</html>
