<%-- 
    Document   : header.jsp
    Created on : Oct 10, 2025, 11:14:40 PM
    Author     : Hung
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<header class="bg-gray-900 text-white p-4">
    <h1 class="text-2xl font-bold">My Website</h1>
    <nav class="mt-2">
        <a href="${pageContext.request.contextPath}/home" class="mr-4 hover:underline">Home</a>
        <a href="${pageContext.request.contextPath}/about" class="hover:underline">About</a>
    </nav>
</header>