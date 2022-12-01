<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="DTO.*" %>
<%@ page import="java.util.*" %>
<%@ page import="DAO.*" %>
<%!
    UserDAO_GM userDAO_gm = UserDAO_GM.getInstance();
    CharacterDAO characterDAO = CharacterDAO.getInstance();
    SkillDAO skillDAO = SkillDAO.getInstance();
%>

<html>
<head>
    <title>userControl</title>
</head>
<body>
<div style="width: 20%; alignment:left; background-color: blueviolet;">
    <ul style="list-style: none;">
        <%
            List<UserDTO> userList = userDAO_gm.getUserList("%");
            for (UserDTO U : userList)
                out.print("<li style=\"margin:1%\"><button>" + U.getUserID() + "</button></li>");
        %>
    </ul>
</div>
<%
    String id = "kimjhyun0001";
    List<ItemDTO> userItemList = userDAO_gm.getItemList(id);
    List<CharacterDTO_GM> userCharacrterList = userDAO_gm.getCharacterList(id);
%>
<%
    String characterID = "";
    List<CharacterDTO_GM> CharacterSkillList = characterDAO.getCharacterList_GM(characterID);
%>
</body>
</html>
