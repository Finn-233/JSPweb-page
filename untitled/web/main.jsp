<%@ page import="java.sql.ResultSet" %>
<%@ page import="data.db" %>
<%@ page import="java.net.URLEncoder" %><%--
  Created by IntelliJ IDEA.
  User: ttang
  Date: 2020-06-01
  Time: 11:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>主页</title>
    <link href="https://fonts.googleapis.com/css?family=Roboto+Condensed:300,300i,400,400i,700i" rel="stylesheet">
    <%--<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">--%>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <%--<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>--%>
    <%--<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>--%>
    <link rel="stylesheet" href="css/main.css">
</head>
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

            String loginUserid = session.getAttribute("loginUserid").toString();
            String loginUsername = session.getAttribute("loginUsername").toString();
            String loginMark = session.getAttribute("loginMark").toString();
            String head_portrait = session.getAttribute("loginhead").toString();
            String mailbox = session.getAttribute("loginmailbox").toString();
            String linkAdmin = "";


            String title = "";
            String author = "";
            String tag = "";
            String buttonQuery = request.getParameter("buttonQuery");
            String buttonPage = request.getParameter("buttonPage");
            String pageInput = "1";
            if (buttonQuery != null) {
                title = request.getParameter("title").trim();
                author = request.getParameter("author").trim();
                tag = request.getParameter("tag").trim();
            } else if (buttonPage != null) {
                title = request.getParameter("title").trim();
                author = request.getParameter("author").trim();
                tag = request.getParameter("tag").trim();
                pageInput = request.getParameter("pageShow");
            } else {
                //完成上一页和下一页的方法
                if (request.getParameter("titleUrl") != null)
                    title = request.getParameter("titleUrl"); //取得地址栏中参数值
                if (request.getParameter("authorUrl") != null)
                    author = request.getParameter("authorUrl");//不需要进行解码操作，系统会自己解码
                if (request.getParameter("tagUrl") != null)
                    tag = request.getParameter("tagUrl"); //取得地址栏中参数值
                if (request.getParameter("pageUrl") != null)
                    pageInput = request.getParameter("pageUrl");//地址栏中的页码
            }

            String titleUrl = "", authorUrl = "", tagUrl = "";
            if (!title.equals("")) {
                titleUrl = URLEncoder.encode(title, "UTF-8");
            }
            if (!author.equals("")) {
                authorUrl = URLEncoder.encode(author, "UTF-8");
            }
            if (!tag.equals("")) {
                tagUrl = URLEncoder.encode(tag, "UTF-8");
            }
            String urlArg = "&titleUrl=" + titleUrl + "&authorUrl=" + authorUrl + "&tagUrl=" + tagUrl;


            String sql = "";
            ResultSet rs = null;
            sql = "SELECT * FROM photoworld.photo JOIN photoworld.photodata ON photoworld.photo.url = photoworld.photodata.url WHERE title LIKE concat('%',?,'%') AND author LIKE concat('%',?,'%') AND tag LIKE concat('%',?,'%')";

            rs = db.select(sql, title, author, tag);

            if (rs == null) {
                msg = "数据库操作发生错误！" + back;
                out.print(msg);
                return;
            }


            int countRow = 0;
            while (rs.next())
                countRow++;

            int pageSize = 21; //每页限制三条记录
            int pageCount = 0; //预设总页数

            if (countRow % pageSize == 0)
                pageCount = countRow / pageSize; //总页数
            else
                pageCount = countRow / pageSize + 1;

            int pageShow = 1; //预设当前页

            try {
                pageShow = Integer.parseInt(pageInput);
            } catch (Exception e) {
                e.printStackTrace();
                //防止输入值不为数字
            }

            if (pageShow < 1)
                pageShow = 1;
            else if (pageShow > pageCount)
                pageShow = pageCount;
            int position = (pageShow - 1) * pageSize; // 当前页中的首条记录之前的那一条

            rs.absolute(position);
        %>
    </span>


