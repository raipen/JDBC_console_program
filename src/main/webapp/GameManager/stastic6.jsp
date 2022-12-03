<%@ page import="DAO.RecordDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="DTO.RecordDTO" %>
<%@ page import="utils.Pair" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="DAO.MapDAO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>일정 시간 이내 클리어한 기록이 있는 맵</title>
</head>
<body>
<%
    String clearTimeStr = request.getParameter("stt6_clearTime");
    int clearTime = Integer.parseInt(clearTimeStr);
    out.print("<h2>" + clearTime + "초 이내 클리어한 기록이 있는 맵</h2>");
%>
<table style="margin: 10%;" border="1">
    <th>No.</th>
    <th>맵 이름</th>
    <%
        MapDAO mapDAO = MapDAO.getInstance();
        List<String> mapList = mapDAO.getMapClearedUnder(clearTime);

        for (String s:mapList)
        {
            String[] map = s.split("-");
            out.println("<tr>");
            out.println("<td>" + map[0] + "</td>");
            out.println("<td>" + map[1] + "</td>");
            out.println("</tr>");
        }
    %>
</table>

</body>
</html>
