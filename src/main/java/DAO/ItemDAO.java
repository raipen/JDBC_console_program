package DAO;

import java.sql.*;
import java.util.LinkedList;
import java.util.List;

import DTO.*;

public class ItemDAO extends DAO
{
    private static ItemDAO instance;
    private Connection conn = null;
    private PreparedStatement pstmt = null;
    private ResultSet rs = null;

    private ItemDAO()
    {
    }

    public static ItemDAO getInstance()
    {
        if (instance == null) instance = new ItemDAO();

        return instance;
    }

    public boolean setItem(ItemDTO item){
        try
        {
            conn = getConnection();
            String sql = "UPDATE OWNS SET ITEMCOUNT = ? WHERE USERID = ? AND ITEMID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, item.getItemCount());
            pstmt.setString(2, item.getId());
            pstmt.setString(3, item.getItemID());
            int result = pstmt.executeUpdate();
        }
        catch (Exception e)
        {
            e.printStackTrace();
            return false;
        }
        finally
        {
            closeConnection(conn, pstmt, rs);
        }
        return true;
    }
    
}