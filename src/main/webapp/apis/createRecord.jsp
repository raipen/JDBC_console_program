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
    String clearTime = (String)requestData.get("clearTime");

    HashMap<String, Object> obj = new HashMap<String, Object>();

	if(characterId==null||mapNo==null||clearTime==null){
		response.setStatus(401);
		obj.put("message", "fail");
	}else{
		response.setStatus(200);

		if(recordDAO.createRecord(characterId, mapNo, clearTime))
            obj.put("message", "success");
        else obj.put("message", "fail");
	}
	//System.out.println(objArray.toString());
	response.getWriter().write(new JSONObject(obj).toString());
%>