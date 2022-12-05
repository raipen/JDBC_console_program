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
        response.sendRedirect("../index.jsp");
    else{
        UserDAO userDAO = UserDAO.getInstance();
        UserDTO user = userDAO.login(id,pw);
        if(user==null){
            response.sendRedirect("../apis/logout.jsp");
        }else{
            CharacterDAO characterDAO = CharacterDAO.getInstance();
            CharacterDTO character = characterDAO.getCharacterInfo(characterId);
            if(character==null){
                response.sendRedirect("../index.jsp");
            }else if(!character.getUserID().equals(user.getUserID())){
                response.sendRedirect("../index.jsp");
            }
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>호반우 런</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <link rel="stylesheet" href="main.css"/>
</head>
<body>
    <header>
    </header>
    <canvas id="game">
    </canvas>
    <footer>
        <canvas id="skill"></canvas>
        <canvas id="item"></canvas>
        <div id="arrow">
            <div></div>
            <div class="arrowbutton" id="up">↑</div>
            <div></div>
            <div class="arrowbutton" id="left">←</div>
            <div class="arrowbutton" id="down">↓</div>
            <div class="arrowbutton" id="right">→</div>
        </div>
        <div id="jump">점프(스페이스바)</div>
        <canvas id="status"></canvas>
    </footer>
    <div id="modal" class="modal">
    </div>
    <script type='module'>
        import {main} from './js/index.js';
        import {ajax,get_cookie} from './js/utils.js';
        const mapNo = location.search.split("=")[1];
        main(mapNo, get_cookie("characterId"));
    </script>
</body>

</html>