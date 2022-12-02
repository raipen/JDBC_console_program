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
	BaseDAO baseDAO = BaseDAO.getInstance();
	JSONObject requestData = Utils.getJsonFromRequest(request);
	String mapNo = (String)requestData.get("mapNo");
	
	JSONArray objArray = new JSONArray();
	
	List<BaseDTO> baseList = baseDAO.getBaseList(mapNo);
	
	if(baseList.size()==0){
		response.setStatus(401);
		HashMap<String, Object> obj = new HashMap<String, Object>();
		obj.put("message", "fail");
	}else{
		response.setStatus(200);
		for(BaseDTO i : baseList)
		{
			HashMap<String, Object> obj = new HashMap<String, Object>();
			obj.put("x",i.getPositionX());
			obj.put("y",i.getPositionY());
			obj.put("width",i.getObjSizeX());
			obj.put("height",i.getObjSizeY());
			obj.put("img",i.getObjImg());
			
			objArray.add(obj);
		}
		
	}
	//System.out.println(objArray.toString());
	
	response.getWriter().write(objArray.toString());
%>