<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Candidate Timeline</title>
        <script src="https://cdn.tailwindcss.com"></script>
    </head>
    <body class="bg-gray-100 min-h-screen flex flex-col items-center py-10">

        <div class="bg-white shadow-xl rounded-2xl p-8 w-full max-w-3xl">
            <h2 class="text-2xl font-bold text-gray-800 mb-2 text-center">📋 Trạng thái Ứng viên</h2>
            <p class="text-center text-gray-600 mb-6">
                ID: <b>${app.applicationId}</b> • 
                Trạng thái hiện tại: 
                <span class="font-semibold text-blue-600">${app.status}</span>
            </p>

            <!-- Timeline -->
            <div class="flex justify-between items-center relative mx-auto max-w-2xl">
                <c:set var="stages" value="${['Applied','Interviewing','Offer','Hired']}" />
                <c:set var="current" value="${app.status}" />

                <c:forEach var="s" items="${stages}" varStatus="loop">
                    <c:set var="circleColor" value="bg-gray-300" />
                    <c:set var="textColor" value="text-gray-400" />

                    <!-- Xác định màu -->
                    <c:if test="${s == current}">
                        <c:set var="circleColor" value="bg-blue-500" />
                        <c:set var="textColor" value="text-blue-600" />
                    </c:if>
                    <c:if test="${loop.index < stages.indexOf(current)}">
                        <c:set var="circleColor" value="bg-emerald-500" />
                        <c:set var="textColor" value="text-emerald-600" />
                    </c:if>

                    <div class="flex flex-col items-center w-1/4">
                        <div class="flex items-center justify-center w-10 h-10 rounded-full ${circleColor} text-white font-semibold">
                            ${loop.index + 1}
                        </div>
                        <span class="mt-2 text-sm font-medium ${textColor}">${s}</span>

                        <!-- Thanh nối (trừ thằng cuối) -->
                        <c:if test="${!loop.last}">
                            <div class="absolute top-5 left-[calc(12.5%+3rem)] right-[calc(12.5%+3rem)] h-1 bg-gray-300 z-[-1]"></div>
                        </c:if>
                    </div>
                </c:forEach>
            </div>

            <!-- Ngày nộp -->
            <p class="mt-8 text-center text-gray-500">
                Ngày nộp hồ sơ: 
                <b>
                    <c:choose>
                        <c:when test="${not empty app.appliedAt}">
                            ${app.appliedAt}
                        </c:when>
                        <c:otherwise>
                            N/A
                        </c:otherwise>
                    </c:choose>
                </b>
            </p>

            <!-- Form cập nhật -->
            <form action="applicationtimeline" method="post" class="mt-8 text-center">
                <input type="hidden" name="application_id" value="${app.applicationId}" />
                <input type="hidden" name="current_status" value="${app.status}" />

                <c:choose>
                    <c:when test="${app.status != 'Hired'}">
                        <button type="submit" 
                                class="px-6 py-2 bg-blue-600 hover:bg-blue-700 text-white font-medium rounded-xl shadow-md transition">
                            Next Stage ➜
                        </button>
                    </c:when>
                    <c:otherwise>
                        <button type="button" 
                                class="px-6 py-2 bg-emerald-500 text-white font-medium rounded-xl cursor-not-allowed">
                            ✅ Đã hoàn tất
                        </button>
                    </c:otherwise>
                </c:choose>
            </form>
        </div>

    </body>
</html>
