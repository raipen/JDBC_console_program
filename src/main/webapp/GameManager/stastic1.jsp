<%@ page import="DAO.RecordDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="DTO.RecordDTO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>전체 클리어 기록 보기</title>
    <link rel = "stylesheet" href="stastic.css">
</head>
<body>
<h2>전체 클리어 기록 보기</h2>
<table>
    <thead>
    <th>No.</th>
    <th>캐릭터ID</th>
    <th>캐릭터 이름</th>
    <th>맵 번호</th>
    <th>맵 이름</th>
    <th>클리어 시간</th>
    </thead>
    <tbody>
    <%
        RecordDAO recordDAO = RecordDAO.getInstance();
        List<RecordDTO> recordList = recordDAO.getRecordList("%");
        for (RecordDTO r : recordList)
        {
            out.println("<tr>");
            out.println("<td>" + r.getRecordno() + "</td>");
            out.println("<td>" + r.getCharacterid() + "</td>");
            out.println("<td>" + r.getCharactername() + "</td>");
            out.println("<td>" + r.getMapno() + "</td>");
            out.println("<td>" + r.getMapname() + "</td>");
            out.println("<td>" + r.getCleartime() + "</td>");
            out.println("</tr>");
        }
    %>
    </tbody>
</table>

</body>
</html>
