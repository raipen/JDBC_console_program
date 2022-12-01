package DAO;

import java.sql.*;
import java.util.*;

import DTO.*;

public class UserDAO_GM extends DAO
{
	private static UserDAO_GM instance;
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;

	private UserDAO_GM()
	{
	}

	public static UserDAO_GM getInstance()
	{
		if (instance == null) instance = new UserDAO_GM();

		return instance;
	}

//	public UserDTO changeID(String curid, String newid)
//	{
//		UserDTO result = null;
//		try
//		{
//			conn = getConnection();
//			String sql = "UPDATE USERS SET userID = ? WHERE userID = ?";
//			pstmt = conn.prepareStatement(sql);
//			pstmt.setString(1, newid);
//			pstmt.setString(2, curid);
//			int updateResult = pstmt.executeUpdate();
//			if (updateResult == 1)
//			{
//				result = new UserDTO(curid, newid);
//			}
//		}
//		catch (Exception e)
//		{
//			e.printStackTrace();
//		}
//		finally
//		{
//			closeConnection(conn, pstmt, rs);
//		}
//		return result;
//	}

	public UserDTO changePassword(String id, String pw)
	{
		UserDTO result = null;
		try
		{
			conn = getConnection();
			String sql = "UPDATE USERS SET password = ? WHERE userID = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, pw);
			pstmt.setString(2, id);
			int updateResult = pstmt.executeUpdate();
			if (updateResult == 1)
			{
				result = new UserDTO(id, pw);
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

	public boolean deleteAccount(String id)
	{
		boolean result = false;
		try
		{
			conn = getConnection();
			String sql = "DELETE FROM USERS WHERE userID = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			int deleteResult = pstmt.executeUpdate();
			if (deleteResult == 1)
			{
				result = true;
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

	public List<UserDTO> getUserList(String id)
	{
		List<UserDTO> userList = new LinkedList<UserDTO>();
		try
		{
			conn = getConnection();
			String sql = "SELECT * FROM USERS WHERE userID LIKE ?"; // LIKE 사용

			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, (id == null ? "%" : id));
			rs = pstmt.executeQuery();

			while (rs.next())
				userList.add(
						new UserDTO(rs.getString("userID"), rs.getString("password")));

		}
		catch (Exception e)
		{
			e.printStackTrace();
		}
		finally
		{
			closeConnection(conn, pstmt, rs);
		}
		return userList;
	}

	public List<CharacterDTO> getCharacterList(String id)
	{
		List<CharacterDTO> characterList = new LinkedList<CharacterDTO>();
		try
		{
			conn = getConnection();
			String sql = "SELECT USERID, CHARACTERID, CHARACTERNAME, LV, EXP, SKILLNAME FROM CHARACTERS, SKILLS WHERE USERID LIKE ? AND CHARACTERS.SKILLID = SKILLS.SKILLID"; // LIKE
																																														// 사용
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, (id == null ? "%" : id));
			rs = pstmt.executeQuery();

			while (rs.next())
			{
				characterList.add(new CharacterDTO(rs.getString("USERID"),
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

	public List<ItemDTO> getItemList(String id)
	{
		List<ItemDTO> itemList = new LinkedList<ItemDTO>();
		try
		{
			conn = getConnection();
			String sql = "SELECT I.ITEMID, ITEMNAME, ITEMIMG, ITEMCOUNT FROM ITEMS I JOIN OWNS O on I.itemid = O.itemid WHERE userID = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, (id == null ? "%" : id));
			rs = pstmt.executeQuery();
			while (rs.next())
			{
				itemList.add(new ItemDTO(rs.getString("itemID"), rs.getString("itemName"),
						rs.getString("itemImg"), rs.getInt("itemCount")));
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
		return itemList;
	}

}
