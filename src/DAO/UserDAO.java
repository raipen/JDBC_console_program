package DAO;

import java.sql.*;
import DTO.*;
import java.util.List;
import java.util.LinkedList;

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

    public UserDTO changePassword(String id, String pw) {
        UserDTO result = null;
        try{
            conn = getConnection();
            String sql = "UPDATE USERS SET password = ? WHERE userID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, pw);
            pstmt.setString(2, id);
            int updateResult = pstmt.executeUpdate();
            if(updateResult == 1){
                result = new UserDTO(id, pw);
            }
        }catch(Exception e){
            e.printStackTrace();
        }finally{
            closeConnection(conn, pstmt, rs);
        }
        return result;
    }

    public boolean deleteAccount(String id) {
        boolean result = false;
        try{
            conn = getConnection();
            String sql = "DELETE FROM USERS WHERE userID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, id);
            int deleteResult = pstmt.executeUpdate();
            if(deleteResult == 1){
                result = true;
            }
        }catch(Exception e){
            e.printStackTrace();
        }finally{
            closeConnection(conn, pstmt, rs);
        }
        return result;
    }

    public List<CharacterDTO> getCharacterList(String id) {
        List<CharacterDTO> characterList = new LinkedList<CharacterDTO>();
        try{
            conn = getConnection();
            String sql = "SELECT * FROM CHARACTERS c, uses u WHERE c.characterid=u.characterid and userID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, id);
            rs = pstmt.executeQuery();
            while(rs.next()){
                characterList.add(new CharacterDTO(rs.getString("characterID"), rs.getString("characterName"), rs.getInt("lv"), rs.getInt("exp"), rs.getString("skillID")));
            }
        }catch(Exception e){
            e.printStackTrace();
        }finally{
            closeConnection(conn, pstmt, rs);
        }
        return characterList;
    }

    public List<ItemDTO> getItemList(String id) {
        List<ItemDTO> itemList = new LinkedList<ItemDTO>();
        try{
            conn = getConnection();
            String sql = "SELECT I.ITEMID, ITEMNAME, ITEMIMG, ITEMCOUNT FROM ITEMS I JOIN OWNS O on I.itemid = O.itemid WHERE userID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, id);
            rs = pstmt.executeQuery();
            while(rs.next()){
                itemList.add(new ItemDTO(rs.getString("itemID"), rs.getString("itemName"), rs.getString("itemImg"), rs.getInt("itemCount")));
            }
        }catch(Exception e){
            e.printStackTrace();
        }finally{
            closeConnection(conn, pstmt, rs);
        }
        return itemList;
    }
}
