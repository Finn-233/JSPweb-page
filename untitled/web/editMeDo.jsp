<%@ page import="java.sql.ResultSet" %>
<%@ page import="data.db" %>
<%@ page import="java.io.File" %>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory" %>
<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload" %>
<%@ page import="org.apache.commons.fileupload.FileItem" %>
<%@ page import="org.apache.commons.fileupload.FileUploadException" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>修改Do</title>
</head>
<body>

<div style="width:800px; margin:30px auto; line-height:30px;">
    <%
        String msg = "";
        String path = getServletConfig().getServletContext().getRealPath("/");
        path += "uploadFile/";
        String name = "";
        String username = "", password = "", mailbox = "", phone_num = "";
        for (int i = 0; i < 1; i++) {
            File file = new File(path);
            if (!file.exists()) {
                if (!file.mkdir()) {
                    //mkdir()创建目录的方法返回boolean值。
                    msg = "文件存放的目录创建失败";
                    break;
                }
            }

            //创建缓冲区；
            File filebuffer = new File(path + "buffer\\");
            if (!file.exists()) {
                if (!file.mkdir()) {
                    //mkdir()创建目录的方法返回boolean值。
                    msg = "缓冲区目录创建失败";
                    break;
                }
            }

            //上传配置
            int MEMORY_THRESHOLD = 1024 * 1024 * 4; //1MB内存缓冲区
            long MAX_REQUEST_SIZE = 1024 * 1024 * 13; //5MB 最大请求值
            long MAX_FILE_SZIE = 1024 * 1024 * 6; //2MB 最大单个文件大小

            DiskFileItemFactory factory = new DiskFileItemFactory();
            factory.setSizeThreshold(MEMORY_THRESHOLD); //设置缓冲区大小
            factory.setRepository(filebuffer);//设置缓冲区目录


            ServletFileUpload upload = new ServletFileUpload(factory); //文件上传对象
            upload.setSizeMax(MAX_REQUEST_SIZE); //最大请求值
            upload.setFileSizeMax(MAX_FILE_SZIE);//最大单个文件大小
            upload.setHeaderEncoding("UTF-8");//编码

            List<FileItem> fileItemList = null;
            try {
                fileItemList = upload.parseRequest(request);//开始读取上传信息；
            } catch (FileUploadException e) {
                msg = "没有有效输入！";
                e.printStackTrace();
                break;
            }
            msg = "上传了文件：";

            for (FileItem fileItem : fileItemList) {
                //如果是表单
                if (fileItem.isFormField()) {
                    String fieldName = fileItem.getFieldName();
                    if (!fieldName.equals("username") && !fieldName.equals("password") && !fieldName.equals("mailbox") && !fieldName.equals("phone_num"))
                        continue;

                    if (fieldName.equals("username")) username = fileItem.getString("UTF-8").trim();//表单字段内容
                    else if (fieldName.equals("password")) password = fileItem.getString("UTF-8").trim();//表单字段内容
                    else if (fieldName.equals("mailbox")) mailbox = fileItem.getString("UTF-8").trim();//表单字段内容

                    if (!username.equals("")) ;
                    if (!password.equals("")) ;
                    if (!mailbox.equals("")) ;
                    continue;
                }
                //如果是文件对象
                name = fileItem.getName(); //这里的文件名是整个路径不是文件的名称
                if (name.equals("")) continue;
                int index = name.lastIndexOf("\\");//取到路径中最后一个"\"的位置
                if (index > 0) name = name.substring(index + 1);

//                long size = fileItem.getSize();
//                size = (size + 1023) / 1024;
//                String url = "uploadFile/" + name;
//                msg += "<br> <a href = '" + url + "'>" + name + "</a>(" + size + "KB)";
                try {
                    fileItem.write(new File(path, name));
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
            msg += "<br>" + username + password + "maile" + mailbox + phone_num;
        }
        msg += "<br><br>文件上传到了目录：<br>" + path;


        String userid = (String) session.getAttribute("loginUserid");
        String sql = "";
        String No = "";
        if (name.equals("")) {
            sql = "update tb_user set username=?,password=?,mailbox=? where userid=?";
            No = db.insert(sql, username, password, mailbox, userid);

        } else {
            sql = "update tb_user set username=?,password=?,head_portrait=?,mailbox=? where userid=?";
            No = db.insert(sql, username, password, request.getContextPath() + "/uploadFile/" + name, mailbox, userid);
        }

        String back = "&emsp;<a href='javascript:window.history.back();'>后退</a>";
        if (No.equals("0")) {
            msg = "修改失败！请重试。" + back;
            out.print(msg);
            return;
        }
    %>
    <%
        msg = "修改成功！<a href='loginout.jsp'>请重新登录</a>";
        out.print(msg);
    %>
</div>
</body>
</html>
