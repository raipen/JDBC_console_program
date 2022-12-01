package DAO;

import java.sql.*;
import DTO.*;
import java.util.List;
import java.util.LinkedList;

public class SkillDAO extends DAO{
	
	private static SkillDAO instance;
    private Connection conn = null;
    private PreparedStatement pstmt = null;
    private ResultSet rs = null;

	private SkillDAO() {}
	
    public static SkillDAO getInstance() {
    	if (instance == null)
            instance = new SkillDAO();
    	
        return instance;
    }
	
    public List<SkillDTO> getSkillList() {
        List<SkillDTO> SkillList = new LinkedList<SkillDTO>();
        try{
            conn = getConnection();
            String sql = "select * from skills";
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            while(rs.next()){
                SkillList.add(new SkillDTO(rs.getString("skillID"),rs.getString("skillname"),rs.getString("skillimg"),rs.getInt("duration"),rs.getInt("cooltime")));
            }
        }catch(Exception e){
            e.printStackTrace();
        }finally{
            closeConnection(conn, pstmt, rs);
        }
        return SkillList;
    }
    public SkillDTO getSkillInfo(String skillId) {
        SkillDTO skill = null;

        try{
            conn = getConnection();
            String sql = "SELECT * FROM skills WHERE skillId = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, skillId);
            rs = pstmt.executeQuery();
            if(rs.next()){
                skill = new SkillDTO(rs.getString("skillID"),rs.getString("skillname"),rs.getString("skillimg"),rs.getInt("duration"),rs.getInt("cooltime"));
            }
        }catch(Exception e){
            e.printStackTrace();
        }finally{
            closeConnection(conn, pstmt, rs);
        }
        return skill;
    }

   
}
