<%--
  Created by IntelliJ IDEA.
  User: srikar
  Date: 21/03/24
  Time: 9:49 pm
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Sign In</title>
    <!-- Include Tailwind CSS -->
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>

<body class="bg-gray-100 p-8">

<%--<%@ include file="header.jsp" %>--%>

<div class="max-w-md mx-auto bg-white rounded p-6 shadow-md">

    <h1 class="text-2xl font-semibold mb-4">Student Sign In</h1>

    <form id="signInForm" action="${pageContext.request.contextPath}/signIn" method="POST" class="space-y-4">

        <div>
            <label for="id" class="block text-sm font-medium text-gray-600">Student ID</label>
            <input type="text" id="id" name="id" class="mt-1 p-2 w-full border rounded-md">
        </div>

        <div>
            <label for="password" class="block text-sm font-medium text-gray-600">Password</label>
            <input type="password" id="password" name="password" class="mt-1 p-2 w-full border rounded-md">
        </div>

        <div>
            <button type="button" id="submitBtn" class="bg-blue-500 text-white px-4 py-2 rounded-md hover:bg-blue-600">Sign In</button>
        </div>
    </form>
</div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
    $(document).ready(function() {

        $("#submitBtn").click(function() {
            if(validateForm())
                submitForm()
        });

        function validateForm() {
            let id = $("#id").val().trim();
            let password = $("#password").val().trim();

            if (id === "" || password === "") {
                alert("Email and password are required");
                return false;
            }

            return true;
        }

        function submitForm() {
            let signInForm = $("#signInForm");
            let formData = signInForm.serialize(); // Serialize form data

            $.ajax({
                url: signInForm.attr("action"),
                method: signInForm.attr("method"),
                data: formData,
                success: function (response) {
                    // Handle the success response as needed
                    if (response.trim() === "Success") {
                        // Redirect to home.jsp upon successful sign-in
                        window.location.href = "home.jsp";
                    } else {
                        // Handle other success responses if needed
                        alert(response);
                    }
                },
                error: function (error) {
                    // Handle the error as needed
                    alert("Some error has occurred. Please try again.");
                }
            });
        }
    });
</script>

</body>
</html>
