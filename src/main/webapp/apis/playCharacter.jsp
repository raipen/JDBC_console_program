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
	UserDAO userDAO = UserDAO.getInstance();
	JSONObject jsonObj = Utils.getJsonFromRequest(request);
	String characterId = (String)jsonObj.get("characterId");

    response.setStatus(200);
    Cookie characterIdCookie = new Cookie("characterId",characterId);
    characterIdCookie.setPath("/");
    response.addCookie(characterIdCookie);

	response.getWriter().write("{}");
%>