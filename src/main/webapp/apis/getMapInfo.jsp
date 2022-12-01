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
	HashMap<String, Object> obj = new HashMap<String, Object>();
	MapDAO mapDAO = MapDAO.getInstance();
	JSONObject jsonObj = Utils.getJsonFromRequest(request);
	String mapNo = (String)jsonObj.get("mapNo");
	
	MapDTO map = mapDAO.getMapInfo(mapNo);
	if(map==null){
		response.setStatus(401);
		obj.put("message", "fail");
	}else{
		response.setStatus(200);
		obj.put("mapName",map.getMapname());
		obj.put("backgroundIMG",map.getBackgroundimg());
		obj.put("width",map.getMapsizex());
		obj.put("height",map.getMapsizey());
		obj.put("goalx",map.getGoalx());
		obj.put("goaly",map.getMapsizey());
		obj.put("difficulty",map.getDifficulty());
	}
	
	response.getWriter().write(new JSONObject(obj).toString());
	//System.out.println(new JSONObject(obj).toString());
%>