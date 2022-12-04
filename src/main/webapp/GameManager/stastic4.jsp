<%@ page import="DAO.RecordDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="DTO.RecordDTO" %>
<%@ page import="utils.Pair" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>전체 클리어 기록 보기</title>
    <link rel="stylesheet" href="stastic.css">

</head>
<body>
<%
    String life = request.getParameter("stt4_life");
    String clearTime = request.getParameter("stt4_clearTime");

    out.print("<h2>목숨" + life + "개로" + clearTime + "초 이내에 클리어한 기록</h2>");
%>
<table>
    <thead>
    <th>캐릭터 이름</th>
    <th>클리어 시간</th>
    </thead>
    <tbody>
    <%
        RecordDAO recordDAO = RecordDAO.getInstance();
        ArrayList<Pair<String, String>> recordList = recordDAO.getThreeLifeClearCharacterList(Integer.parseInt(life)
                , Integer.parseInt(clearTime));
        for (int i = 0; i < recordList.size(); i++)
        {
            out.println("<tr>");
            out.println("<td>" + recordList.get(i).getKey() + "</td>");
            out.println("<td>" + recordList.get(i).getValue() + "</td>");
            out.println("</tr>");
        }
    %>
    </tbody>
</table>

</body>
</html>
