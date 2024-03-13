<%--
  Created by IntelliJ IDEA.
  User: srikar
  Date: 29/02/24
  Time: 9:13 pm
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Internship Details Form</title>
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100 p-8">

<div class="max-w-md mx-auto bg-white rounded p-6 shadow-md">

    <h1 class="text-2xl font-semibold mb-4">Placement Details Form</h1>

    <form id="jobForm" action="${pageContext.request.contextPath}/uploadJob" method="POST" class="space-y-4">

        <div>
            <label for="organizationName" class="block text-sm font-medium text-gray-600">Organization Name</label>
            <input type="text" id="organizationName" name="organizationName" class="mt-1 p-2 w-full border rounded-md">
        </div>

        <div>
            <label for="organizationDetails" class="block text-sm font-medium text-gray-600">Organisation Details</label>
            <textarea id="organizationDetails" name="organizationDetails" class="mt-1 p-2 w-full border rounded-md" rows="3"></textarea>
        </div>

        <div>
            <label for="qualificationsRequired" class="block text-sm font-medium text-gray-600">Qualifications Required</label>
            <input type="text" id="qualificationsRequired" name="qualificationsRequired" class="mt-1 p-2 w-full border rounded-md">
        </div>

        <div>
            <label for="numberOfOpenings" class="block text-sm font-medium text-gray-600" >Number of Openings</label>
            <input type="number" id="numberOfOpenings" name="numberOfOpenings" class="mt-1 p-2 w-full border rounded-md" min="1" >
        </div>

        <div>
            <label for="departments" class="block text-sm font-medium text-gray-600">Select a Department</label>
            <select multiple id="departments" class="mt-1 p-2 w-full border rounded-md h-40">
                <!-- Options will be dynamically loaded here -->
            </select>
        </div>

        <div>
            <label for="jobDesignation" class="block text-sm font-medium text-gray-600">Job Designation</label>
            <input type="text" id="jobDesignation" name="jobDesignation" class="mt-1 p-2 w-full border rounded-md">
        </div>

        <div>
            <label for="jobDescription" class="block text-sm font-medium text-gray-600">Job Description</label>
            <textarea id="jobDescription" name="jobDescription" class="mt-1 p-2 w-full border rounded-md" rows="3"></textarea>
        </div>

        <div>
            <label for="jobLocation" class="block text-sm font-medium text-gray-600">Job Location</label>
            <input type="text" id="jobLocation" name="jobLocation" class="mt-1 p-2 w-full border rounded-md">
        </div>

        <div>
            <label for="startDate" class="block text-sm font-medium text-gray-600">Start Date</label>
            <input type="date" id="startDate" name="startDate" class="mt-1 p-2 w-full border rounded-md">
        </div>

        <div>
            <label for="skillsRequired" class="block text-sm font-medium text-gray-600">Skills Required</label>
            <input type="text" id="skillsRequired" name="skillsRequired" class="mt-1 p-2 w-full border rounded-md">
        </div>

        <div>
            <label for="lastDateToApply" class="block text-sm font-medium text-gray-600">Last Date to Apply</label>
            <input type="date" id="lastDateToApply" name="lastDateToApply" class="mt-1 p-2 w-full border rounded-md">
        </div>

        <div>
            <button type="button"  id="submitBtn" class="bg-blue-500 text-white px-4 py-2 rounded-md hover:bg-blue-600">Submit</button>
        </div>

    </form>
</div>

<script>
    $(document).ready(function() {
        console.log("Je");
        let xhr = new XMLHttpRequest();
        xhr.onreadystatechange = function () {
            if (xhr.readyState === 4 && xhr.status === 200) {
                console.log(xhr.responseText);
                let departments = JSON.parse(xhr.responseText);
                let selectElement = document.getElementById('departments');

                // Add options to the select element
                departments.forEach(function (department) {
                    let option = document.createElement('option');
                    option.value = department.trim(); // Trim to remove leading/trailing spaces
                    option.text = department.trim();
                    selectElement.add(option);
               });
            }
        };

        xhr.open('GET', 'fetchDepartment', true);
        xhr.send();

        // Function to validate the form
        function validateForm() {
            // Your validation logic goes here
            let startDate = new Date($("#startDate").val());
            let lastDateToApply = new Date($("#lastDateToApply").val());
            let today = new Date();
            let openings = $("#numberOfOpenings").val();

            if (startDate <= today) {
                alert("Start Date must be after today.");
                return false;
            }

            if (lastDateToApply < startDate) {
                alert("Last Date to Apply must be after Start Date.");
                return false;
            }
            // Validate that Job Location contains only text
            let jobLocation = $("#jobLocation").val();
            if (!/^[a-zA-Z,\s]+$/.test(jobLocation)) {
                alert("Job Location should contain only letters and spaces.");
                return false;
            }

            if(!/^[0-9]+$/.test(openings)){
                alert("Number of openings should be only numbers.");
                return false;
            }

            return true;
        }

        // Function to submit the form using AJAX
        function submitForm() {
            let jobForm =  $("#jobForm");
            let formData = {};
           jobForm.serializeArray().forEach(function(item) {
                formData[item.name] = item.value;
            });

            $.ajax({
                url: jobForm.attr("action"),
                method: jobForm.attr("method"),
                data : formData,
                success: function(response) {
                    // Handle the success response as needed
                    alert("Job Posted Successfully");
                },
                error: function(error) {
                    // Handle the error as needed
                    alert("Some error has Occurred. Please try again.");
                }
            });
        }
    });
</script>



</body>
</html>

