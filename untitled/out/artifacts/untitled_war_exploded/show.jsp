<%@ page import="java.sql.ResultSet" %>
<%@ page import="data.db" %><%--
  Created by IntelliJ IDEA.
  User: ttang
  Date: 2020-06-05
  Time: 19:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>个人中心</title>
    <link rel="stylesheet" href="css/style1.css">
</head>
<body>
<%
    String loginUserid = request.getParameter("userid");
    String sql = "";
    ResultSet rs = null;
    String back = "&emsp;<a href='javascript:window.history.back();'>后退</a>";
    String msg = "";
    sql = "SELECT * FROM photoworld.tb_user WHERE photoworld.tb_user.userid=?;";
    rs = db.select(sql, loginUserid);

    if (rs == null) {
        msg = "数据库操作发生错误！" + back;
        out.print(msg);
        return;
    }
    if (!rs.next()) {
        db.close();
        msg = "进入失败" + back;
        out.print(msg);
        return;
    }
    String head_portrait = rs.getString("head_portrait");
    String username = rs.getString("username");
    String password = rs.getString("password");
    String mailbox = rs.getString("mailbox");
    String userid = rs.getString("userid"); //读取字段
    db.close();
%>
<form class="login-form">
    <h1>个人中心</h1>
    <div style="margin-top:-20px;margin-left: 20px;text-align: center">
        <img id="show" src="<%=head_portrait%>" style=" border-radius: 100px;width: 50px;">
    </div>
    <hr style="border:#adadad solid 1px">
    <div class="txtb" style="margin-top: 30px;text-align: center">
        <span class="focus"><%=username%></span>
        <span data-placeholder="Username"></span>
        <hr style="border:#adadad solid 0.3px">
    </div>
    <div class="txtb" style="margin-top: 20px;text-align: center">
        <span class="focus"><%=password%></span>
        <span data-placeholder="Password"></span>
        <hr style="border:#adadad solid 0.3px">
    </div>

    <div class="txtb" style="margin-top: 20px;text-align: center">
        <span class="focus"><%=mailbox%></span>
        <span data-placeholder="Mailbox"></span>
        <hr style="border:#adadad solid 0.3px">
    </div>
    <div class="txtb" style="margin-top: 20px;text-align: center">
        <span class="focus"><%=userid%></span>
        <span data-placeholder="UerId"></span>
        <hr style="border:#adadad solid 0.3px">
    </div>

    <a href="userAdmin.jsp"><input type="button" class="logbtu" value="返回"></a>
</form>
</body>
</html>
