<%--  Created by IntelliJ IDEA.  User: srikar  Date: 29/02/24  Time: 10:40 pm  To change this template use File | Settings | File Templates.--%>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="homeStyles.css">
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <title>Job Openings</title>
</head>
<body class="bg-gray-200">
<div class="container mx-auto">
    <jsp:include page="header.jsp"/>
    <jsp:include page="studentSideBar.jsp"/>
    <div class="p-4 sm:ml-64">
        <div class="p-4 border-2 border-gray-200 border-dashed rounded-lg dark:border-gray-700 mt-14">
            <h1 class="text-3xl font-semibold mb-6 pt-3">Job Openings</h1>
            <div id="jobCards" class="flex flex-col space-y-4">
                <!-- Job cards will be dynamically added here -->
            </div>
        </div>
    </div>
</div>
<script>
    // Call fetchJobs function when the page loads
    $(document).ready(function() {
        fetchJobs();
    });

    function fetchJobs() {
        $.ajax({
            url: 'fetchJobs',
            type: 'GET',
            success: function(response) {
                // Iterate through each job in the response and create HTML cards
                response.jobs.forEach(function(job) {
                    var cardHtml = '<div class="bg-white border border-gray-200 rounded-lg shadow">' +
                        '<div class="p-6">' +
                        '<p><span class="font-bold">Organization:</span> ' + job.OrgName + '</p>' +
                        '<p><span class="font-bold">Job Name:</span> ' + job.JobName + '</p>' +
                        '<p><span class="font-bold">Qualification:</span> ' + job.Qualification + '</p>' +
                        '<p><span class="font-bold">Number of Openings:</span> ' + job.NumberOfOpenings + '</p>' +
                        '<p><span class="font-bold">Skills Required:</span> ' + job.SkillsRequired + '</p>' +
                        '<p><span class="font-bold">Last Date to Apply:</span> ' + job.LastDateToApply + '</p>' +
                        '<p><span class="font-bold">Graduation Year:</span> ' + job.GraduationYear + '</p>' +
                        '</div>' +
                        '<div class="p-6 border-t border-gray-200">' +
                        '<Button class="applyButton inline-flex items-center px-3 py-2 text-sm font-medium text-center text-white bg-blue-700 rounded-lg hover:bg-blue-800 focus:ring-4 focus:outline-none focus:ring-blue-300 dark:bg-blue-600 dark:hover:bg-blue-700 dark:focus:ring-blue-800" onclick="applyToJob(\'' + encodeURIComponent(JSON.stringify(job)) + '\')">' +
                        'Apply Now' +
                        '</Button>' +
                        '</div>' +
                        '</div>';
                    // Append the card HTML to the job container
                    $('#jobCards').append(cardHtml);
                });
            },
            error: function(xhr, status, error) {
                console.error(error); // Log any errors
            }
        });
    }

    function applyToJob(jobData) {
        // Redirect to the applyToJob.jsp page with the job data passed as a URL parameter
        window.location.href = 'applyToJob.jsp?jobData=' + jobData;
    }
</script>
</body>
</html>