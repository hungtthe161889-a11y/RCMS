<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<footer class="bg-emerald-700 text-white mt-10">
    <div class="max-w-7xl mx-auto px-6 py-10 grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-8">
        
        <!-- Logo & Intro -->
        <div>
            <div class="flex items-center space-x-2 mb-3">
                <img src="${pageContext.request.contextPath}/assets/img/logo.png" alt="Logo" class="w-10 h-10 rounded-md bg-white p-1">
                <h2 class="text-xl font-semibold text-white">RCMS Portal</h2>
            </div>
            <p class="text-sm text-emerald-100 leading-relaxed">
                Hệ thống quản lý tuyển dụng & hồ sơ ứng viên tiên tiến.<br>
                Giúp nhà tuyển dụng và ứng viên kết nối hiệu quả hơn.
            </p>
        </div>

        <!-- Quick Links -->
        <div>
            <h3 class="text-lg font-semibold mb-3 text-lime-200">Liên kết nhanh</h3>
            <ul class="space-y-2 text-sm text-emerald-100">
                <li><a href="${pageContext.request.contextPath}/home" class="hover:text-white transition">Trang chủ</a></li>
                <li><a href="${pageContext.request.contextPath}/jobs" class="hover:text-white transition">Tin tuyển dụng</a></li>
                <li><a href="${pageContext.request.contextPath}/candidates" class="hover:text-white transition">Ứng viên</a></li>
                <li><a href="${pageContext.request.contextPath}/about" class="hover:text-white transition">Giới thiệu</a></li>
                <li><a href="${pageContext.request.contextPath}/contact" class="hover:text-white transition">Liên hệ</a></li>
            </ul>
        </div>

        <!-- Contact Info -->
        <div>
            <h3 class="text-lg font-semibold mb-3 text-lime-200">Liên hệ</h3>
            <ul class="text-sm text-emerald-100 space-y-2">
                <li><i class="fa-solid fa-location-dot w-5"></i> 268 Lý Thường Kiệt, Quận 10, TP.HCM</li>
                <li><i class="fa-solid fa-envelope w-5"></i> support@rcms.com</li>
                <li><i class="fa-solid fa-phone w-5"></i> +84 987 654 321</li>
                <li><i class="fa-solid fa-clock w-5"></i> Thứ 2 - Thứ 6: 8:00 - 17:30</li>
            </ul>
        </div>

        <!-- Social Links -->
        <div>
            <h3 class="text-lg font-semibold mb-3 text-lime-200">Kết nối với chúng tôi</h3>
            <div class="flex space-x-3 text-2xl">
                <a href="#" class="text-white hover:text-lime-300 transition"><i class="fa-brands fa-facebook"></i></a>
                <a href="#" class="text-white hover:text-lime-300 transition"><i class="fa-brands fa-linkedin"></i></a>
                <a href="#" class="text-white hover:text-lime-300 transition"><i class="fa-brands fa-instagram"></i></a>
                <a href="#" class="text-white hover:text-lime-300 transition"><i class="fa-brands fa-github"></i></a>
            </div>
        </div>

    </div>

    <!-- Divider -->
    <div class="border-t border-emerald-600"></div>

    <!-- Bottom line -->
    <div class="text-center text-sm py-4 bg-emerald-800 text-emerald-100">
        © 2025 <span class="font-semibold text-white">RCMS Portal</span> —
        <c:out value="${pageContext.request.serverName}" /> |
        Designed with ❤️ by <span class="text-lime-300 font-medium">TuNA</span>
    </div>
</footer>
