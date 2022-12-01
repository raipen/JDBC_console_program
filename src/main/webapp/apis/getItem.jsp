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
    UserDAO_GM userDAO_gm = UserDAO_GM.getInstance();
	JSONObject requestData = Utils.getJsonFromRequest(request);
	String id = (String)requestData.get("id");
	
	JSONArray objArray = new JSONArray();
	
	List<ItemDTO> itemList = userDAO_gm.getItemList(id);
	
	if(itemList.size()==0){
		response.setStatus(401);
		HashMap<String, Object> obj = new HashMap<String, Object>();
		obj.put("message", "fail");
	}else{
		response.setStatus(200);
		for(ItemDTO I : itemList)
		{
			HashMap<String, Object> obj = new HashMap<String, Object>();
			obj.put("itemID",I.getItemID());
			obj.put("itemName",I.getItemName());
			obj.put("itemCount",I.getItemCount());

			objArray.add(obj);
		}
		
	}
	//System.out.println(objArray.toString());
	
	response.getWriter().write(objArray.toString());
%>