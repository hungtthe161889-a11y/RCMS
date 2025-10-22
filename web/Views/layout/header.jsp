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

            <!-- Hiển thị menu theo role -->
            <c:choose>
                <c:when test="${sessionScope.user == null}">
                    <!-- Public menu -->
                    <a href="${pageContext.request.contextPath}/jobs"
                       class="hover:text-lime-200 transition">Tin tuyển dụng</a>
                </c:when>
                <c:when test="${sessionScope.user.roleId == 2}">
                    <!-- Candidate menu -->
                    <a href="${pageContext.request.contextPath}/candidate/jobs"
                       class="hover:text-lime-200 transition">Việc làm</a>
                    <a href="${pageContext.request.contextPath}/candidate/applications"
                       class="hover:text-lime-200 transition">Đơn ứng tuyển</a>
                </c:when>
                <c:when test="${sessionScope.user.roleId == 4}">
                    <!-- Recruiter menu -->
                    <a href="${pageContext.request.contextPath}/recruiter/jobs/"
                       class="hover:text-lime-200 transition">Quản lý tin tuyển dụng</a>
                    <a href="${pageContext.request.contextPath}/recruiter/candidates/"
                       class="hover:text-lime-200 transition">Quản lý ứng viên</a>
                </c:when>
                <c:when test="${sessionScope.user.roleId == 3}">
                    <!-- Manager menu -->
                    <a href="${pageContext.request.contextPath}/manager/jobs/"
                       class="hover:text-lime-200 transition">Duyệt tin tuyển dụng</a>
                    <a href="${pageContext.request.contextPath}/manager/dashboard"
                       class="hover:text-lime-200 transition">Dashboard</a>
                </c:when>
            </c:choose>

            <a href="${pageContext.request.contextPath}/about"
               class="hover:text-lime-200 transition">Giới thiệu</a>
        </nav>

        <!-- Right section -->
        <div class="flex items-center space-x-4">
            <!-- Search - chỉ hiển thị cho public và candidate -->
            <c:if test="${sessionScope.user == null || sessionScope.user.roleId == 2}">
                <form action="${pageContext.request.contextPath}/jobs" method="get"
                      class="hidden sm:flex items-center bg-emerald-500 rounded-full px-3 py-1.5 border border-emerald-400 focus-within:ring-2 focus-within:ring-lime-300">
                    <input type="hidden" name="action" value="search">
                    <input type="text" name="keyword" placeholder="Tìm kiếm việc làm..."
                           class="outline-none text-sm bg-transparent text-white placeholder-white/70 w-32 sm:w-48 focus:w-60 transition-all duration-200">
                    <button type="submit" class="text-white hover:text-lime-200">
                        <i class="fa-solid fa-search"></i>
                    </button>
                </form>
            </c:if>

            <!-- Notifications -->
            <c:if test="${sessionScope.user != null}">
                <div class="relative">
                    <button class="relative text-white hover:text-lime-200">
                        <i class="fa-regular fa-bell text-xl"></i>
                        <span class="absolute -top-1 -right-1 bg-red-500 text-white text-xs rounded-full w-4 h-4 flex items-center justify-center">3</span>
                    </button>
                </div>
            </c:if>

            <!-- User Dropdown -->
            <div class="relative group">
                <c:choose>
                    <c:when test="${sessionScope.user == null}">
                        <!-- Chưa đăng nhập -->
                        <div class="flex items-center space-x-2">
                            <a href="${pageContext.request.contextPath}/login" 
                               class="bg-white text-emerald-600 px-4 py-2 rounded-lg hover:bg-gray-100 transition font-medium">
                                Đăng nhập
                            </a>
                            <a href="${pageContext.request.contextPath}/register" 
                               class="bg-emerald-500 text-white px-4 py-2 rounded-lg hover:bg-emerald-400 transition">
                                Đăng ký
                            </a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <!-- Đã đăng nhập -->
                        <button class="flex items-center space-x-2 focus:outline-none">
                            <img src="${pageContext.request.contextPath}/assets/img/default-avatar.png"
                                 alt="Avatar" class="w-8 h-8 rounded-full border border-white/60">
                            <span class="hidden sm:block text-sm font-medium">
                                <c:out value="${sessionScope.user.fullname}"/>
                            </span>
                            <i class="fa-solid fa-caret-down text-white/80"></i>
                        </button>

                        <!-- Dropdown Menu -->
                        <div class="absolute right-0 mt-2 w-48 bg-white text-gray-700 rounded-lg shadow-lg hidden group-hover:block z-50">
                            <a href="${pageContext.request.contextPath}/profile"
                               class="block px-4 py-2 hover:bg-gray-100">
                                <i class="fa-regular fa-user mr-2"></i>Hồ sơ cá nhân
                            </a>

                            <!-- Menu theo role -->
                            <c:choose>
                                <c:when test="${sessionScope.user.roleId == 1}">
                                    <a href="${pageContext.request.contextPath}/admin/dashboard"
                                       class="block px-4 py-2 text-emerald-700 hover:bg-emerald-50 font-medium">
                                        <i class="fa-solid fa-shield-halved mr-2"></i>Quản trị viên
                                    </a>
                                </c:when>
                                <c:when test="${sessionScope.user.roleId == 2}">
                                    <a href="${pageContext.request.contextPath}/candidate/dashboard"
                                       class="block px-4 py-2 text-emerald-700 hover:bg-emerald-50 font-medium">
                                        <i class="fa-regular fa-user mr-2"></i>Ứng viên
                                    </a>
                                </c:when>
                                <c:when test="${sessionScope.user.roleId == 3}">
                                    <a href="${pageContext.request.contextPath}/manager/dashboard"
                                       class="block px-4 py-2 text-emerald-700 hover:bg-emerald-50 font-medium">
                                        <i class="fa-solid fa-user-tie mr-2"></i>Quản lý
                                    </a>
                                </c:when>
                                <c:when test="${sessionScope.user.roleId == 4}">
                                    <a href="${pageContext.request.contextPath}/recruiter/dashboard"
                                       class="block px-4 py-2 text-emerald-700 hover:bg-emerald-50 font-medium">
                                        <i class="fa-solid fa-briefcase mr-2"></i>Recruiter
                                    </a>
                                </c:when>
                            </c:choose>

                            <a href="${pageContext.request.contextPath}/settings"
                               class="block px-4 py-2 hover:bg-gray-100">
                                <i class="fa-solid fa-gear mr-2"></i>Cài đặt
                            </a>

                            <hr class="my-1 border-gray-200">
                            <a href="${pageContext.request.contextPath}/logout"
                               class="block px-4 py-2 text-red-600 hover:bg-red-50">
                                <i class="fa-solid fa-right-from-bracket mr-2"></i>Đăng xuất
                            </a>
                        </div>
                    </c:otherwise>
                </c:choose>
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

        <c:choose>
            <c:when test="${sessionScope.user == null}">
                <a href="${pageContext.request.contextPath}/jobs" class="block text-white hover:text-lime-200">Tin tuyển dụng</a>
            </c:when>
            <c:when test="${sessionScope.user.roleId == 2}">
                <a href="${pageContext.request.contextPath}/candidate/jobs" class="block text-white hover:text-lime-200">Việc làm</a>
                <a href="${pageContext.request.contextPath}/candidate/applications" class="block text-white hover:text-lime-200">Đơn ứng tuyển</a>
            </c:when>
            <c:when test="${sessionScope.user.roleId == 4}">
                <a href="${pageContext.request.contextPath}/recruiter/jobs/" class="block text-white hover:text-lime-200">Quản lý tin tuyển dụng</a>
                <a href="${pageContext.request.contextPath}/recruiter/applications" class="block text-white hover:text-lime-200">Quản lý ứng viên</a>
            </c:when>
            <c:when test="${sessionScope.user.roleId == 3}">
                <a href="${pageContext.request.contextPath}/manager/jobs/" class="block text-white hover:text-lime-200">Duyệt tin tuyển dụng</a>
                <a href="${pageContext.request.contextPath}/manager/dashboard" class="block text-white hover:text-lime-200">Dashboard</a>
            </c:when>
        </c:choose>

        <a href="${pageContext.request.contextPath}/about" class="block text-white hover:text-lime-200">Giới thiệu</a>

        <c:if test="${sessionScope.user == null}">
            <hr class="border-emerald-500">
            <a href="${pageContext.request.contextPath}/login" class="block text-white hover:text-lime-200">Đăng nhập</a>
            <a href="${pageContext.request.contextPath}/register" class="block text-white hover:text-lime-200">Đăng ký</a>
        </c:if>
    </div>
</header>

<script>
    function toggleMobileMenu() {
        const menu = document.getElementById("mobileMenu");
        menu.classList.toggle("hidden");
    }

    // Đóng dropdown khi click ra ngoài
    document.addEventListener('click', function (event) {
        const dropdowns = document.querySelectorAll('.group');
        dropdowns.forEach(dropdown => {
            if (!dropdown.contains(event.target)) {
                const menu = dropdown.querySelector('.hidden');
                if (menu)
                    menu.classList.add('hidden');
            }
        });
    });
</script>