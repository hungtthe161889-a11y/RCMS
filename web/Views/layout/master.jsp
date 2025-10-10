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
        <link href="https://cdn.jsdelivr.net/npm/tailwindcss@3.3.0/dist/tailwind.min.css" rel="stylesheet">
    </head>
    <body class="bg-gray-100 text-gray-900">

        <!-- Include header -->
        <jsp:include page="/Views/layout/header.jsp" />

        <!-- Dynamic Content Area -->
        <main class="container mx-auto mt-6 p-4">
            <jsp:include page="${contentPage}" />
        </main>

        <!-- Include footer -->
        <jsp:include page="/Views/layout/footer.jsp" />

    </body>
</html>