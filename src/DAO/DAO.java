package DAO;

import java.sql.*;

public class DAO {
    private final String URL = "jdbc:oracle:thin:@localhost:1600:xe";
	private final String USER_UNIVERSITY ="hoban";
	private final String USER_PASSWD ="cowrun";

    protected Connection getConnection() throws ClassNotFoundException, SQLException {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        Connection conn = DriverManager.getConnection(URL, USER_UNIVERSITY, USER_PASSWD);
        return conn;
    }

    protected void closeConnection(Connection conn){
        try {
			if(conn !=null) conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
    }

    protected void closeConnection(Connection conn,PreparedStatement pstmt, ResultSet rs){
        try {
			if(rs != null) rs.close();
			if(pstmt != null) pstmt.close();
			if(conn !=null) conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
    }
}
