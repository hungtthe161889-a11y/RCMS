<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="theme-color" content="#047857">
    <title><c:out value="${pageTitle != null ? pageTitle : 'RCMS Admin Portal'}" /></title>

    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>

<body class="bg-gray-100 text-gray-900">

    <!-- Sidebar + Topbar -->
    <jsp:include page="/Views/admin-layout/admin-header.jsp" />

    <!-- Main Content -->
    <main class="mt-3 p-6 min-h-screen bg-gray-50">
        <jsp:include page="${contentPage}" />
    </main>

    <!-- Footer -->
    <jsp:include page="/Views/admin-layout/admin-footer.jsp" />

</body>
</html>
