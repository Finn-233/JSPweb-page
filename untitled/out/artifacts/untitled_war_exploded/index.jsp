<%--
  Created by IntelliJ IDEA.
  User: ttang
  Date: 2020-05-28
  Time: 20:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" href="css/style.css">
    <title>登录</title>
</head>
<%
    String uname = "", paword = "";
    uname = (String) session.getAttribute("username");
    paword = (String) session.getAttribute("password");
    if (uname == null) {
        uname = "";
        paword = "";
    }
%>
<body>
<form method="post" action="loginCheck.jsp">
    <div class="container">
        <div class="form-container">
            <div class="form-body">
                <div class="header">
                    <h2>登录</h2>
                    <p>没有账号? <a href="registration.jsp">注册你的账号</a></p>
                </div>
                <div class="form-group">
                    <div class="input-group">
                        <input type="text" name="username" value="<%=uname%>" placeholder="UserName">
                    </div>
                    <div class="input-group">
                        <input type="password" name="password" value="<%=paword%>" placeholder="PassWord">
                    </div>
                    <div class="input-group flex">
                        <div class="remember"><input type="checkbox" name="rembmer" id="checked" checked="checked"
                                                     value="rembmer"><label
                                for="checked">记住密码</label>
                        </div>
                        <div class="forgot"><a href="forgetpassword.jsp">忘记密码?</a></div>
                    </div>
                    <div class="input-group right">
                        <button type="submit">登录</button>
                    </div>
                </div>
            </div>

            <div class="form-image">
                <div class="text">
                    <h2>欢迎 <br>回来</h2>
                    <p>选择登录图片搜索!</p>
                </div>
            </div>
        </div>
    </div>
</form>
</body>

</html>
