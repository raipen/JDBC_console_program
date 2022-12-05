<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ page language="java" import="java.text.*,java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="DAO.*"%>
<%@ page import="DTO.*"%>

<%
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
    if(id==null || pw==null || characterId==null)
        response.sendRedirect("index.jsp");
    else{
        UserDAO userDAO = UserDAO.getInstance();
        UserDTO user = userDAO.login(id,pw);
        if(user==null){
            response.sendRedirect("apis/logout.jsp");
        }else{
            CharacterDAO characterDAO = CharacterDAO.getInstance();
            CharacterDTO character = characterDAO.getCharacterInfo(characterId);
            if(character==null){
                response.sendRedirect("index.jsp");
            }else if(!character.getUserID().equals(user.getUserID())){
                response.sendRedirect("index.jsp");
            }
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>호반우 런</title>
    <link rel="stylesheet" href="css/choiceMap.css">
    <link rel="stylesheet" href="css/modal.css">
</head>
<body>
    <header>
    </header>
    <div id="contents">
    </div>
   <div class="modal" id="rank">
   </div>

   <script type='module'>
        import {getMapList} from './js/choiceMap.js';
        getMapList();
    </script>
</body>
</html>