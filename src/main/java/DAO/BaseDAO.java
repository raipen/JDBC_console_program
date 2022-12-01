package DAO;

import java.sql.*;
import java.util.LinkedList;
import java.util.List;

import DTO.*;

public class BaseDAO extends DAO
{
	private static BaseDAO instance;
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;

	private BaseDAO()
	{
	}

	public static BaseDAO getInstance()
	{
		if (instance == null) instance = new BaseDAO();

		return instance;
	}

	public List<BaseDTO> getBaseList(String mapNo)
	{
		List<BaseDTO> baseList = new LinkedList<BaseDTO>();
		try
		{
			conn = getConnection();
			String sql = "SELECT * FROM BASES WHERE MAPNO = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mapNo);
			rs = pstmt.executeQuery();
			while (rs.next())
				baseList.add(new BaseDTO(rs.getString("mapNo"),rs.getString("baseId"),rs.getInt("positionX"),rs.getInt("positionY"),rs.getInt("objSizeX"),rs.getInt("objSizeY")));
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}
		finally
		{
			closeConnection(conn, pstmt, rs);
		}
		return baseList;
	}
	
	
}
