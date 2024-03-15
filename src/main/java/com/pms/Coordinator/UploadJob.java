package com.pms.Coordinator;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.io.FileInputStream;


@WebServlet(name = "uploadJob", value = "/uploadJob")
public class UploadJob extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // TODO Auto-generated method stub
        response.getWriter().append("Served at: ").append(request.getContextPath());
    }

    private static Properties getConnectionData() {
        Properties props = new Properties();

        String fileName = "db.properties";

        // Use the ClassLoader to load the file from the resources directory
        try (InputStream in = UploadJob.class.getClassLoader().getResourceAsStream(fileName)){
            props.load(in);
        } catch (IOException ex) {
            Logger lgr = Logger.getLogger(UploadJob.class.getName());
            lgr.log(Level.SEVERE, ex.getMessage(), ex);
        }
        return props;
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

        // Get the job information from the request

        String organizationName = request.getParameter("organizationName");//graduation yr, dept id,
        String organizationDetails = request.getParameter("organizationDetails");
        String qualificationsRequired = request.getParameter("qualificationsRequired");
        int numberOfOpenings = Integer.parseInt(request.getParameter("numberOfOpenings"));
        String jobLocation = request.getParameter("jobLocation");
        String jobDesignation = request.getParameter("jobDesignation");
        String jobDescription = request.getParameter("jobDescription");
        String startDate = request.getParameter("startDate");
        String skillsRequired = request.getParameter("skillsRequired");
        String lastDateToApply = request.getParameter("lastDateToApply");

        Properties props = getConnectionData();
        String url = props.getProperty("db.url");
        String user = props.getProperty("db.user");
        String passwd = props.getProperty("db.passwd");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

        try (Connection con = DriverManager.getConnection(url, user, passwd)) {
            String query = "INSERT INTO Job (OrgName, OrgDescription, JobDesignation, JobDescription, JobLocation, " +
                    "NumberOfOpenings, Qualification, SkillsRequired, StartDate, LastDateToApply) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            try (PreparedStatement preparedStatement = con.prepareStatement(query)) {
                // Set parameters for the query
                preparedStatement.setString(1, organizationName);
                preparedStatement.setString(2, organizationDetails);
                preparedStatement.setString(3, jobDesignation);
                preparedStatement.setString(4, jobDescription);
                preparedStatement.setString(5, jobLocation);
                preparedStatement.setString(6, String.valueOf(numberOfOpenings));
                preparedStatement.setString(7,qualificationsRequired);
                preparedStatement.setString(8,skillsRequired);
                preparedStatement.setString(9,startDate);
                preparedStatement.setString(10,lastDateToApply);
                // Add other parameters accordingly

                int rowsInserted = preparedStatement.executeUpdate();
                if (rowsInserted > 0) {
                    System.out.println("Job information successfully added.");
                    response.getWriter().write("success");
                } else {
                    System.out.println("Some error has occurred.");
                    response.getWriter().write("error");
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();  // Log the exception for debugging
            String errorMessage = "Some error has occurred";
            response.getWriter().write("error "+ex.getMessage());
        }
    }


}
