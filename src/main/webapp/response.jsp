<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page language="java" import="java.text.*,java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Lab9</title>
</head>
<body>
    <% 
	String serverIP = "localhost";
	String strSID = "xe";
	String portNum = "1600";
	String user = "university";
	String pass = "comp322";
	String url = "jdbc:oracle:thin:@"+serverIP+":"+portNum+":"+strSID;
	System.out.println(url);
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	Class.forName("oracle.jdbc.driver.OracleDriver");
	conn = DriverManager.getConnection(url,user,pass);

    String querys[] = new String[]{
        "select fname,lname from employee join works_on on ssn = essn join project on pno = pnumber where dno = ? and salary <= ? and pname like ?",
        "select Dnumber,Dname,ssn,fname from employee join department on dno = dnumber where super_ssn = ? and address like ?",
        "select distinct lname,pname,hours from employee join works_on on ssn = essn join project on pno = pnumber where  pname = ? and hours >= ?",
        "select distinct fname,lname,hours from employee join works_on on ssn = essn join project on pno = pnumber where  pname like ? and hours >= ?",
        "select lname,fname,dependent_name,D.sex,relationship from employee join dependent D on ssn = essn where super_ssn = ?"
    };
    String parameters[][] = new String[5][];
    parameters[0] = new String[]{request.getParameter("deptNo"),request.getParameter("salary"),request.getParameter("projectName")+"%"};
    parameters[1] = new String[]{request.getParameter("supervisorSSN"),"%"+request.getParameter("address")+"%"};
    parameters[2] = new String[]{request.getParameter("projectName2"),request.getParameter("hours")};
    parameters[3] = new String[]{request.getParameter("projectName3")+"%",request.getParameter("hours2")};
    parameters[4] = new String[]{request.getParameter("supervisorSSN2")};

    for(int i = 0; i < 5; i++){
        pstmt = conn.prepareStatement(querys[i]);
        for(int j = 0; j < parameters[i].length; j++){
            pstmt.setString(j+1,parameters[i][j]);
        }
        rs = pstmt.executeQuery();
        out.println("<h4>------ Q"+(i+1)+" Result --------</h4>");
        out.println("<table border=1>");
        out.println("<tr>");
        int columnCount = rs.getMetaData().getColumnCount();
        for(int j = 0; j < columnCount; j++){
            out.println("<th>"+rs.getMetaData().getColumnName(j+1)+"</th>");
        }
        out.println("</tr>");
        while(rs.next()){
            out.println("<tr>");
            for(int j = 0; j < columnCount; j++){
                out.println("<td>"+rs.getString(j+1)+"</td>");
            }
            out.println("</tr>");
        }
        out.println("</table>");
    }

    rs.close();
	pstmt.close();
	conn.close();
    %>
</body>
</html>