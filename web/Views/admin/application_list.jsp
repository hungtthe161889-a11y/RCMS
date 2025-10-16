<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Danh sách đơn ứng tuyển</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 min-h-screen p-10">

    <div class="bg-white shadow-lg rounded-2xl p-8">
        <h2 class="text-2xl font-bold text-gray-800 mb-6">📋 Danh sách Đơn Ứng Tuyển</h2>

        <!-- Hiển thị lỗi nếu có -->
        <c:if test="${not empty error}">
            <div class="p-4 mb-4 text-red-700 bg-red-100 border border-red-200 rounded-lg">
                ${error}
            </div>
        </c:if>

        <!-- Hiển thị thông báo nếu không có dữ liệu -->
        <c:if test="${not empty message}">
            <div class="p-4 mb-4 text-gray-600 bg-gray-100 border border-gray-200 rounded-lg">
                ${message}
            </div>
        </c:if>

        <table class="min-w-full border border-gray-200 text-sm">
            <thead class="bg-gray-200 text-gray-700 uppercase text-sm">
                <tr>
                    <th class="px-4 py-3 text-left">#</th>
                    <th class="px-4 py-3 text-left">Job ID</th>
                    <th class="px-4 py-3 text-left">User ID</th>
                    <th class="px-4 py-3 text-left">Resume ID</th>
                    <th class="px-4 py-3 text-left">Status</th>
                    <th class="px-4 py-3 text-left">Ngày nộp</th>
                    <th class="px-4 py-3 text-center">Thao tác</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="a" items="${applications}" varStatus="loop">
                    <tr class="border-b hover:bg-gray-50">
                        <td class="px-4 py-3">${loop.index + 1}</td>
                        <td class="px-4 py-3">${a.jobId}</td>
                        <td class="px-4 py-3">${a.userId}</td>
                        <td class="px-4 py-3">${a.resumeId}</td>
                        <td class="px-4 py-3">
                            <span class="px-2 py-1 rounded-md 
                                <c:choose>
                                    <c:when test='${a.status eq "Applied"}'>bg-gray-200 text-gray-800</c:when>
                                    <c:when test='${a.status eq "Interviewing"}'>bg-blue-100 text-blue-700</c:when>
                                    <c:when test='${a.status eq "Offer"}'>bg-amber-100 text-amber-700</c:when>
                                    <c:when test='${a.status eq "Hired"}'>bg-green-100 text-green-700</c:when>
                                    <c:otherwise>bg-red-100 text-red-700</c:otherwise>
                                </c:choose>">
                                ${a.status}
                            </span>
                        </td>
                        <td class="px-4 py-3 text-gray-600">
                            ${a.appliedAt}
                        </td>
                        <td class="px-4 py-3 text-center">
                            <a href="applicationtimeline?id=${a.applicationId}"
                               class="text-blue-600 hover:text-blue-800 font-medium">
                               Xem chi tiết ➜
                            </a>
                        </td>
                    </tr>
                </c:forEach>

                <!-- Nếu danh sách rỗng -->
                <c:if test="${empty applications}">
                    <tr>
                        <td colspan="7" class="text-center py-6 text-gray-500">
                            Không có bản ghi nào.
                        </td>
                    </tr>
                </c:if>
            </tbody>
        </table>
    </div>

</body>
</html>
