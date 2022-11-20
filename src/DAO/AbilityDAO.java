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

	public AbilityDTO getAbility(CharacterDTO_GM character)
	{
		AbilityDTO result = null;
		try
		{
			conn = getConnection();
			String sql = "SELECT SPEED, LIFE, COOLDOWN FROM ABILITIES, CHARACTERS WHERE ABILITIES.CHARACTERID = CHARACTERS.CHARACTERID AND CHARACTERS.CHARACTERNAME = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, character.getcharacterName());
			rs = pstmt.executeQuery();
			while (rs.next())
				result = new AbilityDTO(rs.getInt("SPEED"), rs.getInt("LIFE"),
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
}
