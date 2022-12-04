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
    CharacterDAO characterDAO = CharacterDAO.getInstance();
	JSONObject requestData = Utils.getJsonFromRequest(request);
	String characterId = (String)requestData.get("characterId");
    long expLong = (long)requestData.get("exp");
    int exp = (int)expLong;
	
    HashMap<String, Object> obj = new HashMap<String, Object>();
    if(characterId==null){
        response.setStatus(401);
        obj.put("message", "fail");
    }else{
        response.setStatus(200);
        CharacterDTO characterDTO = characterDAO.addExp(characterId, exp);
        obj.put("lv",characterDTO.getLv());
        obj.put("exp",characterDTO.getExp());
    }
    
    response.getWriter().write(new JSONObject(obj).toString());
	
%>