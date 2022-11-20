package DAO;

import java.sql.*;
import java.util.LinkedList;
import java.util.List;

import DTO.CharacterDTO_GM;
import DTO.UserDTO;

public class CharacterDAO extends DAO
{

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
    
    public CharacterDTO_GM changeLV(CharacterDTO_GM character, int lv) {
        CharacterDTO_GM result = new CharacterDTO_GM(character);
        try{
            conn = getConnection();
            String sql = "UPDATE CHARACTERS SET LV = ? WHERE CHARACTERID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, lv);
            pstmt.setString(2, result.getCharacterID());
            int updateResult = pstmt.executeUpdate();
            if(updateResult == 1){
                result.setLv(lv);
            }
        }catch(Exception e){
            e.printStackTrace();
        }finally{
            closeConnection(conn, pstmt, rs);
        }
        return result;
    }

    public CharacterDTO_GM changeEXP(CharacterDTO_GM character, int exp) {
    	CharacterDTO_GM result = new CharacterDTO_GM(character);
        try{
            conn = getConnection();
            String sql = "UPDATE CHARACTERS SET EXP = ? WHERE CHARACTERID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, exp);
            pstmt.setString(2, result.getCharacterID());
            int updateResult = pstmt.executeUpdate();
            if(updateResult == 1){
                result.setExp(exp);
            }
        }catch(Exception e){
            e.printStackTrace();
        }finally{
            closeConnection(conn, pstmt, rs);
        }
        return result;
    }
    
    public boolean deleteCharacter(String id) {
        boolean result = false;
        try{
            conn = getConnection();
            String sql = "DELETE FROM CHARACTERS WHERE CHARACTERID = ?";
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
    
    public List<CharacterDTO_GM> getCharacterList(String id)
	{
		List<CharacterDTO_GM> characterList = new LinkedList<CharacterDTO_GM>();
		try
		{
			conn = getConnection();
			String sql = "SELECT USERID, CHARACTERID, CHARACTERNAME, LV, EXP, SKILLNAME FROM CHARACTERS, SKILLS WHERE CHARACTERNAME LIKE ? AND CHARACTERS.SKILLID = SKILLS.SKILLID"; // LIKE																																											// 사용
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, (id == null ? "%" : id));
			rs = pstmt.executeQuery();

			while (rs.next())
			{
				characterList.add(new CharacterDTO_GM(rs.getString("USERID"),
						rs.getString("CHARACTERID"), rs.getString("CHARACTERNAME"),
						rs.getInt("LV"), rs.getInt("EXP"), rs.getString("SKILLNAME")));
			}
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}
		finally
		{
			closeConnection(conn, pstmt, rs);
		}
		return characterList;
	}
}
