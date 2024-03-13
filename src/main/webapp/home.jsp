<%--
  Created by IntelliJ IDEA.
  User: srikar
  Date: 29/02/24
  Time: 10:40 pm
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="homeStyles.css">
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <title>Job Openings</title>
</head>
<body class="bg-gray-200 p-8">

<div class="container mx-auto">

    <h1 class="text-3xl font-semibold mb-6">Job Openings</h1>

    <div class="flex space-x-4">
        <%
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/PMS?useSSL=false&useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", "root", "srikar4103");
                Statement stmt = con.createStatement();
                ResultSet rs = stmt.executeQuery("SELECT * FROM Job");

                while (rs.next()) {
        %>

        <div class="max-w-sm p-6 bg-white border border-gray-200 rounded-lg shadow">
            <h2 class="mb-2 text-xl font-bold text-gray-900"><%= rs.getString("JobDesignation") %></h2>
            <p class="text-gray-600">Organization: <%= rs.getString("OrgName") %></p>
            <p class="text-gray-600">Location: <%= rs.getString("JobLocation") %></p>
            <p class="text-gray-600">Openings: <%= rs.getInt("NumberOfOpenings") %></p>
            <p class="text-gray-600">Qualification: <%= rs.getString("Qualification") %></p>
            <p class="text-gray-600">Skills Required: <%= rs.getString("SkillsRequired") %></p>
            <p class="text-gray-600">Start Date: <%= rs.getDate("StartDate") %></p>
            <p class="text-gray-600">Last Date to Apply: <%= rs.getDate("LastDateToApply") %></p>
            <!-- You can retrieve JobID, but not display it -->
            <%
                int jobID = rs.getInt("JobID");
                // Use jobID as needed, but it won't be displayed on the screen
            %>
            <a href="#" class="inline-flex items-center px-3 py-2 mt-4 text-sm font-medium text-center text-white bg-green-500 rounded-lg hover:bg-green-600 focus:ring-4 focus:outline-none focus:ring-green-300 dark:bg-green-400 dark:hover:bg-green-500 dark:focus:ring-green-600">
                Apply Now
                <svg class="rtl:rotate-180 w-3.5 h-3.5 ms-2" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 14 10">
                    <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M1 5h12m0 0L9 1m4 4L9 9"/>
                </svg>
            </a>
        </div>

        <%
                }
                con.close();
            } catch (Exception e) {
                // Handle exceptions
            }
        %>
    </div>

</div>

</body>
</html>
