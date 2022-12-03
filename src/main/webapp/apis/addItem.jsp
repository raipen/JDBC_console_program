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
    ItemDAO itemDAO = ItemDAO.getInstance();
	JSONObject requestData = Utils.getJsonFromRequest(request);
	String id = (String)requestData.get("id");
    String itemId = (String)requestData.get("itemId");
	
    HashMap<String, Object> obj = new HashMap<String, Object>();
    obj.put("result", itemDAO.addItem(id, itemId));
	
	response.getWriter().write(new JSONObject(obj).toString());
%>