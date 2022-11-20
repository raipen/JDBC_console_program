package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.LinkedList;
import java.util.List;

public class MapDAO extends DAO
{
	private static MapDAO instance;
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;

	private MapDAO()
	{
	}

	public static MapDAO getInstance()
	{
		if (instance == null) instance = new MapDAO();

		return instance;
	}

	public List<String> getBaseOfMap(int mapno)
	{
		List<String> clearCountList = new LinkedList<String>();
		String mapname = null;
		if (mapno == 1) mapname = "북문";
		if (mapno == 2) mapname = "일청담";
		if (mapno == 3) mapname = "센트럴 파크";
		if (mapno == 4) mapname = "IT융복합공학관";

		try
		{
			conn = getConnection();
			String sql = "select baseid\r\n" + "from bases\r\n"
					+ "where mapno in (select mapno\r\n" + "                from maps\r\n"
					+ "                where mapname=?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, (mapname == null ? "%" : mapname));
			rs = pstmt.executeQuery();

			while (rs.next())
			{
				clearCountList.add("ID: " + rs.getString("baseid"));
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
		return clearCountList;
	}

	public List<String> getMapClearedUnder(int cleartime)
	{
		List<String> clearCountList = new LinkedList<String>();

		try
		{
			conn = getConnection();
			String sql = "select mapname \r\n" + "from maps M\r\n"
					+ "where Exists (select * from records R where R.clearTime < ? and R.mapno = M.mapno)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, cleartime * 1000);
			rs = pstmt.executeQuery();

			while (rs.next())
			{
				clearCountList.add("맵이름: " + rs.getString("mapname"));
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
		return clearCountList;
	}

	public List<String> getHardHurdle()
	{
		List<String> clearCountList = new LinkedList<String>();

		try
		{
			conn = getConnection();
			String sql = "select H.positionx, H.positiony\r\n" + "from hurdles H\r\n"
					+ "where damage>=3\r\n" + "\r\n" + "union\r\n" + "\r\n"
					+ "select H.positionx, H.positiony\r\n" + "from hurdles H\r\n"
					+ "where objsizex>50 and objsizey>50";
			pstmt = conn.prepareStatement(sql);
			// pstmt.setInt(1, cleartime*1000);
			rs = pstmt.executeQuery();

			while (rs.next())
			{
				clearCountList.add("x: " + rs.getString("positionx") + "\ty: "
						+ rs.getString("positiony"));
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
		return clearCountList;
	}
}
