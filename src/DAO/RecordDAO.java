package DAO;


import java.util.*;
import DTO.*;
import java.sql.*;

public class RecordDAO extends DAO{
	
	private static RecordDAO instance;
    private Connection conn = null;
    private PreparedStatement pstmt = null;
    private ResultSet rs = null;

	private RecordDAO() {}
	
    public static RecordDAO getInstance() {
    	if (instance == null)
            instance = new RecordDAO();
    	
        return instance;
    }
	
	public List<String> getClearRecords()
	{
		List<String> clearRecordList = new LinkedList<String>();
		try
		{
			conn = getConnection();
			String sql = "SELECT\r\n" + "    C.CHARACTERNAME, M.mapname,R.cleartime\r\n"
					+ "FROM\r\n" + "    records R, characters C, maps M\r\n" + "WHERE\r\n"
					+ "    R.characterID = C.characterID\r\n"
					+ "    AND R.mapno = M.mapno"; // 사용
			pstmt = conn.prepareStatement(sql);
			// pstmt.setString(1, (id == null ? "%" : id));
			rs = pstmt.executeQuery();

			while (rs.next())
			{
				clearRecordList.add("캐릭터명: " + rs.getString("CHARACTERNAME") + "\t맵명: "
						+ rs.getString("mapname") + "\t클리어시간: "
						+ rs.getString("cleartime"));
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
		return clearRecordList;
	}

	public List<String> getUserClearCounts()
	{
		List<String> clearCountList = new LinkedList<String>();
		try
		{
			conn = getConnection();
			String sql = "SELECT\r\n"
					+ "    C.userid, M.mapname, count(*) AS clearCount\r\n" + "FROM\r\n"
					+ "    records R, characters C, maps M\r\n" + "WHERE\r\n"
					+ "    R.characterID = C.characterID\r\n"
					+ "    AND R.mapno = M.mapno\r\n" + "GROUP BY\r\n"
					+ "    C.userid,M.mapname";
			pstmt = conn.prepareStatement(sql);
			// pstmt.setString(1, (id == null ? "%" : id));
			rs = pstmt.executeQuery();

			while (rs.next())
			{
				clearCountList.add("계정ID: " + rs.getString("userid") + "\t맵명: "
						+ rs.getString("mapname") + "\t클리어횟수: "
						+ rs.getString("clearCount"));
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

	public List<String> getSkillClearCounts()
	{
		List<String> clearCountList = new LinkedList<String>();
		try
		{
			conn = getConnection();
			String sql = "SELECT\r\n" + "    S.skillname, count(*) AS ClearCount\r\n"
					+ "FROM\r\n" + "    records R, characters C, skills S\r\n"
					+ "WHERE\r\n" + "    R.characterID = C.characterID\r\n"
					+ "    AND C.skillID = S.skillID\r\n" + "group by\r\n"
					+ "    S.skillName";
			pstmt = conn.prepareStatement(sql);
			// pstmt.setString(1, (id == null ? "%" : id));
			rs = pstmt.executeQuery();

			while (rs.next())
			{
				clearCountList.add("스킬명: " + rs.getString("skillname") + "\t클리어횟수: "
						+ rs.getString("clearCount"));
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

	public List<String> getThreeLifeClearCharacterList(int time)
	{
		List<String> clearCountList = new LinkedList<String>();
		try
		{
			conn = getConnection();
			String sql = "select c.charactername, a.life, r.cleartime\r\n"
					+ "from abilities a, records r,characters c \r\n"
					+ "where a.characterid=c.characterid and r.characterid=c.characterid\r\n"
					+ "    and a.life<4\r\n" + "\r\n" + "minus\r\n" + "\r\n"
					+ "select c.charactername, a.life, r.cleartime\r\n"
					+ "from abilities a, records r,characters c \r\n"
					+ "where a.characterid=c.characterid and r.characterid=c.characterid\r\n"
					+ "    and r.cleartime>?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, time * 1000);
			rs = pstmt.executeQuery();

			while (rs.next())
			{
				clearCountList.add("캐릭터명: " + rs.getString("charactername")
						+ "\tLIFE 갯수: " + rs.getString("life") + "\t클리어 시간: "
						+ rs.getString("cleartime"));
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

	public List<String> getCharacterRankList(CharacterDTO_GM character)
	{
		List<String> clearCountList = new LinkedList<String>();
		try
		{
			conn = getConnection();
			String sql = "SELECT M.mapname, count(R.recordNo) as rank\r\n"
					+ "FROM records R join maps M on R.mapno = M.mapno\r\n"
					+ "where R.cleartime <= (SELECT min(clearTime) FROM records where records.characterID = ? and records.mapno=R.mapno)\r\n"
					+ "group by M.mapname";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, character.getCharacterID());
			rs = pstmt.executeQuery();

			while (rs.next())
			{
				clearCountList.add("맵명: " + rs.getString("mapname") + "\t순위: "
						+ rs.getString("rank") + " 위");
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

    public List<RecordDTO> getRecordList(String id) {
        List<RecordDTO> RecordList = new LinkedList<RecordDTO>();
        try{
            conn = getConnection();
            String sql = "select * "
            		+ "from records r,users u,characters c,maps m "
            		+ "where m.mapno=r.mapno and r.characterid=c.characterid and u.userid=c.userid and u.userid = ?"
            		+ "order by c.charactername asc";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, id);
            rs = pstmt.executeQuery();
            while(rs.next()){
                RecordList.add(new RecordDTO(rs.getString("characterID"),rs.getString("mapno"),rs.getInt("recordNo"),rs.getInt("clearTime"),rs.getString("charactername"),rs.getString("mapname")));
            }
        }catch(Exception e){
            e.printStackTrace();
        }finally{
            closeConnection(conn, pstmt, rs);
        }
        return RecordList;
    }
    
    public List<RecordDTO> getCountRecordList(String id) {
        List<RecordDTO> RecordList = new LinkedList<RecordDTO>();
        try{
            conn = getConnection();
            String sql = "SELECT"
            		+ "    M.mapname, count(*) AS clearCount"
            		+ " FROM"
            		+ "    records R, characters C, maps M\r\n"
            		+ " WHERE"
            		+ "    R.characterID = C.characterID"
            		+ "    AND R.mapno = M.mapno and c.userid=?"
            		+ " GROUP BY M.mapname";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, id);
            rs = pstmt.executeQuery();
            while(rs.next()){
                System.out.printf("%-10s %-3d\n",rs.getString("mapname"),rs.getInt("clearcount"));
            }
        }catch(Exception e){
            e.printStackTrace();
        }finally{
            closeConnection(conn, pstmt, rs);
        }
        return RecordList;
    }
    public List<RecordDTO> getSkillRecordList(String id) {
        List<RecordDTO> RecordList = new LinkedList<RecordDTO>();
        try{
            conn = getConnection();
            String sql = "SELECT"
            		+ "    S.skillname, count(*) AS ClearCount"
            		+ " FROM"
            		+ "    records R, characters C, skills S"
            		+ " WHERE"
            		+ "    R.characterID = C.characterID"
            		+ "    AND C.skillID = S.skillID"
            		+ "    and c.userid=?"
            		+ "group by"
            		+ "    S.skillName";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, id);
            rs = pstmt.executeQuery();
            while(rs.next()){
                System.out.printf("%-10s %-5d\n",rs.getString("skillname"),rs.getInt("clearcount"));
            }
        }catch(Exception e){
            e.printStackTrace();
        }finally{
            closeConnection(conn, pstmt, rs);
        }
        return RecordList;
    }

}
