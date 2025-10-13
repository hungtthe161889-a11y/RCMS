<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<header class="bg-emerald-600 text-white shadow-md sticky top-0 z-50">
    <div class="max-w-7xl mx-auto flex items-center justify-between px-6 py-3">
        <!-- Logo + Brand -->
        <div class="flex items-center space-x-2">
            <img src="${pageContext.request.contextPath}/assets/img/logo.png"
                 alt="Logo" class="w-10 h-10 rounded-md bg-white p-1">
            <a href="${pageContext.request.contextPath}/home"
               class="text-2xl font-semibold text-white hover:text-emerald-100 transition">
                RCMS Portal
            </a>
        </div>

        <!-- Main Navigation -->
        <nav class="hidden md:flex items-center space-x-6 text-sm font-medium">
            <a href="${pageContext.request.contextPath}/home"
               class="hover:text-lime-200 transition">Trang chủ</a>
            <a href="${pageContext.request.contextPath}/jobs"
               class="hover:text-lime-200 transition">Tin tuyển dụng</a>
            <a href="${pageContext.request.contextPath}/candidates"
               class="hover:text-lime-200 transition">Ứng viên</a>
            <a href="${pageContext.request.contextPath}/documents"
               class="hover:text-lime-200 transition">Tài liệu</a>
            <a href="${pageContext.request.contextPath}/about"
               class="hover:text-lime-200 transition">Giới thiệu</a>
        </nav>

        <!-- Right section -->
        <div class="flex items-center space-x-4">
            <!-- Search -->
            <form action="${pageContext.request.contextPath}/search" method="get"
                  class="hidden sm:flex items-center bg-emerald-500 rounded-full px-3 py-1.5 border border-emerald-400 focus-within:ring-2 focus-within:ring-lime-300">
                <input type="text" name="q" placeholder="Tìm kiếm..."
                       class="outline-none text-sm bg-transparent text-white placeholder-white/70 w-32 sm:w-48 focus:w-60 transition-all duration-200">
                <button type="submit" class="text-white hover:text-lime-200">
                    <i class="fa-solid fa-search"></i>
                </button>
            </form>

            <!-- Notifications -->
            <div class="relative">
                <button class="relative text-white hover:text-lime-200">
                    <i class="fa-regular fa-bell text-xl"></i>
                    <span class="absolute -top-1 -right-1 bg-red-500 text-white text-xs rounded-full w-4 h-4 flex items-center justify-center">3</span>
                </button>
            </div>

            <!-- User Dropdown -->
            <div class="relative group">
                <button class="flex items-center space-x-2 focus:outline-none">
                    <img src="${pageContext.request.contextPath}/assets/img/default-avatar.png"
                         alt="Avatar" class="w-8 h-8 rounded-full border border-white/60">
                    <span class="hidden sm:block text-sm font-medium">
                        <c:out value="${sessionScope.user.fullname != null ? sessionScope.user.fullname : 'Khách'}"/>
                    </span>
                    <i class="fa-solid fa-caret-down text-white/80"></i>
                </button>

                <!-- Dropdown -->
                <div class="absolute right-0 mt-2 w-48 bg-white text-gray-700 rounded-lg shadow-lg hidden group-hover:block z-50">
                    <a href="${pageContext.request.contextPath}/profile"
                       class="block px-4 py-2 hover:bg-gray-100">Hồ sơ cá nhân</a>
                    <a href="${pageContext.request.contextPath}/settings"
                       class="block px-4 py-2 hover:bg-gray-100">Cài đặt</a>

                    <c:if test="${sessionScope.user != null && sessionScope.user.roleId == 1}">
                        <a href="${pageContext.request.contextPath}/admin/dashboard"
                           class="block px-4 py-2 text-emerald-700 hover:bg-emerald-50 font-medium">
                            Quản trị viên
                        </a>
                    </c:if>

                    <hr class="my-1 border-gray-200">
                    <a href="${pageContext.request.contextPath}/logout"
                       class="block px-4 py-2 text-red-600 hover:bg-red-50">Đăng xuất</a>
                </div>
            </div>
        </div>

        <!-- Mobile menu button -->
        <button class="md:hidden text-white hover:text-lime-200 text-xl" onclick="toggleMobileMenu()">
            <i class="fa-solid fa-bars"></i>
        </button>
    </div>

    <!-- Mobile Menu -->
    <div id="mobileMenu" class="hidden md:hidden bg-emerald-700 border-t border-emerald-500 px-6 py-3 space-y-2">
        <a href="${pageContext.request.contextPath}/home" class="block text-white hover:text-lime-200">Trang chủ</a>
        <a href="${pageContext.request.contextPath}/jobs" class="block text-white hover:text-lime-200">Tin tuyển dụng</a>
        <a href="${pageContext.request.contextPath}/candidates" class="block text-white hover:text-lime-200">Ứng viên</a>
        <a href="${pageContext.request.contextPath}/documents" class="block text-white hover:text-lime-200">Tài liệu</a>
        <a href="${pageContext.request.contextPath}/about" class="block text-white hover:text-lime-200">Giới thiệu</a>
    </div>
</header>

<script>
    function toggleMobileMenu() {
        const menu = document.getElementById("mobileMenu");
        menu.classList.toggle("hidden");
    }
</script>
