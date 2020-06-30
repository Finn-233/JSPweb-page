<%--
  Created by IntelliJ IDEA.
  User: ttang
  Date: 2020-06-07
  Time: 15:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>设置新密码</title>
    <link rel="stylesheet" href="css/style1.css">
    <script src="jquery-3.4.1.js"></script>
</head>
<body>
<form action="http://localhost:8080/untitled_war_exploded/Setpassword" method="post" class="login-form">
    <h1>验证成功,请输入您的新密码</h1>
    <hr style="border:#adadad solid 1px">
    <div class="txtb" style="margin-top: 20px">
        <input id="new" type="password" onchange="c()"/>
        <span data-placeholder="Newpassword"></span>
    </div>
    <div class="txtb">
        <input id="agin" name="password" type="password" onchange="c()"/>
        <span data-placeholder="Enter newpassword again"></span>
    </div>

    <input type="submit" class="logbtu" value="提交">
    <span id="tick" style="color: red;text-align: center"></span>
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

    function c() {
        var a = document.getElementById("agin").value;
        var n = document.getElementById("new").value;
        if (a != n) {
            document.getElementById("tick").innerHTML = "你输入的密码不一致";
        } else {
            document.getElementById("tick").innerHTML = "";
        }
    }
</script>
</body>
</html>
