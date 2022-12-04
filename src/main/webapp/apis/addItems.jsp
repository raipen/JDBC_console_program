<%@ page language="java" contentType="application/json; charset=utf-8"%>
<%@ page language="java" import="java.text.*,java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="utils.*" %>
<%@ page import="DAO.*"%>
<%@ page import="DTO.*"%>
<%@ page import="org.json.simple.JSONObject" %>
<%@ page import="org.json.simple.JSONValue" %>
<%@ page import="org.json.simple.JSONArray" %>
<%@ page import="org.json.simple.parser.JSONParser" %>

<%
    ItemDAO itemDAO = ItemDAO.getInstance();
	JSONObject requestData = Utils.getJsonFromRequest(request);
	String id = (String)requestData.get("userId");
    JSONArray items = (JSONArray)requestData.get("items");
	
    HashMap<String, Object> obj = new HashMap<String, Object>();
    if(id==null){
        response.setStatus(401);
        obj.put("message", "fail");
	    response.getWriter().write(new JSONObject(obj).toString());
    }else{
        response.setStatus(200);
        JSONArray itemArray = new JSONArray();
        for(int i=0;i<items.size();i++){
            String itemID = (String)items.get(i);
            ItemDTO itemDTO = itemDAO.addItem(id, itemID);
            if(itemDTO!=null){
                HashMap<String, Object> itemObj = new HashMap<String, Object>();
                itemObj.put("itemID",itemDTO.getItemID());
                itemObj.put("itemName",itemDTO.getItemName());
                itemObj.put("itemImg",itemDTO.getItemImg());
                itemArray.add(new JSONObject(itemObj));
            }
        }
        response.getWriter().write(itemArray.toString());
    }
	
%>