<body background="img/dots.png">
<form action="main.jsp" method="post">
    <div class="search" style="width: 100%;height:60%;background-image: url(img/Time_assassin.jpg)">
        <div class="headphoto">
            <img class="photo" src="<%=head_portrait%>">
            <div class="message">
                <table style="text-align: center;border: black solid 1px;width: 100%;height: 100%">
                    <tr>
                        <td class="biaoge">
                            权限
                        </td>
                        <td class="biaoge">
                            <%=loginMark%>
                        </td>
                    </tr>
                    <tr class="biaoge">
                        <td class="biaoge">
                            ID
                        </td>
                        <td class="biaoge">
                            <%=loginUserid%>
                        </td>
                    </tr>
                </table>
                <div class="biaoge" style=" height:30%;width: 100%;background-color: rgba(230, 225, 255, 0.5);"><a
                        href="loginout.jsp">登出</a></div>
            </div>
        </div>
        <div style="margin-left: 70%;margin-top: -115px">
        <span class="pink">&emsp;<%=loginUsername%>&emsp;&emsp;
        </span>
            <span>|&emsp;&emsp;<a href="showMe.jsp" style="color: white">个人中心</a>&emsp;&emsp;|</span>
            <span>&emsp;&emsp;<a href="editMe.jsp" style="color: white">账号设置</a></span>
            <%
                if (loginMark.equals("admin")) {
            %>
            <span>&emsp;&emsp;|&emsp;&emsp;<a href="userAdmin.jsp" style="color: white">用户管理</a></span>
            <%
                }
            %>
        </div>
        <!--    background-image: url(Sierra.jpg)-->

        <div style="margin-bottom: 238.5px;margin-top: 238.5px;margin-left: 32%;">
            <span style="font-size: 50px;color: white;margin-left: 250px;"><b>搜图</b></span>
            <br><br><br>
            <table style="border: white solid 1px;margin-left: 100px">
                <tr>
                    <th>
                        标题
                    </th>
                    <th>
                        作者
                    </th>
                    <th>
                        标签
                    </th>
                </tr>
                <tr>
                    <td>
                        <input class="in" type="text" name="title" value="<%=title%>">
                    </td>
                    <td>
                        <input class="in" type="text" name="author" value="<%=author%>">
                    </td>
                    <td>
                        <input class="in" type="text" name="tag" value="<%=tag%>">
                    </td>
                </tr>
            </table>
            <input class="bu" type="submit" name="buttonQuery" value="查询" style="margin-left: 250px;">
        </div>

    </div>

    <section class="team " style="margin-top: 30%">
        <div class="container">
            <br><br><br>
            <div class="section-head text-center col-sm-12">
                <h2>The Boy <span class="pink">Who Shattered</span> Time</h2>
                <br><br>
            </div>

            <%
                int i = position;
                String url = null, Title = null, Tag = null, img_url = null, Author = null, description = null;
                int k = 0;
                while (rs.next()) {
                    k++;
                    if (k > pageSize)
                        break;
                    i++;
                    url = rs.getString("url");
                    Title = rs.getString("title");
                    Tag = rs.getString("tag");
                    img_url = rs.getString("img_url");
                    String imglist[] = img_url.split(",");
                    Author = rs.getString("author");
                    description = rs.getString("description");
            %>
            <div class="item col-md-4">
                <div class="hover3d">
                    <div class="hover3d-child">
                        <div class="team-img">
                            <div style="height: 250px;border:1px solid black">
                                <img src=<%=imglist[0]%>
                                             class="img-responsive" alt="找不到图片">
                            </div>
                        </div>
                        <div class="info">
                            <div>
                                <a href="<%=url%>">
                                    <h6><%=Title%>
                                    </h6>
                                </a>
                                <span><%=Author%></span>
                                <p><%=Tag%>
                                </p>
                                <p><%=description%>
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <%
                }
                db.close();
            %>
        </div>
    </section>
    <div style="margin-left: 550px">
        <br>
        输入页码:
        <input type="text" name="pageShow" value="<%=pageShow%>" style="width: 40px;text-align: center">
        <input type="submit" name="buttonPage" id="buttonPage" value="提交">
        &emsp;

        <%if (pageShow == 1) {%>
        <span style="color: grey">首页&ensp;上一页&ensp;</span>
        <%} else {%>
        <a href="?pageUrl=<%=1%><%=urlArg%>">首页</a>&ensp;
        <a href="?pageUrl=<%=pageShow-1%><%=urlArg%>">上一页</a>&ensp;
        <%}%>

        <%if (pageShow == pageCount) {%>
        <span style="color: grey">下一页&ensp;尾页&ensp;</span>
        <%} else {%>
        <a href="?pageUrl=<%=pageShow+1%><%=urlArg%>">下一页</a>&ensp;
        <a href="?pageUrl=<%=pageCount%><%=urlArg%>">尾页</a>&ensp;
        <%}%>

        &emsp;记录数:<%=countRow%>
        &emsp;页码<%=pageShow +"/"+pageCount%>&emsp;&emsp;
    </div>
</form>
<div class="foot" style="width: 100%; height: 200px;background-color: darkgrey;padding-top: 70px;padding-left: 700px">
    <span>
        <a>关于我们 </a>&emsp;｜
        &emsp;<a>联系方式</a>&emsp;|
        &emsp;<a>工作人员</a>&emsp;
    </span>
    <br>
    <br>
    <br>
    <span style="margin-left: -130px">
        Copyright © 2019 <a>Photoworld</a>&emsp;｜
        &emsp;摄影世界 版权所有&emsp;|
        &emsp;<a>京ICP备13040999号-1</a>&emsp;
    </span>
</div>
</body>
</html>