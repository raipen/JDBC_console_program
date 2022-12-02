package DAO;


import java.util.*;

import DTO.*;
import javafx.util.Pair;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import java.sql.*;

public class RecordDAO extends DAO
{

    private static RecordDAO instance;
    private Connection conn = null;
    private PreparedStatement pstmt = null;
    private ResultSet rs = null;

    private RecordDAO()
    {
    }

    public static RecordDAO getInstance()
    {
        if (instance == null)
            instance = new RecordDAO();

        return instance;
    }

    public boolean createRecord(String characterId, String mapNo, String clearTime)
    {
        boolean bool = false;
        try
        {   
            conn = getConnection();
            String sql = "INSERT INTO records VALUES (" +
                    "?," +
                    "?," +
                    "RECORD_SEQ.NEXTVAL," +
                    "?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, characterId);
            pstmt.setString(2, mapNo);
            pstmt.setInt(3, Integer.parseInt(clearTime));
            int rs = pstmt.executeUpdate();

            if (rs == 1)
            {
                bool = true;
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
        return bool;
    }

    public JSONArray getRecords(String userID, String characterId, String mapNO, Boolean showRecordNo)
    {
        JSONArray jsonArray = new JSONArray();
        LinkedList<RecordDTO> rec = new LinkedList<RecordDTO>();

        try
        {
            conn = getConnection();
            String sql = "SELECT U.USERID,\n" +
                    "       C.CHARACTERNAME,\n" +
                    "       M.MAPNO,\n" +
                    "       M.MAPNAME,\n" +
                    "       R.RECORDNO,\n" +
                    "       R.CLEARTIME\n" +
                    "FROM USERS      U,\n" +
                    "     CHARACTERS C,\n" +
                    "     MAPS       M,\n" +
                    "     RECORDS    R\n" +
                    "WHERE U.USERID = C.USERID\n" +
                    "      AND C.CHARACTERID = R.CHARACTERID\n" +
                    "      AND M.MAPNO = R.MAPNO\n";

            if (userID != null)
                sql = sql + "AND U.USERID = '" + userID + "'\n";

            if (characterId != null)
                sql = sql + "AND C.CHARACTERID = '" + characterId + "'\n";

            if (mapNO != null)
                sql = sql + "AND M.MAPNO = " + mapNO + "\n";

            sql = sql + "ORDER BY CLEARTIME ASC, RECORDNO ASC"; // 사용
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();

            while (rs.next())
            {
                HashMap<String, String> obj = new HashMap<String, String>();

                obj.put("userID", rs.getString("USERID"));
                obj.put("characterName", rs.getString("CHARACTERNAME"));
                obj.put("mapNo", String.valueOf(rs.getInt("MAPNO")));
                obj.put("mapName", rs.getString("MAPNAME"));
                if (showRecordNo)
                    obj.put("recordNo", String.valueOf(rs.getInt("RECORDNO")));
                obj.put("clearTime", String.valueOf(rs.getInt("CLEARTIME")));

                jsonArray.add(obj);
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

        return jsonArray;
    }

    public List<RecordDTO> getRecords(String userID, String characterName, String mapNO)
    {
        LinkedList<RecordDTO> rec = new LinkedList<RecordDTO>();

        try
        {
            conn = getConnection();
            String sql = "SELECT C.CHARACTERID,\n" +
                    "       C.CHARACTERNAME,\n" +
                    "       M.MAPNO,\n" +
                    "       M.MAPNAME,\n" +
                    "       R.RECORDNO,\n" +
                    "       R.CLEARTIME\n" +
                    "FROM USERS      U,\n" +
                    "     CHARACTERS C,\n" +
                    "     MAPS       M,\n" +
                    "     RECORDS    R\n" +
                    "WHERE U.USERID = C.USERID\n" +
                    "      AND C.CHARACTERID = R.CHARACTERID\n" +
                    "      AND M.MAPNO = R.MAPNO\n";

            if (userID != null)
                sql = sql + "AND U.USERID = '" + userID + "'\n";

            if (characterName != null)
                sql = sql + "AND C.CHARACTERNAME = '" + characterName + "'\n";

            if (mapNO != null)
                sql = sql + "AND M.MAPNO = " + mapNO + "\n";

            sql = sql + "ORDER BY CLEARTIME ASC, RECORDNO ASC"; // 사용
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();

            while (rs.next())
            {
                rec.add(new RecordDTO(rs.getString("CHARACTERID"),
                        String.valueOf(rs.getInt("MAPNO")),
                        rs.getInt("RECORDNO"),
                        rs.getInt("CLEARTIME"),
                        rs.getString("CHARACTERNAME"), rs.getString("MAPNAME")
                ));
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

        return rec;
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

    public ArrayList<Pair<String, String>> getSkillClearCounts()
    {
        ArrayList<Pair<String, String>> clearCountList = new ArrayList<Pair<String, String>>();
        try
        {
            conn = getConnection();
            String sql = "SELECT\r\n" + "    S.skillname, count(*) AS ClearCount\r\n"
                    + "FROM\r\n" + "    records R, characters C, skills S\r\n"
                    + "WHERE\r\n" + "    R.characterID = C.characterID\r\n"
                    + "    AND C.skillID = S.skillID\r\n" + "group by\r\n"
                    + "    S.skillName";
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();

            while (rs.next())
            {
                clearCountList.add(new Pair<>(rs.getString("skillname"),rs.getString("clearCount")));
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

    public ArrayList<Pair<String, String>> getThreeLifeClearCharacterList(int life,int time)
    {
        ArrayList<Pair<String, String>> clearCountList = new ArrayList<Pair<String, String>>();
        try
        {
            conn = getConnection();
            String sql = "SELECT C.CHARACTERNAME,\n" +
                    "       R.CLEARTIME\n" +
                    "FROM ABILITIES  A,\n" +
                    "     RECORDS    R,\n" +
                    "     CHARACTERS C\n" +
                    "WHERE A.CHARACTERID = C.CHARACTERID\n" +
                    "      AND R.CHARACTERID = C.CHARACTERID\n" +
                    "      AND A.LIFE = ?\n" +
                    "MINUS\n" +
                    "SELECT C.CHARACTERNAME,\n" +
                    "       R.CLEARTIME\n" +
                    "FROM ABILITIES  A,\n" +
                    "     RECORDS    R,\n" +
                    "     CHARACTERS C\n" +
                    "WHERE A.CHARACTERID = C.CHARACTERID\n" +
                    "      AND R.CHARACTERID = C.CHARACTERID\n" +
                    "      AND R.CLEARTIME > ?" +
                    "ORDER BY CLEARTIME ASC";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, life);
            pstmt.setInt(2, time * 1000);
            rs = pstmt.executeQuery();

            while (rs.next())
            {
                clearCountList.add(new Pair<>(rs.getString("charactername"), rs.getString("cleartime")));
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

    public List<String> getCharacterRankList(CharacterDTO character)
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

    public List<RecordDTO> getRecordList(String id)
    {
        List<RecordDTO> RecordList = new LinkedList<RecordDTO>();
        try
        {
            conn = getConnection();
            String sql = "select * "
                    + "from records r,users u,characters c,maps m "
                    + "where m.mapno=r.mapno and r.characterid=c.characterid and u.userid=c.userid and u.userid LIKE ?"
                    + "order by r.cleartime asc, r.recordno asc";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, id);
            rs = pstmt.executeQuery();
            while (rs.next())
            {
                RecordList.add(new RecordDTO(rs.getString("characterID"), rs.getString("mapno"), rs.getInt("recordNo"), rs.getInt("clearTime"), rs.getString("charactername"), rs.getString("mapname")));
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
        return RecordList;
    }

    public List<RecordDTO> getCountRecordList(String id)
    {
        List<RecordDTO> RecordList = new LinkedList<RecordDTO>();
        try
        {
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
            while (rs.next())
            {
                System.out.printf("%-10s %-3d\n", rs.getString("mapname"), rs.getInt("clearcount"));
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
        return RecordList;
    }

    public List<RecordDTO> getSkillRecordList(String id)
    {
        List<RecordDTO> RecordList = new LinkedList<RecordDTO>();
        try
        {
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
            while (rs.next())
            {
                System.out.printf("%-10s %-5d\n", rs.getString("skillname"), rs.getInt("clearcount"));
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
        return RecordList;
    }

}
