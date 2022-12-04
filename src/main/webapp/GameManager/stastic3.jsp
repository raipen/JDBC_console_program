<%@ page import="DAO.RecordDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="DTO.RecordDTO" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Hashtable" %>
<%@ page import="utils.Pair" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>스킬별 클리어 기록 보기</title>
    <link rel="stylesheet" href="stastic.css">

</head>
<body>
<h2>스킬별 클리어 기록 보기</h2>
<table>
    <thead>
    <th>스킬 이름</th>
    <th>클리어 횟수</th>
    </thead>
    <tbody>
    <%
        RecordDAO recordDAO = RecordDAO.getInstance();
        ArrayList<Pair<String, String>> countList = recordDAO.getSkillClearCounts();

        for (int i = 0; i < countList.size(); i++)
        {
            out.println("<tr>");
            out.println("<td>" + countList.get(i).getKey() + "</td>");
            out.println("<td>" + countList.get(i).getValue() + "</td>");
            out.println("</tr>");
        }
    %>
    </tbody>
</table>

</body>
</html>
