package GameManager;

import java.sql.*;
import java.util.LinkedList;
import java.util.List;

import DAO.*;
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

	public List<UserDTO> getUserList(String id)
	{
		List<UserDTO> userList = new LinkedList<UserDTO>();
		try
		{
			conn = getConnection();
			String sql = "SELECT * FROM USERS WHERE userID LIKE ?";

			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, (id == null ? "%" : id));
			rs = pstmt.executeQuery();

			while (rs.next())
				userList.add(new UserDTO(rs.getString("userID"), rs.getString("password")));

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
			String sql = "SELECT * FROM CHARACTERS WHERE characterName LIKE ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, (id == null ? "%" : id));
			rs = pstmt.executeQuery();
			
			while (rs.next())
			{
				characterList.add(new CharacterDTO(rs.getString("characterID"), rs.getString("characterName"),
						rs.getInt("lv"), rs.getInt("exp"), rs.getString("skillID")));
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
				itemList.add(new ItemDTO(rs.getString("itemID"), rs.getString("itemName"), rs.getString("itemImg"),
						rs.getInt("itemCount")));
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
