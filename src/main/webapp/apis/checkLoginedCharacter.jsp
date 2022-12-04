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
    Cookie[] cookies = request.getCookies();
    String id = null;
    String pw = null;
    String characterId = null;
    if(cookies!=null){
        for(Cookie cookie : cookies){
            if(cookie.getName().equals("id")){
                id = cookie.getValue();
            }
            if(cookie.getName().equals("pw")){
                pw = cookie.getValue();
            }
            if(cookie.getName().equals("characterId")){
                characterId = cookie.getValue();
            }
        }
    }
    if(id==null || pw==null || characterId==null){
        obj.put("result", false);
    }else{
        UserDAO userDAO = UserDAO.getInstance();
        UserDTO user = userDAO.login(id,pw);
        if(user==null){
            obj.put("result", false);
        }else{
            CharacterDAO characterDAO = CharacterDAO.getInstance();
            CharacterDTO character = characterDAO.getCharacterInfo(characterId);
            if(character==null){
                obj.put("result", false);
            }else if(character.getUserID().equals(user.getUserID())){
                obj.put("result", true);
            }else{
                obj.put("result", false);
            }
        }
    }

    response.setStatus(200);
	response.getWriter().write(new JSONObject(obj).toString());
%>