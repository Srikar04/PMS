package com.pms;

import java.io.*;
import java.util.List;
import java.util.ArrayList;

import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import com.google.gson.Gson;

@WebServlet(name = "fetchDepartment", value = "/fetchDepartment")
public class FetchDepartment extends HttpServlet {
    private String message;

    public void init() {
        message = "Hello World!";
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        List<String> departments = new ArrayList<String>();
        String fileName = "Departments";
        try (InputStream in = FetchDepartment.class.getClassLoader().getResourceAsStream(fileName);
             BufferedReader reader = new BufferedReader(new InputStreamReader(in))) {
            String line;
            while ((line = reader.readLine()) != null) {
                departments.add(line);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }


        // Convert departments to JSON and send as response
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(new Gson().toJson(departments));
    }

    public void destroy() {
    }
}