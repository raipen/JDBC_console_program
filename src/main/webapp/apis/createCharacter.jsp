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
    request.setCharacterEncoding("utf-8");
    List<CharacterDTO> characterDTOList = characterDAO.getCharacterList();
    JSONObject jsonObj = Utils.getJsonFromRequest(request);
    HashMap<String, Object> obj = new HashMap<String, Object>();

    String id = (String)jsonObj.get("id");
    String characterName = (String)jsonObj.get("characterName");
    String skillId = (String)jsonObj.get("skillId");



    if(characterName==null || skillId==null){
        response.setStatus(401);
        obj.put("message", "fail");
    }else{
        response.setStatus(200);
        String characterID = "";
        while(true){
            characterID = String.valueOf((int) (Math.random() * 9)) +
                String.valueOf((int) (Math.random() * 9)) +
                String.valueOf((int) (Math.random() * 9)) +
                String.valueOf((int) (Math.random() * 9)) +
                String.valueOf((int) (Math.random() * 9)) +
                String.valueOf((int) (Math.random() * 9)) +
                String.valueOf((int) (Math.random() * 9)) +
                String.valueOf((int) (Math.random() * 9));
            boolean b = false;
            for(CharacterDTO C:characterDTOList){
                if (C.getCharacterID().equals(characterID))
                {
                    b = true;
                    break;
                }
            }
            if(!b) {
                obj.put("randID",characterID);
                break;
            }
        }
        if(characterDAO.MakeCharacter(id, characterID, characterName,skillId)){
            obj.put("characterID", characterID);
            obj.put("characterName", characterName);
        }
        else{
            response.setStatus(200);
            obj.put("message", "존재하는 캐릭터 이름입니다.");
        }
    }
    response.getWriter().write(new JSONObject(obj).toString());
%>