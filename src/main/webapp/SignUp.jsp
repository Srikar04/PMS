<%--
  Created by IntelliJ IDEA.
  User: srikar
  Date: 14/03/24
  Time: 9:47 pm
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Sign Up</title>
    <!-- Include Tailwind CSS -->
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>

<body class="bg-gray-100 p-8">
<div class="max-w-md mx-auto bg-white rounded p-6 shadow-md">

    <h1 class="text-2xl font-semibold mb-4">Student Sign Up Form</h1>

    <form id="signupForm" action="${pageContext.request.contextPath}/signUp" method="POST" class="space-y-4">

        <div>
            <label for="idNumber" class="block text-sm font-medium text-gray-600">ID Number</label>
            <input type="text" id="idNumber" name="idNumber" class="mt-1 p-2 w-full border rounded-md">
        </div>

        <div>
            <label for="contactNumber" class="block text-sm font-medium text-gray-600">Contact Number</label>
            <input type="text" id="contactNumber" name="contactNumber" class="mt-1 p-2 w-full border rounded-md">
        </div>

        <div>
            <label for="email" class="block text-sm font-medium text-gray-600">Email</label>
            <input type="email" id="email" name="email" class="mt-1 p-2 w-full border rounded-md">
        </div>

        <div>
            <label for="department" class="block text-sm font-medium text-gray-600">Department</label>
            <select id="department" name="department" class="mt-1 p-2 w-full border rounded-md">
                <!-- Options will be dynamically loaded here -->
            </select>
        </div>

        <div>
            <label for="school" class="block text-sm font-medium text-gray-600">School</label>
            <select id="school" name="school" class="mt-1 p-2 w-full border rounded-md">
                <!-- Options will be dynamically loaded here -->
            </select>
        </div>

        <div>
            <label for="gender" class="block text-sm font-medium text-gray-600">Gender</label>
            <select id="gender" name="gender" class="mt-1 p-2 w-full border rounded-md">
                <option value="Male">Male</option>
                <option value="Female">Female</option>
                <option value="Other">Other</option>
            </select>
        </div>

        <div>
            <label for="averageCGPA" class="block text-sm font-medium text-gray-600">Average CGPA</label>
            <input type="number" id="averageCGPA" name="averageCGPA" class="mt-1 p-2 w-full border rounded-md">
        </div>

        <div>
            <label for="course" class="block text-sm font-medium text-gray-600">Course</label>
            <input type="text" id="course" name="course" class="mt-1 p-2 w-full border rounded-md">
        </div>

        <div>
            <label for="startYear" class="block text-sm font-medium text-gray-600">Start Year</label>
            <input type="number" id="startYear" name="startYear" class="mt-1 p-2 w-full border rounded-md">
        </div>

        <div>
            <label for="endYear" class="block text-sm font-medium text-gray-600">End Year</label>
            <input type="number" id="endYear" name="endYear" class="mt-1 p-2 w-full border rounded-md">
        </div>

        <div>
            <button type="button" id="submitBtn" class="bg-blue-500 text-white px-4 py-2 rounded-md hover:bg-blue-600">Submit</button>
        </div>
    </form>
</div>

</body>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
    $(document).ready(function() {

        $("#submitBtn").click(function() {
            if(validateForm())
                submitForm()
        });

        let deptXhr = new XMLHttpRequest();
        deptXhr.onreadystatechange = function () {
            if (deptXhr.readyState === 4 && deptXhr.status === 200) {
                console.log(deptXhr.responseText);
                let departments = JSON.parse(deptXhr.responseText);
                let selectElement = document.getElementById('department');

                // Add options to the select element
                departments.forEach(function (department) {
                    let option = document.createElement('option');
                    option.value = department.trim(); // Trim to remove leading/trailing spaces
                    option.text = department.trim();
                    selectElement.add(option);
                });
            }
        };

        deptXhr.open('GET', 'fetchDepartment', true);
        deptXhr.send();

        let schoolXhr = new XMLHttpRequest();
        schoolXhr.onreadystatechange = function () {
            if (schoolXhr.readyState === 4 && schoolXhr.status === 200) {
                console.log(schoolXhr.responseText);
                let departments = JSON.parse(schoolXhr.responseText);
                let selectElement = document.getElementById('school');

                // Add options to the select element
                departments.forEach(function (department) {
                    let option = document.createElement('option');
                    option.value = department.trim(); // Trim to remove leading/trailing spaces
                    option.text = department.trim();
                    selectElement.add(option);
                });
            }
        };

        schoolXhr.open('GET', 'fetchSchool', true);
        schoolXhr.send();

        // Function to check if a value is a string
        function isString(value) {
            let regex = /^[a-zA-Z\s]+$/;
            return regex.test(value);
        }

        // Function to check if a value is a number
        function isNumber(value) {
            // Regular expression to match floating-point numbers
            let regex = /^[+-]?\d+(\.\d+)?$/;
            return regex.test(value);
        }

        function validateForm() {
            // Get form fields
            let idNumber = $("#idNumber").val().trim();
            let contactNumber = $("#contactNumber").val().trim();
            let email = $("#email").val().trim();
            let averageCGPA = $("#averageCGPA").val();
            let course = $("#course").val().trim();
            let startYear = $("#startYear").val();
            let endYear = $("#endYear").val();

            // Your validation logic here
            // For example, you can check if fields are empty or if they meet certain criteria
            if (idNumber === "" || contactNumber === "" || email === "" || averageCGPA === "" || course === "" || startYear === "" || endYear === "") {
                alert("All fields are required");
                return false;
            }

            // Perform validation checks
            if (idNumber.length !== 8) {
                alert("ID Number must be 8 alphanumeric characters");
                return false;
            }

            if (!isNumber(contactNumber) || contactNumber.length !== 10) {
                alert("Contact Number must be a 10-digit number");
                return false;
            }

            if (!isNumber(averageCGPA)) {
                alert("Average CGPA must be a valid floating-point number");
                return false;
            }

            if (!isString(course)) {
                alert("Course must be a string");
                return false;
            }

            if (parseInt(startYear) >= parseInt(endYear)) {
                alert("Start year must be less than end year");
                return false;
            }

            return true;
        }

        function submitForm() {
            let signupForm = $("#signupForm");
            let formData = signupForm.serialize(); // Serialize form data

            $.ajax({
                url: signupForm.attr("action"),
                method: signupForm.attr("method"),
                data: formData,
                success: function (response) {
                    // Handle the success response as needed
                    alert(response);
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

