package DAO;

import java.sql.*;
import java.util.*;
import DTO.*;

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

    public void updateCharacter(CharacterDTO character) {
    	try {
    		conn = getConnection();
    		pstmt = conn.prepareStatement("UPDATE characters SET lv = ?, exp = ? WHERE characterid=?");
    		pstmt.setInt(1, character.getLv());
    		pstmt.setInt(2, character.getExp());
    		pstmt.setString(3, character.getCharacterID());
    		pstmt.executeUpdate();
    	} catch (Exception e) {
    		e.printStackTrace();
    	} finally {
    		closeConnection(conn, pstmt, rs);
    	}
    }

	public CharacterDTO changeLV(CharacterDTO character, int lv)
	{
		CharacterDTO result = character.copy();
		try
		{
			conn = getConnection();
			String sql = "UPDATE CHARACTERS SET LV = ? WHERE CHARACTERID = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, lv);
			pstmt.setString(2, result.getCharacterID());
			int updateResult = pstmt.executeUpdate();
			if (updateResult == 1)
			{
				result.setLv(lv);
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
		return result;
	}

	public CharacterDTO changeEXP(CharacterDTO character, int exp)
	{
		CharacterDTO result = character.copy();
		try
		{
			conn = getConnection();
			String sql = "UPDATE CHARACTERS SET EXP = ? WHERE CHARACTERID = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, exp);
			pstmt.setString(2, result.getCharacterID());
			int updateResult = pstmt.executeUpdate();
			if (updateResult == 1)
			{
				result.setExp(exp);
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
		return result;
	}

	public List<CharacterDTO_GM> getCharacterList(String id)
	{
		List<CharacterDTO_GM> characterList = new LinkedList<CharacterDTO_GM>();
		try
		{
			conn = getConnection();
			String sql = "SELECT USERID, CHARACTERID, CHARACTERNAME, LV, EXP, SKILLID FROM CHARACTERS, SKILLS WHERE CHARACTERNAME LIKE ? AND CHARACTERS.SKILLID = SKILLS.SKILLID"; // LIKE// //
																																														// 사용
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, (id == null ? "%" : id));
			rs = pstmt.executeQuery();

			while (rs.next())
			{
				characterList.add(new CharacterDTO_GM(rs.getString("USERID"),
						rs.getString("CHARACTERID"), rs.getString("CHARACTERNAME"),
						rs.getInt("LV"), rs.getInt("EXP"), rs.getString("SKILLID")));
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

	public List<String> directSkillCharacterList()
	{
		List<String> characterList = new LinkedList<String>();
		try
		{
			conn = getConnection();
			String sql = "select\r\n" + "    C.charactername, S.skillname\r\n"
					+ "from \r\n"
					+ "    characters C join skills S on C.Skillid = S.Skillid\r\n"
					+ "where C.skillID in (select skillID from skills where duration = 0)";
			pstmt = conn.prepareStatement(sql);
			// pstmt.setString(1, (id == null ? "%" : id));
			rs = pstmt.executeQuery();

			while (rs.next())
			{
				characterList.add("캐릭터명: " + rs.getString("charactername") + "\t스킬명: "
						+ rs.getString("skillname"));
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
	
	public List<String> getcharacterOverSpeedList(int speed)
	{
		List<String> characterList = new LinkedList<String>();
		try
		{
			conn = getConnection();
			String sql = "SELECT\r\n"
					+ "    CHARACTERNAME AS CHARNAME,\r\n"
					+ "    speed            AS speed\r\n"
					+ "FROM\r\n"
					+ "    (                 \r\n"
					+ "        SELECT      \r\n"
					+ "            a.speed,        \r\n"
					+ "            C.charactername\r\n"
					+ "            \r\n"
					+ "        FROM\r\n"
					+ "            CHARACTERS C,\r\n"
					+ "            abilities   a\r\n"
					+ "        WHERE\r\n"
					+ "            a.characterid=c.characterid\r\n"
					+ "    )\r\n"
					+ "WHERE\r\n"
					+ "    speed > ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, speed);
			rs = pstmt.executeQuery();

			while (rs.next())
			{
				characterList.add("캐릭터명: " + rs.getString("CHARNAME") + "\tSPEED: "
						+ rs.getString("speed"));
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
	
    public CharacterDTO choise(String charactername) {
        CharacterDTO character = null;

        try{
            conn = getConnection();
            String sql = "SELECT * FROM characters WHERE charactername = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, charactername);
            rs = pstmt.executeQuery();
            if(rs.next()){
                character = new CharacterDTO(rs.getString("characterID"), rs.getString("characterName"), rs.getInt("lv"), rs.getInt("exp"),rs.getString("skillID"));
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
            String sql = "INSERT INTO CHARACTERS VALUES(?, ?, ?, ?, ?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, userid);
            pstmt.setString(2, characterid);
            pstmt.setString(3, charactername);
            pstmt.setInt(4, 1); //lv
            pstmt.setInt(5, 0); //exp
            pstmt.setString(6, skillid);
            
            
            int result = pstmt.executeUpdate();
            
            sql = "INSERT INTO Abilities VALUES(?, ?, ?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, characterid);
            pstmt.setInt(2, 0); //speed
            pstmt.setInt(3, 3); //life
            pstmt.setInt(4, 0); //cooldown
            result = pstmt.executeUpdate();
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
    
    public void printAbilityList(String id) {
        try{
            conn = getConnection();
            String sql = "SELECT"
            		+ " *"
            		+ " FROM"
            		+ "    characters C, skills S,Abilities A"
            		+ " WHERE"
            		+ "    C.skillID = S.skillID"
            		+ "    AND C.characterID = A.characterID and userid=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, id);
            rs = pstmt.executeQuery();
            while(rs.next()){
            	System.out.printf("%6s:%15s:%3d:%4d:%8d\n",rs.getString("charactername"),rs.getString("skillname"),rs.getInt("speed"),rs.getInt("life"),rs.getInt("cooldown"));
            }
        }catch(Exception e){
            e.printStackTrace();
        }finally{
            closeConnection(conn, pstmt, rs);
        }
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
