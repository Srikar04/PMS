<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>PMS</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<style>
    #universalDialog {
        z-index: 9999; /* Set a high z-index */
    }
</style>
<body>

<%
    // Check if the session exists
    session = request.getSession(false);
    if (session == null || session.getAttribute("userEmail") == null) {
%>
<script>
    // Redirect the user to the login page
    window.location.replace("SignIn.jsp");
</script>
<%
    }
%>


<nav class="fixed top-0 z-50 w-full bg-white border-b border-gray-200 dark:bg-gray-800 dark:border-gray-700">
    <div class="flex flex-wrap justify-between items-center p-4">
        <a href="studentHome.jsp" class="flex items-center space-x-3 rtl:space-x-reverse">
            <img src="https://flowbite.com/docs/images/logo.svg" class="h-8" alt="Flowbite Logo" />
            <span class="self-center text-2xl font-semibold whitespace-nowrap dark:text-white">PMS</span>
        </a>
        <div class="flex items-center space-x-6 rtl:space-x-reverse">
            <%
                session = request.getSession(false);
                if (session != null && session.getAttribute("userEmail") != null) { // User is logged in
            %>
            <a href="LogOut" class="text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:outline-none focus:ring-blue-300 font-medium rounded-full text-sm px-5 py-2.5 text-center dark:bg-blue-600 dark:hover:bg-blue-700 dark:focus:ring-blue-800">Logout</a>
            <% } else { // User is not logged in %>
            <a href="SignIn.jsp" class="text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:outline-none focus:ring-blue-300 font-medium rounded-full text-sm px-5 py-2.5 text-center dark:bg-blue-600 dark:hover:bg-blue-700 dark:focus:ring-blue-800">Login</a>
            <% } %>
        </div>
    </div>
</nav>


<div id="universalDialog" class="fixed z-10 inset-0 overflow-y-auto hidden">
    <div class="flex items-center justify-center min-h-screen">
<%--        <div class="absolute inset-0 transition-opacity" aria-hidden="true">--%>
<%--            <div class="absolute inset-0 bg-gray-500 opacity-75"></div>--%>
<%--        </div>--%>
        <div class="bg-white rounded-lg p-6 shadow-lg">
            <div class="flex justify-end">
                <button id="closeDialogBtn" class="text-gray-500 hover:text-gray-700">
                    <svg class="h-6 w-6" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
                    </svg>
                </button>
            </div>
            <div id="dialogContent" class="mt-4 ">
                <!-- Dialog content will be dynamically added here -->
            </div>
            <div id="dialogButtons" class="mt-6 flex justify-end">
                <!-- Dialog buttons will be dynamically added here -->
            </div>
        </div>
    </div>
</div>

<script>
    function showUniversalDialog(content, buttons) {
        $('#dialogContent').html(content);
        $('#dialogButtons').html(buttons);
        $('#universalDialog').removeClass('hidden');
    }

    $('#closeDialogBtn').click(function() {
        $('#universalDialog').addClass('hidden');
    });
</script>

</body>
