<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Lịch sử ứng tuyển</title>
        <script src="https://cdn.tailwindcss.com"></script>
    </head>
    <body class="bg-gray-100 min-h-screen">
        <div class="max-w-5xl mx-auto py-10 px-4">
            <h1 class="text-3xl font-bold text-indigo-600 mb-8 text-center">📋 Lịch sử ứng tuyển</h1>

            <c:if test="${empty viewList}">
                <div class="bg-white shadow rounded-xl p-10 text-center text-gray-500">
                    Bạn chưa ứng tuyển công việc nào.
                </div>
            </c:if>

            <c:if test="${not empty viewList}">
                <div class="overflow-hidden bg-white shadow-md rounded-xl">
                    <table class="min-w-full divide-y divide-gray-200">
                        <thead class="bg-indigo-600 text-white">
                            <tr>
                                <th class="px-6 py-3 text-left text-sm font-semibold">Công việc</th>
                                <th class="px-6 py-3 text-left text-sm font-semibold">Ngày nộp</th>
                                <th class="px-6 py-3 text-left text-sm font-semibold">Trạng thái</th>
                                <th class="px-6 py-3 text-left text-sm font-semibold">CV</th>
                            </tr>
                        </thead>

                        <tbody class="divide-y divide-gray-100">
                            <c:forEach var="row" items="${viewList}">
                                <c:set var="app" value="${row.application}" />
                                <c:set var="job" value="${row.job}" />
                                <c:set var="resume" value="${row.resume}" />

                                <tr class="hover:bg-gray-50 transition">
                                    <td class="px-6 py-4">
                                        <a href="home?action=detail&id=${job.jobId}" class="font-medium text-indigo-700 hover:underline">
                                            ${job.title}
                                        </a>
                                        <p class="text-sm text-gray-500">${job.locationName}</p>
                                    </td>

                                    <td class="px-6 py-4 text-sm text-gray-600">
                                        <c:out value="${app.appliedAt.toString().replace('T', ' ')}" />
                                    </td>


                                    <td class="px-6 py-4">
                                        <c:choose>
                                            <c:when test="${app.status eq 'Applied'}">
                                                <span class="bg-blue-100 text-blue-700 px-3 py-1 rounded-full text-sm">Đã nộp</span>
                                            </c:when>
                                            <c:when test="${app.status eq 'Interviewing'}">
                                                <span class="bg-yellow-100 text-yellow-700 px-3 py-1 rounded-full text-sm">Phỏng vấn</span>
                                            </c:when>
                                            <c:when test="${app.status eq 'Offer'}">
                                                <span class="bg-green-100 text-green-700 px-3 py-1 rounded-full text-sm">Đề nghị</span>
                                            </c:when>
                                            <c:when test="${app.status eq 'Hired'}">
                                                <span class="bg-emerald-100 text-emerald-700 px-3 py-1 rounded-full text-sm">Trúng tuyển</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="bg-gray-100 text-gray-700 px-3 py-1 rounded-full text-sm">${app.status}</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>

                                    <td class="px-6 py-4 text-sm text-gray-700">
                                        <a href="${resume.filePath}" class="text-indigo-600 hover:underline" target="_blank">
                                            ${resume.title}
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:if>
        </div>
    </body>
</html>
