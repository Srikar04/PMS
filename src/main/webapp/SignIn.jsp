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
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>

<body class="bg-gray-100">

<nav class="fixed top-0 z-50 w-full bg-white border-b border-gray-200 dark:bg-gray-800 dark:border-gray-700">
    <div class="flex flex-wrap justify-between items-center p-4">
        <a href="https://flowbite.com" class="flex items-center space-x-3 rtl:space-x-reverse">
            <img src="https://flowbite.com/docs/images/logo.svg" class="h-8" alt="Flowbite Logo" />
            <span class="self-center text-2xl font-semibold whitespace-nowrap dark:text-white">PMS</span>
        </a>
    </div>
</nav>

<div class="max-w-md mx-auto bg-white rounded p-6 shadow-md mt-20">

    <h1 class="text-2xl font-semibold mb-4">Student Sign In</h1>

    <form id="signInForm" action="${pageContext.request.contextPath}/signIn" method="POST" class="space-y-4">

        <div>
            <label for="email" class="block text-sm font-medium text-gray-600">Email</label>
            <input type="text" id="email" name="email" class="mt-1 p-2 w-full border rounded-md" value="21mcme19@uohyd.ac.in">
        </div>

        <div>
            <label for="password" class="block text-sm font-medium text-gray-600">Password</label>
            <input type="password" id="password" name="password" class="mt-1 p-2 w-full border rounded-md" value="123">
        </div>

        <div>
            <label for="userType" class="block text-sm font-medium text-gray-600">User Type</label>
            <select id="userType" name="userType" class="mt-1 p-2 w-full border rounded-md">
                <option value="Student">Student</option>
                <option value="Coordinator">Coordinator</option>
                <option value="TPO">TPO</option>
                <option value="Chairman">Chairman</option>
            </select>
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
            let email = $("#email").val().trim();
            let password = $("#password").val().trim();

            if (email === "" || password === "") {
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
                    if (response.trim() === "Success") {
                        let userType = $("#userType").val().trim();
                        switch (userType) {
                            case "Student":
                                window.location.href = "studentHome.jsp";
                                break;
                            case "Coordinator":
                                window.location.href = "coordinatorHome.jsp";
                                break;
                            case "TPO":
                                window.location.href = "tpoHome.jsp";
                                break;
                            case "Chairman":
                                window.location.href = "chairmanHome.jsp";
                                break;
                            default:
                                alert("Invalid user type");
                                break;
                        }
                    } else {
                        // Handle incorrect username or password
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
