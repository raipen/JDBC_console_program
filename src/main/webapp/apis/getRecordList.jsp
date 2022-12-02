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
	String id = (String)requestData.get("id");
    String characterName = (String)requestData.get("characterName");
    String mapNo = (String)requestData.get("mapNo");

    if(id.equals("")) id = null;
    if(characterName.equals("")) characterName = null;
    if(mapNo.equals("")) mapNo = null;

	JSONArray objArray = new JSONArray();
	
	JSONArray recordList = recordDAO.getRecords(id, characterName, mapNo, true);
	
	if(recordList.size()==0){
		response.setStatus(401);
		HashMap<String, Object> obj = new HashMap<String, Object>();
		obj.put("message", "fail");
	}else{
		response.setStatus(200);
		objArray = recordList;
	}
	//System.out.println(objArray.toString());
	
	response.getWriter().write(objArray.toString());
%>