public class UserDAO {
    public static UserDTO login(String id, String pw) {
        //만약 DB에 id와 pw가 일치하는 데이터가 있다면
        return new UserDTO(id, pw);
        //만약 DB에 id와 pw가 일치하는 데이터가 없다면
        //return null;
    }

    public static UserDTO signUp(String id, String pw) {
        //만약 DB에 id와 pw가 일치하는 데이터가 있다면
        //return null;
        //만약 DB에 id와 pw가 일치하는 데이터가 없다면
        return new UserDTO(id, pw);
    }

    public static boolean isExist(String id) {
        //만약 DB에 id와 일치하는 데이터가 있다면
        return true;
        //만약 DB에 id와 일치하는 데이터가 없다면
        //return false;
    }
}
