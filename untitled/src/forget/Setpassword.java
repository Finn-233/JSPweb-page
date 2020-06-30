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

@WebServlet(name = "Setpassword", urlPatterns = "/Setpassword")
public class Setpassword extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        String msg = "";
        String back = "&emsp;<a href='javascript:window.history.back();'>后退</a>";
        String password = request.getParameter("password");


        msg += "<br>密码:" + password;


        for (int f = 0; f < 1; f++) {
            msg += "<br>";
            if (password == null || password.trim().equals("")) {
                msg += "请输入密码!" + back;
                out.println(msg);
                return;
            }

            password = password.trim();
            HttpSession session = request.getSession();
            String userid = (String) session.getAttribute("userid");

            String sql = "";
            String No = "";

            sql = "update tb_user set password=? where userid=?";
            No = db.insert(sql, password, userid);


            if (No.equals("0")) {
                msg = "修改失败！请重试。" + back;
                out.print(msg);
                return;
            }

            session.setAttribute("password",password);
            response.sendRedirect("index.jsp");
            return;
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.getWriter().append("Served at: ").append(request.getContextPath());
    }
}
