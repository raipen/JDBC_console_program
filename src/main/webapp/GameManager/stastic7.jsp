<%@ page import="DAO.RecordDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="DTO.RecordDTO" %>
<%@ page import="utils.Pair" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="DAO.MapDAO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>너무 어려운 장애물 조회</title>
    <link rel = "stylesheet" href="stastic.css">

</head>
<body>
<%
    String damage = request.getParameter("stt7_damage");
    String sizex = request.getParameter("stt7_sizex");
    String sizey = request.getParameter("stt7_sizey");

    out.print("<h2>데미지가" + damage + " 이상이거나 크기가 " + sizex + "*" + sizey + " 이상인 장애물 조회</h2>");
%>
<table>
    <thead>
    <th>mapNo.</th>
    <th>hurdleNo.</th>
    <th>x축 위치</th>
    <th>y축 위치</th>
    </thead>
    <tbody>
    <%
        MapDAO mapDAO = MapDAO.getInstance();
        List<String> hurdleList = mapDAO.getHardHurdle(Integer.parseInt(damage),
                Integer.parseInt(sizex), Integer.parseInt(sizey));

        for (String s : hurdleList)
        {
            String[] map = s.split("-");
            out.println("<tr>");
            out.println("<td>" + map[0] + "</td>");
            out.println("<td>" + map[1] + "</td>");
            out.println("<td>" + map[2] + "</td>");
            out.println("<td>" + map[3] + "</td>");
            out.println("</tr>");
        }
    %>
    </tbody>
</table>

</body>
</html>
