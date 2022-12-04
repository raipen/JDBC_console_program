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
    CharacterDAO characterDAO = CharacterDAO.getInstance();
    List<CharacterDTO> characterDTOList = characterDAO.getCharacterList();

    JSONObject jsonObj = Utils.getJsonFromRequest(request);
    HashMap<String, Object> obj = new HashMap<String, Object>();

    String characterID = (String)jsonObj.get("characterID");
    int lv = Integer.parseInt((String)jsonObj.get("lv"));
    int exp = Integer.parseInt((String)jsonObj.get("exp"));

    if(characterID==null){
        response.setStatus(401);
        obj.put("message", "fail");
    }else{
        response.setStatus(200);
        for(CharacterDTO C:characterDTOList){
            if (C.getCharacterID().equals(characterID))
            {
                if(characterDAO.changeLV(C, lv)!=null && characterDAO.changeEXP(C, exp)!=null){
                obj.put("lv",lv);
                obj.put("exp",exp);
                }
            }
        }
    }
    response.getWriter().write(new JSONObject(obj).toString());
%>