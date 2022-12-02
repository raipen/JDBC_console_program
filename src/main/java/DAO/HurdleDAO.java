package DAO;

import java.sql.*;
import java.util.LinkedList;
import java.util.List;

import DTO.*;

public class HurdleDAO extends DAO
{
	private static HurdleDAO instance;
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;

	private HurdleDAO()
	{
	}

	public static HurdleDAO getInstance()
	{
		if (instance == null) instance = new HurdleDAO();

		return instance;
	}

	public List<HurdleDTO> getHurdleList(String mapNo)
	{
		List<HurdleDTO> hurdleList = new LinkedList<HurdleDTO>();
		try
		{
			conn = getConnection();
			String sql = "SELECT * FROM HURDLES WHERE MAPNO = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mapNo);
			rs = pstmt.executeQuery();
			while (rs.next())
				hurdleList.add(new HurdleDTO(rs.getString("mapNo"),rs.getString("hurdleId"),rs.getInt("positionX"),rs.getInt("positionY"),rs.getInt("objSizeX"),rs.getInt("objSizeY"),rs.getInt("damage"),rs.getString("objImg")));
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}
		finally
		{
			closeConnection(conn, pstmt, rs);
		}
		return hurdleList;
	}
	
	
}
