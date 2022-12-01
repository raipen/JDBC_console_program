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
	SkillDAO skillDAO = SkillDAO.getInstance();
	JSONObject requestData = Utils.getJsonFromRequest(request);
	String skillId = (String)requestData.get("skillId");
	
	SkillDTO skill = skillDAO.getSkillInfo(skillId);
	if(skill==null){
		response.setStatus(401);
		obj.put("message", "fail");
	}else{
		response.setStatus(200);
		obj.put("skillName",skill.getSkillName());
		obj.put("img",skill.getSkillImg());
		obj.put("duration",skill.getDuration());
		obj.put("cooltime",skill.getCooltime());	
	}
	response.getWriter().write(new JSONObject(obj).toString());
%>