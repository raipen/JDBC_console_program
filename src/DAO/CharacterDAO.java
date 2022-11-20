package DAO;

import java.sql.*;
import DTO.*;
import java.util.List;
import java.util.LinkedList;

public class CharacterDAO extends DAO{
	
	private static CharacterDAO instance;
    private Connection conn = null;
    private PreparedStatement pstmt = null;
    private ResultSet rs = null;

	private CharacterDAO() {}
	
    public static CharacterDAO getInstance() {
    	if (instance == null)
            instance = new CharacterDAO();
    	
        return instance;
    }
	
    public CharacterDTO choise(String charactername) {
        CharacterDTO character = null;

        try{
            conn = getConnection();
            String sql = "SELECT * FROM characters WHERE charactername = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, charactername);
            rs = pstmt.executeQuery();
            if(rs.next()){
                character = new CharacterDTO(rs.getString("characterID"), rs.getString("characterName"), rs.getInt("lv"), rs.getInt("exp"));
            }
        }catch(Exception e){
            e.printStackTrace();
        }finally{
            closeConnection(conn, pstmt, rs);
        }
        return character;
    }

    public boolean MakeCharacter(String userid, String characterid, String charactername, String skillid) {
        boolean MakeSuccess = false;
        try{
            conn = getConnection();
            String sql = "INSERT INTO CHARACTERS VALUES(?, ?, ?, ?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, userid);
            pstmt.setString(2, characterid);
            pstmt.setString(3, charactername);
            pstmt.setInt(4, 1); //lv
            pstmt.setInt(5, 0); //exp

            pstmt.executeUpdate();
            
            sql = "INSERT INTO USES VALUES(?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, characterid);
            pstmt.setString(2, skillid);
            
            int result = pstmt.executeUpdate();
            if(result == 1){
            	MakeSuccess = true;
            }
        }catch(Exception e){
            e.printStackTrace();
        }finally{
            closeConnection(conn, pstmt, rs);
        }
        return MakeSuccess;
    }

    public boolean isExist(String charactername) {
        boolean result = false;
        try{
            conn = getConnection();
            String sql = "SELECT * FROM CHARACTERS WHERE charactername = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, charactername);
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
    
    public boolean isExist_id(String characterid) {
        boolean result = false;
        try{
            conn = getConnection();
            String sql = "SELECT * FROM CHARACTERS WHERE characterid = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, characterid);
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

    public boolean deleteCharacter(String characterID) {
        boolean result = false;
        try{
            conn = getConnection();
            String sql = "DELETE FROM Characters WHERE characterid = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, characterID);
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

    public List<ItemDTO> getList(String id) {
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
