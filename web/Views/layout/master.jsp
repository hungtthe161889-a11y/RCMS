<%-- 
    Document   : master.jsp
    Created on : Oct 10, 2025, 11:14:19 PM
    Author     : Hung
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <title><c:out value="${pageTitle}" /></title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link href="https://cdn.jsdelivr.net/npm/tailwindcss@3.3.0/dist/tailwind.min.css" rel="stylesheet">
    </head>
    <body class="flex flex-col min-h-screen bg-gray-100">
        <!-- Header -->
        <jsp:include page="/Views/layout/header.jsp"/>

        <!-- Main content -->
        <main class="flex-grow">
            <jsp:include page="${contentPage}" />
        </main>

        <!-- Footer -->
        <jsp:include page="/Views/layout/footer.jsp"/>
    </body>

</html>