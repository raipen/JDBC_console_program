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
	AbilityDAO abilityDAO = AbilityDAO.getInstance();
	JSONObject requestData = Utils.getJsonFromRequest(request);
	String characterId = (String)requestData.get("characterId");
	
	AbilityDTO ability = abilityDAO.getAbilityInfo(characterId);
	if(ability==null){
		response.setStatus(401);
		obj.put("message", "fail");
	}else{
		response.setStatus(200);
		obj.put("speed",ability.getSpeed());
		obj.put("life",ability.getLife());
		obj.put("cooldown",ability.getCoolDown());	
	}
	
	response.getWriter().write(new JSONObject(obj).toString());
%>