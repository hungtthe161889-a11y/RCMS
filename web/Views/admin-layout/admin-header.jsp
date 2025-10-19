<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- Sidebar -->
<aside id="sidebar"
       class="fixed top-0 left-0 h-screen w-64 bg-emerald-700 text-white flex flex-col shadow-lg z-50 transition-all duration-300">
    <!-- Logo -->
    <div class="flex items-center justify-center gap-2 p-5 border-b border-emerald-600">
        <img src="${pageContext.request.contextPath}/assets/img/logo.png"
             alt="Logo" class="w-10 h-10 bg-white p-1 rounded-md shadow-sm">
        <h1 class="text-lg font-semibold">RCMS Admin</h1>
    </div>

    <!-- Navigation -->
    <nav class="flex-1 overflow-y-auto mt-4 space-y-1 px-3">
        <a href="${pageContext.request.contextPath}/admin/dashboard"
           class="flex items-center gap-3 px-4 py-2 rounded-md hover:bg-emerald-600 transition
           ${pageContext.request.requestURI.endsWith('/dashboard') ? 'bg-emerald-800' : ''}">
            <i class="fa-solid fa-chart-line w-5"></i> Dashboard
        </a>
        <a href="${pageContext.request.contextPath}/applications"
           class="flex items-center gap-3 px-4 py-2 rounded-md hover:bg-emerald-600 transition">
            <i class="fa-solid fa-file-signature w-5"></i> Đơn Ứng Tuyển
        </a>
        <a href="${pageContext.request.contextPath}/jobs"
           class="flex items-center gap-3 px-4 py-2 rounded-md hover:bg-emerald-600 transition">
            <i class="fa-solid fa-briefcase w-5"></i> Tuyển Dụng
        </a>
        <a href="${pageContext.request.contextPath}/applications"
           class="flex items-center gap-3 px-4 py-2 rounded-md hover:bg-emerald-600 transition">
            <i class="fa-solid fa-users w-5"></i> Ứng Viên
        </a>
        <a href="${pageContext.request.contextPath}/admindocument"
           class="flex items-center gap-3 px-4 py-2 rounded-md hover:bg-emerald-600 transition">
            <i class="fa-solid fa-folder-open w-5"></i> Tài Liệu
        </a>
        <a href="${pageContext.request.contextPath}/reports"
           class="flex items-center gap-3 px-4 py-2 rounded-md hover:bg-emerald-600 transition">
            <i class="fa-solid fa-chart-pie w-5"></i> Báo Cáo
        </a>
    </nav>

    <!-- Footer mini -->
    <div class="p-4 border-t border-emerald-600 text-xs text-emerald-100 text-center">
        © 2025 RCMS | Powered by Hung Anh
    </div>
</aside>

<!-- Topbar -->
<header class="fixed top-0 left-64 right-0 bg-white shadow flex justify-between items-center px-6 py-3 z-40">
    <h2 class="text-lg font-semibold text-gray-800 tracking-wide">Bảng điều khiển quản trị</h2>
    <div class="flex items-center gap-4">
        <!-- Notification -->
        <button class="relative text-gray-600 hover:text-emerald-600 transition">
            <i class="fa-regular fa-bell text-xl"></i>
            <span class="absolute -top-1 -right-1 bg-red-500 text-white text-xs rounded-full w-4 h-4 flex items-center justify-center">3</span>
        </button>

        <!-- User Dropdown -->
        <div class="relative group">
            <button class="flex items-center gap-2 focus:outline-none">
                <img src="${pageContext.request.contextPath}/assets/img/default-avatar.png"
                     alt="Avatar" class="w-8 h-8 rounded-full border border-gray-300">
                <span class="font-medium text-sm text-gray-700">
                    <c:out value="${sessionScope.user.fullname != null ? sessionScope.user.fullname : 'Admin'}"/>
                </span>
                <i class="fa-solid fa-caret-down text-gray-500"></i>
            </button>

            <!-- Dropdown -->
            <div class="absolute right-0 mt-2 w-48 bg-white rounded-lg shadow-lg hidden group-hover:block text-gray-700">
                <a href="${pageContext.request.contextPath}/profile" class="block px-4 py-2 hover:bg-gray-100">Hồ sơ cá nhân</a>
                <a href="${pageContext.request.contextPath}/settings" class="block px-4 py-2 hover:bg-gray-100">Cài đặt</a>
                <hr class="my-1 border-gray-200">
                <a href="${pageContext.request.contextPath}/logout" class="block px-4 py-2 text-red-600 hover:bg-red-50">Đăng xuất</a>
            </div>
        </div>
    </div>
</header>
