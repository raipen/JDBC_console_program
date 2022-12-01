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
	MapDAO mapDAO = MapDAO.getInstance();
//	JSONObject requestData = Utils.getJsonFromRequest(request);
//	String mapNo = (String)requestData.get("mapNo");
	
	JSONArray objArray = new JSONArray();
	
	List<MapDTO> mapList = mapDAO.getMapList();
	
	if(mapList.size()==0){
		response.setStatus(401);
		HashMap<String, Object> obj = new HashMap<String, Object>();
		obj.put("message", "fail");
	}else{
		response.setStatus(200);
		for(MapDTO M : mapList)
		{
			HashMap<String, Object> obj = new HashMap<String, Object>();
			//x:0,y:34,width:150,height:1
			obj.put("no",M.getMapno());
			obj.put("name",M.getMapname());
			obj.put("difficulty",M.getDifficulty());

			objArray.add(obj);
		}
		
	}
	//System.out.println(objArray.toString());
	
	response.getWriter().write(objArray.toString());
%>