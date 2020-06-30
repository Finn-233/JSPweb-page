<%@ page import="java.sql.ResultSet" %>
<%@ page import="data.db" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.net.URLDecoder" %><%--
  Created by IntelliJ IDEA.
  User: ttang
  Date: 2020-05-18
  Time: 15:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>用户管理</title>
    <%--<link rel="stylesheet" href="css/css.css">--%>
</head>
<body>
<style>
    .table_border td{
        text-align: center;
        border: #00aaff solid 1px;
    }
</style>
<div style="width: 100%;margin: 10px auto;line-height: 40px;">

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
            String linkAdmin = "";


            String field = "userid";
            String content = "";
            String buttonQuery = request.getParameter("buttonQuery");

            String buttonPage = request.getParameter("buttonPage");
            String pageInput = "1";//输入的页码


            if (buttonQuery != null) { //假如按的是数据查询的按钮
                field = request.getParameter("field");
                content = request.getParameter("content").trim();
            } else if (buttonPage != null) { //按的是页码按钮
                field = request.getParameter("field");
                content = request.getParameter("content").trim();
                pageInput = request.getParameter("pageShow");
            } else {
                if (request.getParameter("fieldUrl") != null)
                    field = request.getParameter("fieldUrl"); //取得地址栏中参数值
                if (request.getParameter("contentUrl") != null)
                    content = request.getParameter("contentUrl");//不需要进行解码操作，系统会自己解码
                if (request.getParameter("pageUrl") != null)
                    pageInput = request.getParameter("pageUrl");//地址栏中的页码
            }

            String contenUrl = "";

            if (!content.equals("")) {
                contenUrl = URLEncoder.encode(content, "UTF-8");
            }
            String urlArg = "&fieldUrl=" + field + "&contentUrl=" + contenUrl;

            String selectuserid = null, selectuserName = null, selectmarkName = null;

            if (field.equals("userid"))
                selectuserid = "selected='selected'";
            else if (field.equals("username"))
                selectuserName = "selected='selected'";
            else if (field.equals("mark"))
                selectmarkName = "selected='selected'";


            String sql = "";
            ResultSet rs = null;
            String sqlWhere = "";


            if (!content.equals("")) {
                content = content.replace("'", "").replace(" ", "");
                sqlWhere = " WHERE " + field + " LIKE concat('%',?,'%')";
            }
            sql = "SELECT * FROM tb_user" + sqlWhere + " ORDER BY tb_user.userid";


            if (content.equals("")) {
                rs = db.select(sql);
            } else {
                rs = db.select(sql, content);
            }


            if (rs == null) {
                msg = "数据库操作发生错误！" + back;
                out.print(msg);
                return;
            }

            int countRow = 0;
            while (rs.next())
                countRow++;

            int pageSize = 5; //每页限制三条记录
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
    <form action="" method="post">
        <table width="800" align="center">
            <tr>
                <td style="text-align: center">
                    <h1>用户列表</h1>
                    <div class="left" style="margin: 40px 0px 5px 0px">
                        &emsp;&emsp;数据查询:
                        <select name="field" style="vertical-align: middle">
                            <option value="userid" <%=selectuserid%>>ID</option>
                            <option value="username" <%=selectuserName%>>昵称</option>
                            <option value="mark" <%=selectmarkName%>>权限</option>
                        </select>
                        <input type="text" name="content" value="<%=content%>" style="width: 150px">
                        <input type="submit" name="buttonQuery" value="查询">
                    </div>
                </td>
            </tr>
            <tr>
                <td style="width: 100%;text-align: center">
                    <table width="580" style="text-align: center" class="table_border table_border_bg table_hover">
                        <tr bgcolor="#6495ed">
                            <td>用户ID</td>
                            <td>用户名</td>
                            <td>密码</td>
                            <td>权限</td>
                            <td style="text-align: center">操作</td>
                        </tr>
                        <%
                            int i = position;
                            String userid = null, username = null, password = null, realName = null, mark = null;
                            int k = 0;

                            while (rs.next()) {
                                k++;
                                if (k > pageSize)
                                    break;
                                i++;
                                userid = rs.getString("userid");
                                username = rs.getString("username");
                                password = rs.getString("password");
                                mark = rs.getString("mark");
                        %>
                        <tr>
                            <td><%=userid%>
                            </td>
                            <td><%=username%>
                            </td>
                            <td><%=password%>
                            </td>
                            <td><%=mark%>
                            </td>
                            <td>
                                <a href="show.jsp?userid=<%=userid%>" title="详情">
                                    详情
                                </a>&emsp;
                                <a href="Edit.jsp?userid=<%=userid%>" title="编辑">
                                    编辑
                                </a>&emsp;
                                <a href="userDeleteDo.jsp?userid=<%=userid%>" title="删除"
                                   onclick="return confirm('确定要删除吗？');">
                                    删除
                                </a>&emsp;
                            </td>
                        </tr>
                        <%
                            }
                            db.close();
                        %>

                    </table>
                </td>
            </tr>
            <tr>
                <td style="font-size:small;text-align:right">
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
                    <a href="main.jsp">返回</a>
                </td>
            </tr>
        </table>
    </form>
</div>
</body>
</html>
