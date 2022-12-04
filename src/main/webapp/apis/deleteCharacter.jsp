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
//ID는 랜덤생성, name은 받고, lv = 1, exp= 0, skillid 입력, 어빌 030로 찍어주기
    CharacterDAO characterDAO = CharacterDAO.getInstance();
    List<CharacterDTO> characterDTOList = characterDAO.getCharacterList();
    JSONObject jsonObj = Utils.getJsonFromRequest(request);
    HashMap<String, Object> obj = new HashMap<String, Object>();

    String characterId = (String)jsonObj.get("characterId");

    if(characterId==null){
        response.setStatus(401);
        obj.put("message", "fail");
    }else{
        response.setStatus(200);

        if(characterDAO.deleteCharacter(characterId)){
            obj.put("message", "success");
        }
        else obj.put("message", "fail");
    }
    response.getWriter().write(new JSONObject(obj).toString());
%>