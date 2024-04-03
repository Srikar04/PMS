<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="homeStyles.css">
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <title>Apply for Job</title>
</head>
<body class="bg-gray-200">
<div class="container mx-auto">
    <jsp:include page="header.jsp"/>
    <jsp:include page="studentSideBar.jsp"/>
    <div class="p-4 sm:ml-64">
        <div class="p-4 border-2 border-gray-200 border-dashed rounded-lg dark:border-gray-700 mt-14">
            <h1 class="text-3xl font-semibold mb-6 pt-3">Apply for Job</h1>
            <div id="jobDetails" class="mb-6">
                <!-- Job details will be dynamically added here -->
            </div>
            <div class="mb-4">
                <label class="block mb-2 text-sm font-medium text-gray-900 dark:text-white" for="resume">Upload Resume/CV</label>
                <div class="flex justify-center items-center w-full">
                    <label for="resume" class="flex flex-col justify-center items-center w-full bg-gray-50 rounded-lg border-2 border-gray-300 border-dashed cursor-pointer dark:hover:bg-bray-800 dark:bg-gray-700 hover:bg-gray-100 dark:border-gray-600 dark:hover:border-gray-500 dark:hover:bg-gray-600">
                        <div class="flex flex-col justify-center items-center pt-5 pb-6">
                            <svg aria-hidden="true" class="mb-3 w-10 h-10 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M7 16a4 4 0 01-.88-7.903A5 5 0 1115.9 6L16 6a5 5 0 011 9.9M15 13l-3-3m0 0l-3 3m3-3v12"></path></svg>
                            <p class="mb-2 text-sm text-gray-500 dark:text-gray-400"><span class="font-semibold">Click to upload</span> or drag and drop</p>
                            <p class="text-xs text-gray-500 dark:text-gray-400">PDF, DOC or DOCX (MAX. 2MB)</p>
                        </div>
                        <input id="resume" type="file" class="hidden" />
                    </label>
                </div>
            </div>
            <div class="flex items-start mb-6">
                <div class="flex items-center h-5">
                    <input id="selfDeclaration" type="checkbox" value="" class="w-4 h-4 border border-gray-300 rounded bg-gray-50 focus:ring-3 focus:ring-blue-300 dark:bg-gray-700 dark:border-gray-600 dark:focus:ring-blue-600 dark:ring-offset-gray-800 dark:focus:ring-offset-gray-800" required>
                </div>
                <label for="selfDeclaration" class="ml-2 text-sm font-medium text-gray-900 dark:text-gray-300">I hereby declare that all the information provided by me in this application is true and accurate to the best of my knowledge. I understand that any false or misleading information may result in the rejection of my application or termination of employment.</label>
            </div>
            <div class="flex items-start mb-6">
                <div class="flex items-center h-5">
                    <input id="updateProfile" type="checkbox" value="" class="w-4 h-4 border border-gray-300 rounded bg-gray-50 focus:ring-3 focus:ring-blue-300 dark:bg-gray-700 dark:border-gray-600 dark:focus:ring-blue-600 dark:ring-offset-gray-800 dark:focus:ring-offset-gray-800" required>
                </div>
                <label for="updateProfile" class="ml-2 text-sm font-medium text-gray-900 dark:text-gray-300">I have read and understood the privacy policy of this portal and consent to the processing of my personal data for the purpose of job applications and placement activities.</label>
            </div>
            <button type="button" class="text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:outline-none focus:ring-blue-300 font-medium rounded-lg text-sm w-full sm:w-auto px-5 py-2.5 text-center dark:bg-blue-600 dark:hover:bg-blue-700 dark:focus:ring-blue-800" onclick="showConfirmationDialog()">Apply</button>
        </div>
    </div>
</div>
<script>
    $(document).ready(function() {
        // Get the job data from the Apply Now button's data-job attribute
        const jobData = JSON.parse(decodeURIComponent(getUrlParameter('jobData')));

        var jobDetailsHtml = '<div class="grid grid-cols-1 md:grid-cols-2 gap-4">' +
            '<div class="bg-gray-100 p-4 rounded-lg">' +
            '<h2 class="text-lg font-semibold mb-2">Organization</h2>' +
            '<p>' + jobData.OrgName + '</p>' +
            '<p class="mt-2">' + jobData.OrgDesc + '</p>' +
            '</div>' +
            '<div class="bg-gray-100 p-4 rounded-lg">' +
            '<h2 class="text-lg font-semibold mb-2">Job Details</h2>' +
            '<p><span class="font-bold">Job Name:</span> ' + jobData.JobName + '</p>' +
            '<p class="mt-2">' + jobData.JobDesc + '</p>' +
            '</div>' +
            '<div class="bg-gray-100 p-4 rounded-lg">' +
            '<h2 class="text-lg font-semibold mb-2">Qualification</h2>' +
            '<p>' + jobData.Qualification + '</p>' +
            '</div>' +
            '<div class="bg-gray-100 p-4 rounded-lg">' +
            '<h2 class="text-lg font-semibold mb-2">Job Location</h2>' +
            '<p>' + jobData.JobLocation + '</p>' +
            '</div>' +
            '<div class="bg-gray-100 p-4 rounded-lg">' +
            '<h2 class="text-lg font-semibold mb-2">Number of Openings</h2>' +
            '<p>' + jobData.NumberOfOpenings + '</p>' +
            '</div>' +
            '<div class="bg-gray-100 p-4 rounded-lg">' +
            '<h2 class="text-lg font-semibold mb-2">Skills Required</h2>' +
            '<p>' + jobData.SkillsRequired + '</p>' +
            '</div>' +
            '<div class="bg-gray-100 p-4 rounded-lg">' +
            '<h2 class="text-lg font-semibold mb-2">Last Date to Apply</h2>' +
            '<p>' + jobData.LastDateToApply + '</p>' +
            '</div>' +
            '<div class="bg-gray-100 p-4 rounded-lg">' +
            '<h2 class="text-lg font-semibold mb-2">Graduation Year</h2>' +
            '<p>' + jobData.GraduationYear + '</p>' +
            '</div>';

        // Append the job details HTML to the container
        $('#jobDetails').html(jobDetailsHtml);
    });

    function showConfirmationDialog() {
        var content = 'Are you sure you want to apply? This cannot be reversed, and if you want, please update your profile from the Profile Section.';
        var buttons = '<button type="button" class="bg-red-500 hover:bg-red-700 text-white font-bold py-2 px-4 rounded mr-2" onclick="closeDialog()">Cancel</button>' +
            '<button type="button" class="bg-green-500 hover:bg-green-700 text-white font-bold py-2 px-4 rounded" onclick="submitApplication()">Confirm</button>';

        showUniversalDialog(content, buttons);
    }

    function closeDialog() {
        $('#universalDialog').addClass('hidden');
    }

    function submitApplication() {
        // Code to submit the application (e.g., AJAX request)
        console.log('Application submitted');
        closeDialog();
    }

    function getUrlParameter(name) {
        name = name.replace(/[\[]/, '\\[').replace(/[\]]/, '\\]');
        var regex = new RegExp('[\\?&]' + name + '=([^&#]*)');
        var results = regex.exec(window.location.search);
        return results === null ? '' : decodeURIComponent(results[1].replace(/\+/g, ' '));
    }

</script>
</body>
</html>