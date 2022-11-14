public class UserDAO {
	
	private static UserDAO instance;
	private final String URL = "jdbc:oracle:thin:@localhost:1600:xe";
	private final String USER_UNIVERSITY ="university";
	private final String USER_PASSWD ="comp322";
	private final String TABLE = "users";
	
	private UserDAO() {}
	
    public static UserDAO getInstance() {
    	if (instance == null)
            instance = new UserDAO();
    	
        return instance;
    }
	
    public UserDTO login(String id, String pw) {
        //만약 DB에 id와 pw가 일치하는 데이터가 있다면
        return new UserDTO(id, pw);
        //만약 DB에 id와 pw가 일치하는 데이터가 없다면
        //return null;
    }

    public boolean signUp(String id, String pw) {
        //만약 DB에 id와 일치하는 데이터가 있다면
        //return null;
        //만약 DB에 id와 일치하는 데이터가 없다면
        return true;
    }

    public boolean isExist(String id) {
        //만약 DB에 id와 일치하는 데이터가 있다면
        return true;
        //만약 DB에 id와 일치하는 데이터가 없다면
        //return false;
    }
}
