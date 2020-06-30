package forget;

import data.db;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet(name = "Forget", urlPatterns = "/Forget")
public class Forget extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        String msg = "";
        String username = request.getParameter("username");
        String userid = request.getParameter("userid");
        String mailbox = request.getParameter("mailbox");

        msg += "用户名:" + username;
        msg += "<br>密码:" + userid;
        msg += "<br>邮箱:" + mailbox;


        for (int f = 0; f < 1; f++) {
            msg += "<br>";
            if (username == null || username.trim().equals("")) {
                msg += "请输入用户名!";
                break;
            }
            if (userid == null || userid.equals("")) {
                msg += "请输入用户id!";
                break;
            }
            if (mailbox == null || mailbox.equals("")) {
                msg += "请输入用户注册邮箱!";
                break;
            }
            username = username.trim();
            userid = userid.trim();
            mailbox = mailbox.trim();


            String sql = "";
            ResultSet rs = null;

            sql = "SELECT * FROM photoworld.tb_user WHERE photoworld.tb_user.username=? and photoworld.tb_user.userid=? and photoworld.tb_user.mailbox=?;";
            rs = db.select(sql, username, userid, mailbox);

            if (rs == null) {
                msg = "数据库操作发生错误！";
                msg += "<a href='forgetpassword.jsp'></a>";
                out.print(msg);
                return;
            }
            try {
                if (!rs.next()) {
                    db.close();
                    msg = "查询失败！所输入的用户不存在！";
                    break;
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }


            HttpSession session = request.getSession();
            session.setAttribute("username", username);
            session.setAttribute("userid", userid);
            session.setAttribute("mailbox", mailbox);
            response.sendRedirect("setpassword.jsp");
            return;
        }

        String mstTemp = msg;
        msg = "";
        msg += "<!DOCTYPE HTML PUBLIC'-//W3C//DTD HTML 4.01 Transitional//EN '>";
        msg += "<html>";
        msg += "<head>";
        msg += "    <title>用户验证</title>";
        msg += "</head>";
        msg += "<body>";
        msg += "<div style=\"width: 600px;margin: 40px auto;line-height: 40px\">";
        msg += " <h3>&emsp;&emsp;&emsp;&emsp;用户验证失败<h3>";
        msg += mstTemp;
        msg += "<br><a href='forgetpassword.jsp'>返回忘记密码</a>";
        msg += "</div>";
        msg += "</body>";
        msg += "</html>";

        out.println(msg);
        out.flush();
        out.close();

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.getWriter().append("Served at: ").append(request.getContextPath());
    }
}
