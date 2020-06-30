<%--
  Created by IntelliJ IDEA.
  User: ttang
  Date: 2020-06-07
  Time: 14:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>忘记密码</title>
    <link rel="stylesheet" href="css/style1.css">
    <script src="jquery-3.4.1.js"></script>
</head>
<body>
<form action="http://localhost:8080/untitled_war_exploded/Forget" class="login-form" method="post">
    <h1>验证用户信息</h1>
    <hr style="border:#adadad solid 1px">
    <div class="txtb" style="margin-top: 20px">
        <input type="text" name="username"/>
        <span data-placeholder="Username"></span>
    </div>
    <div class="txtb">
        <input type="text" name="userid"/>
        <span data-placeholder="UserId"></span>
    </div>
    <div class="txtb">
        <input type="text" name="mailbox"/>
        <span data-placeholder="Mailbox"></span>
    </div>

    <input type="submit" class="logbtu" value="提交">
</form>

<script type="text/javascript">
    $(function () {
        $(".txtb input").on("focus", function () {
            $(this).addClass("focus");
        });
    });
    $(function () {
        $(".txtb input").on("blur", function () {
            if ($(this).val() == "")
                $(this).removeClass("focus");
        });
    });
</script>
</body>
</html>
