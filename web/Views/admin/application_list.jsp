<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Danh sách Đơn Ứng Tuyển</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 min-h-screen p-10">

<div class="bg-white shadow-lg rounded-2xl p-8">
    <h2 class="text-2xl font-bold text-gray-800 mb-6">📋 Danh sách Đơn Ứng Tuyển</h2>

    <table class="min-w-full border border-gray-200 text-sm">
        <thead class="bg-gray-200 text-gray-700 uppercase text-sm">
            <tr>
                <th class="px-4 py-3">#</th>
                <th class="px-4 py-3">Ứng viên</th>
                <th class="px-4 py-3">Vị trí tuyển</th>
                <th class="px-4 py-3">Trạng thái</th>
                <th class="px-4 py-3">Ngày nộp</th>
                <th class="px-4 py-3 text-center">Thao tác</th>
            </tr>
        </thead>
        <tbody>
        <c:forEach var="a" items="${applications}">
            <tr class="border-b hover:bg-gray-50">
                <td class="px-4 py-3">${a.applicationId}</td>
                <td class="px-4 py-3">
                    <c:forEach var="u" items="${users}">
                        <c:if test="${u.userId == a.userId}">${u.fullname}</c:if>
                    </c:forEach>
                </td>
                <td class="px-4 py-3">
                    <c:forEach var="j" items="${jobs}">
                        <c:if test="${j.jobId == a.jobId}">${j.title}</c:if>
                    </c:forEach>
                </td>
                <td class="px-4 py-3">${a.status}</td>
                <td class="px-4 py-3 text-gray-600">${a.appliedAt}</td>
                <td class="px-4 py-3 text-center">
                    <button type="button"
                            class="text-blue-600 hover:text-blue-800 font-medium open-modal-btn"
                            data-id="${a.applicationId}"
                            data-status="${a.status}"
                            data-applied="${a.appliedAt}">
                        Xem chi tiết ➜
                    </button>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<!-- 🪟 MODAL -->
<div id="timelineModal" class="hidden fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50">
    <div class="bg-white rounded-2xl shadow-xl w-full max-w-lg p-8 relative">
        <button id="closeModal" class="absolute top-3 right-3 text-gray-400 hover:text-gray-600 text-xl">✖</button>
        <h3 class="text-xl font-bold text-gray-800 text-center mb-4">📋 Trạng thái Ứng viên</h3>

        <form action="applications" method="post" class="text-center">
            <input type="hidden" name="application_id" id="formAppId">
            <input type="hidden" name="current_status" id="formCurrentStatus">

            <p class="text-center text-gray-600 mb-6">
                ID: <b id="modalAppId"></b> • 
                Trạng thái: <span id="modalStatus" class="font-semibold text-blue-600"></span>
            </p>

            <p class="text-center text-gray-500 mb-6">
                Ngày nộp hồ sơ: <b id="modalAppliedAt"></b>
            </p>

            <button type="submit" id="updateBtn"
                    class="px-6 py-2 bg-blue-600 hover:bg-blue-700 text-white font-medium rounded-xl shadow-md transition">
                Cập nhật trạng thái ➜
            </button>
        </form>
    </div>
</div>

<!-- 🎯 SCRIPT -->
<script>
    const modal = document.getElementById('timelineModal');
    const closeBtn = document.getElementById('closeModal');
    const formAppId = document.getElementById('formAppId');
    const formCurrentStatus = document.getElementById('formCurrentStatus');
    const appIdEl = document.getElementById('modalAppId');
    const statusEl = document.getElementById('modalStatus');
    const appliedEl = document.getElementById('modalAppliedAt');

    document.querySelectorAll('.open-modal-btn').forEach(btn => {
        btn.addEventListener('click', () => {
            formAppId.value = btn.dataset.id;
            formCurrentStatus.value = btn.dataset.status;
            appIdEl.textContent = btn.dataset.id;
            statusEl.textContent = btn.dataset.status;
            appliedEl.textContent = btn.dataset.applied;
            modal.classList.remove('hidden');
        });
    });

    closeBtn.addEventListener('click', () => modal.classList.add('hidden'));
    window.addEventListener('click', e => {
        if (e.target === modal) modal.classList.add('hidden');
    });
</script>

</body>
</html>
