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
            		+ "from records r,users u,characters c "
            		+ "where r.characterid=c.characterid and u.userid=c.userid and u.userid = ?"
            		+ "order by c.charactername asc";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, id);
            rs = pstmt.executeQuery();
            while(rs.next()){
                RecordList.add(new RecordDTO(rs.getString("characterID"),rs.getString("mapno"),rs.getInt("recordNo"),rs.getInt("clearTime"),rs.getString("charactername")));
            }
        }catch(Exception e){
            e.printStackTrace();
        }finally{
            closeConnection(conn, pstmt, rs);
        }
        return RecordList;
    }

   
}
