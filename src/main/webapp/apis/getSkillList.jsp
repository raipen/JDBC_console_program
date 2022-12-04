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
    SkillDAO skillDAO = SkillDAO.getInstance();
	
   
    response.setStatus(200);
    List<SkillDTO> skillDTOList = skillDAO.getSkillList();
    JSONArray skillList = new JSONArray();
    for(SkillDTO skillDTO : skillDTOList){
        JSONObject skill = new JSONObject();
        skill.put("skillId", skillDTO.getSkillID());
        skill.put("skillName", skillDTO.getSkillName());
        skill.put("skillImg", skillDTO.getSkillImg());

        skillList.add(skill);
    }
    
    response.getWriter().write(skillList.toJSONString());
	
%>