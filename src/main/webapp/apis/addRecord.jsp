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
    RecordDAO recordDAO = RecordDAO.getInstance();
	JSONObject requestData = Utils.getJsonFromRequest(request);
	String characterId = (String)requestData.get("characterId");
    String mapNo = (String)requestData.get("mapNo");
    long playtimeLong = (long)requestData.get("playtime");
    int playtime = (int)playtimeLong;
	
    HashMap<String, Object> obj = new HashMap<String, Object>();
    if(characterId==null||mapNo==null||playtime==0){
        response.setStatus(401);
        obj.put("message", "fail");
    }else{
        response.setStatus(200);
        if(recordDAO.addRecord(new RecordDTO(characterId, mapNo, playtime))){
            obj.put("message", "success");
        }else{
            obj.put("message", "fail");
        }
    }
    
    response.getWriter().write(new JSONObject(obj).toString());
	
%>