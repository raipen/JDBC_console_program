import java.sql.*;

public class UserDAO extends DAO{
	
	private static UserDAO instance;
    private Connection conn = null;
    private PreparedStatement pstmt = null;
    private ResultSet rs = null;

	private UserDAO() {}
	
    public static UserDAO getInstance() {
    	if (instance == null)
            instance = new UserDAO();
    	
        return instance;
    }
	
    public UserDTO login(String id, String pw) {
        UserDTO user = null;

        try{
            conn = getConnection();
            String sql = "SELECT * FROM USERS WHERE userID = ? AND Password = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, id);
            pstmt.setString(2, pw);
            rs = pstmt.executeQuery();
            if(rs.next()){
                user = new UserDTO(rs.getString("userID"),rs.getString("password"));
            }
        }catch(Exception e){
            e.printStackTrace();
        }finally{
            closeConnection(conn, pstmt, rs);
        }
        return user;
    }

    public boolean signUp(String id, String pw) {
        boolean signUpSuccess = false;
        try{
            conn = getConnection();
            String sql = "INSERT INTO USERS VALUES(?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, id);
            pstmt.setString(2, pw);
            int result = pstmt.executeUpdate();
            if(result == 1){
                signUpSuccess = true;
            }
        }catch(Exception e){
            e.printStackTrace();
        }finally{
            closeConnection(conn, pstmt, rs);
        }
        return signUpSuccess;
    }

    public boolean isExist(String id) {
        boolean result = false;
        try{
            conn = getConnection();
            String sql = "SELECT * FROM USERS WHERE userID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, id);
            rs = pstmt.executeQuery();
            if(rs.next()){
                result = true;
            }
        }catch(Exception e){
            e.printStackTrace();
        }finally{
            closeConnection(conn, pstmt, rs);
        }
        return result;
    }
}
