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
	CharacterDAO characterDAO = CharacterDAO.getInstance();
	JSONObject requestData = Utils.getJsonFromRequest(request);
	String characterId = (String)requestData.get("characterId");
	
	CharacterDTO character = characterDAO.getCharacterInfo(characterId);
	if(character==null){
		response.setStatus(401);
		obj.put("message", "fail");
	}else{
		response.setStatus(200);
		obj.put("characterName",character.getCharacterName());
		obj.put("level",character.getLv());
		obj.put("exp",character.getExp());
		obj.put("skillId",character.getSkillID());	
	}
	
	
	response.getWriter().write(new JSONObject(obj).toString());
%>