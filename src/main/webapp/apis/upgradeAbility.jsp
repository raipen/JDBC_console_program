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
    String ability = (String)requestData.get("ability");
	
    HashMap<String, Object> obj = new HashMap<String, Object>();
    if(characterId==null||ability==null){
        response.setStatus(401);
        obj.put("message", "invalid request");
    }else{
        response.setStatus(200);
        if(characterDAO.upgradeAbility(characterId, ability))
            obj.put("message", "success");
        else
            obj.put("message", "fail");
    }
    
    response.getWriter().write(new JSONObject(obj).toString());
	
%>