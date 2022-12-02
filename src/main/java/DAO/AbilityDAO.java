package DAO;

import java.sql.*;
import DTO.*;

public class AbilityDAO extends DAO
{
	private static AbilityDAO instance;
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;

	private AbilityDAO()
	{
	}

	public static AbilityDAO getInstance()
	{
		if (instance == null) instance = new AbilityDAO();

		return instance;
	}

	public AbilityDTO getAbility(CharacterDTO character)
	{
		AbilityDTO result = null;
		try
		{
			conn = getConnection();
			String sql = "SELECT SPEED, LIFE, COOLDOWN FROM ABILITIES, CHARACTERS WHERE ABILITIES.CHARACTERID = CHARACTERS.CHARACTERID AND CHARACTERS.CHARACTERNAME = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, character.getCharacterName());
			rs = pstmt.executeQuery();
			while (rs.next())
				result = new AbilityDTO(character.getCharacterID(),rs.getInt("SPEED"), rs.getInt("LIFE"),
						rs.getInt("COOLDOWN"));
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
	

	public int getTotalAbility(CharacterDTO character)
	{
		int result = 0;
		try
		{
			conn = getConnection();
			String sql = "SELECT SPEED + LIFE + COOLDOWN AS TOTAL FROM ABILITIES, CHARACTERS WHERE ABILITIES.CHARACTERID = CHARACTERS.CHARACTERID AND CHARACTERS.CHARACTERNAME = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, character.getCharacterName());
			rs = pstmt.executeQuery();
			while (rs.next())
				result = rs.getInt("TOTAL");
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
	public AbilityDTO getAbilityInfo(String characterId)
	{
		AbilityDTO result = null;
		try
		{
			conn = getConnection();
			String sql = "SELECT SPEED, LIFE, COOLDOWN FROM ABILITIES Where characterid=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, characterId);
			rs = pstmt.executeQuery();
			while (rs.next())
				result =  new AbilityDTO(characterId,rs.getInt("SPEED"), rs.getInt("LIFE"),
						rs.getInt("COOLDOWN"));
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

	public boolean updateAbility(AbilityDTO ability,int choice,int amount)
	{
		boolean result = false;
		try
		{
			conn = getConnection();
			String sql = "UPDATE ABILITIES SET SPEED = ?, LIFE = ?, COOLDOWN = ? WHERE CHARACTERID = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, ability.getSpeed() + (choice == 1 ? amount : 0));
			pstmt.setInt(2, ability.getLife() + (choice == 2 ? amount : 0));
			pstmt.setInt(3, ability.getCoolDown() + (choice == 3 ? amount : 0));
			pstmt.setString(4, ability.getCharacterID());
			if (pstmt.executeUpdate() > 0) result = true;
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

	public boolean updateAbility(String characterID, int speed, int life, int coolDown)
	{
		boolean result = false;
		try
		{
			conn = getConnection();
			String sql = "UPDATE ABILITIES SET SPEED = ?, LIFE = ?, COOLDOWN = ? WHERE CHARACTERID = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, speed);
			pstmt.setInt(2, life);
			pstmt.setInt(3, coolDown);
			pstmt.setString(4, characterID);
			if (pstmt.executeUpdate() > 0) result = true;
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
}
