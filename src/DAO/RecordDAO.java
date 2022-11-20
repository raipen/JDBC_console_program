package DAO;

import java.sql.*;
import DTO.*;
import java.util.List;
import java.util.LinkedList;

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
