package data;

import java.sql.*;

public class db {
    private static String driver = "com.mysql.jdbc.Driver";
    private static String connString = "jdbc:mysql://localhost:3306/photoworld?useSSL=false";
    private static String username = "root";
    private static String password = "84802468Tang";

    private static Connection conn = null;
    private static Statement stmt = null;
    private static ResultSet rs = null;

    private static PreparedStatement pstmt = null;


    private static Connection getConnecion() {
        Connection myConn = null;

        try {
            Class.forName(driver); //加载驱动程序
            myConn = DriverManager.getConnection(connString, username, password);//连接数据库
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("\r\n创建数据库失败：" + e.getMessage() + "\r\n");
            //\r是回车
        }
        return myConn;
    }

    public static ResultSet select(String... args) {
        rs = null;
        //这种方法太容易被sql攻击
//        try {
//            if (conn == null || conn.isClosed()) {
//                conn = getConnecion();
//                stmt = conn.createStatement(ResultSet.TYPE_FORWARD_ONLY, ResultSet.CONCUR_READ_ONLY);
//                //创建事物stmt，数据游标能向前移动，只读，效率高
//                //stmt = conn.createStatement() 这样的效率低
//            } else if (stmt == null || stmt.isClosed()) {
//                stmt = conn.createStatement(ResultSet.TYPE_FORWARD_ONLY, ResultSet.CONCUR_READ_ONLY);
//            }
//            System.out.println("查询：" + sql);
//            rs = stmt.executeQuery(sql);
//            System.out.println("查询：" + sql);
//        } catch (Exception e) {
//            e.printStackTrace();
//            close();
//            System.out.println("\r\n查询数据失败：" + e.getMessage() + "\r\n");
//
//        }
        try {
            if (args == null || args.length == 0)
                return rs;
            String sql = args[0];
            System.out.println("查询：" + sql);
            if (conn == null || conn.isClosed()) {
                conn = getConnecion();
            }
            pstmt = conn.prepareStatement(sql, ResultSet.TYPE_FORWARD_ONLY, ResultSet.CONCUR_READ_ONLY);
            System.out.println("数量：" + args.length);
            //预处理的事物的时候就把sql语句输入了。
            for (int i = 1; i < args.length; i++) {
                pstmt.setObject(i, args[i]); //这里是表示填入参数的意思，填入"？"占位符
            }

            rs = pstmt.executeQuery();
        } catch (Exception e) {
            close();
            System.err.println("\r\n查询数据失败：" + e.getMessage() + "\r\n");
        }
        return rs;
    }


    public static void close() {
        if (rs != null) {
            try {
                if (!rs.isClosed()) {
                    rs.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
                System.err.println("\r\n关闭记录集rs失败：" + e.getMessage() + "\r\n");
            }
        }

        if (stmt != null) {
            try {
                if (!stmt.isClosed()) {
                    stmt.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
                System.err.println("\r\n关闭记录集stmt失败：" + e.getMessage() + "\r\n");
            }
        }

        if (pstmt != null) {
            try {
                if (!pstmt.isClosed()) {
                    pstmt.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
                System.err.println("\r\n关闭记录集pstmt失败：" + e.getMessage() + "\r\n");
            }
        }

        if (conn != null) {
            try {
                if (!conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
                System.err.println("\r\n关闭记录集conn失败：" + e.getMessage() + "\r\n");
            }
        }


    }

    public static int update(String... args) {
        return executeUpdate(args);
    }

    public static int delete(String... args) {
        return executeUpdate(args);
    }

    private static int executeUpdate(String... args) {
        int count = 0;
        try {
            if (args == null || args.length == 0)
                return count;
            String sql = args[0];
            if (conn == null || conn.isClosed())
                conn = getConnecion();
            pstmt = conn.prepareStatement(sql);
            for (int i = 1; i < args.length; i++) {
                pstmt.setObject(i, args[i]);
            }
            count = pstmt.executeUpdate();
        } catch (Exception e) {
            System.err.println(e.getMessage());
        } finally {
            close();
        }
        return count;
    }

    public static String insert(String... args) {
        String id = "0";
        int count = 0;
        try {
            if (args == null || args.length == 0)
                return id;
            String sql = args[0];
            if (conn == null || conn.isClosed())
                conn = getConnecion();

            pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            //预处理事物，加第二个参数是为了获得新的记录id

            for (int i = 1; i < args.length; i++) {
                pstmt.setObject(i, args[i]);
            }
            count = pstmt.executeUpdate();

            if (count == 0) {
                return id;
            }

            rs = pstmt.getGeneratedKeys();

            if (rs == null) {
                return id;
            }else {
                id = "2";
            }
        } catch (Exception e) {
            System.err.println(e.getMessage());
        } finally {
            close();
        }
        return id;
    }

}
