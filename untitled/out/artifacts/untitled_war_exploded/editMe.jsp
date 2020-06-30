<%--
  Created by IntelliJ IDEA.
  User: ttang
  Date: 2020-06-05
  Time: 19:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>修改信息</title>
    <link rel="stylesheet" href="css/style1.css">
    <script src="jquery-3.4.1.js"></script>
</head>
<body>
<%
    String userid = (String) session.getAttribute("loginUserid");
    String password = (String) session.getAttribute("loginpassword");
    String username = (String) session.getAttribute("loginUsername");
    String head_portrait = (String) session.getAttribute("loginhead");
    String mailbox = (String) session.getAttribute("loginmailbox");
%>
<form action="editMeDo.jsp" class="login-form" enctype="multipart/form-data" method="post">
    <h1>修改信息</h1>
    <div style="margin-top:-20px;margin-left: 20px">
        <img id="show" src="<%=head_portrait%>" style=" border-radius: 100px;width: 50px;">
        <input id="file" name="head" style="margin-left: 10px;" value="选择您的头像" type="file" onchange="c()"
               accept="image/jpg"/>
    </div>
    <hr style="border:#adadad solid 1px">
    <div class="txtb" style="margin-top: 20px">
        <input class="focus" type="text" name="username" value="<%=username%>"/>
        <span data-placeholder="Username"></span>
    </div>

    <div class="txtb">
        <input class="focus" type="text" name="password" value="<%=password%>"/>
        <span data-placeholder="Password"></span>
    </div>
    <div class="txtb">
        <input class="focus" type="text" name="mailbox" value="<%=mailbox%>"/>
        <span data-placeholder="Mailbox"></span>
    </div>
    <div class="txtb" style="margin-top: 20px;text-align: center">
        <span class="focus"><%=userid%></span>
        <span data-placeholder="UerId"></span>
        <hr style="border:#adadad solid 0.3px">
    </div>

    <input type="submit" class="logbtu" value="提交修改">
</form>

<script type="text/javascript">
    function c() {
        var r = new FileReader();
        f = document.getElementById('file').files[0];
        r.readAsDataURL(f);
        r.onload = function (e) {
            document.getElementById('show').src = this.result;
        };

    }
</script>
</body>
</html>
