<%@ page import="DAO.RecordDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="DTO.RecordDTO" %>
<%@ page import="utils.Pair" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="DAO.MapDAO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>맵의 모든 발판 조회</title>
    <link rel = "stylesheet" href="stastic.css">

</head>
<body>
<%
    String mapno = request.getParameter("stt5_mapName");
    String mapname="";
    if(mapno.equals("19980001")) mapname = "북문";
    if(mapno.equals("19980002")) mapname = "일청담";
    if(mapno.equals("19980003")) mapname = "백양로";

    out.print("<h2>" + mapname + "맵의 모든 발판 조회</h2>");
%>
<table>
    <thead>
    <th>발판 ID</th>
    <th>positionX</th>
    <th>positionY</th>
    </thead>
    <tbody>
        <%
        MapDAO mapDAO = MapDAO.getInstance();
        List<String> baseList = mapDAO.getBaseOfMap(Integer.parseInt(mapno));

        for (String s:baseList)
        {
            String[] base = s.split("-");
            out.println("<tr>");
            out.println("<td>" + base[0] + "</td>");
            out.println("<td>" + base[1] + "</td>");
            out.println("<td>" + base[2] + "</td>");
            out.println("</tr>");
        }
    %>
    </tbody>
</table>

</body>
</html>
