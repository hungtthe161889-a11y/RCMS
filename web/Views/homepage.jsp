<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- HERO Section -->
<section class="relative bg-gradient-to-r from-emerald-700 via-emerald-600 to-lime-500 text-white py-20 overflow-hidden">
    <div class="absolute inset-0 bg-[url('${pageContext.request.contextPath}/assets/img/hero-bg.jpg')] bg-cover bg-center opacity-10"></div>

    <div class="relative z-10 max-w-7xl mx-auto px-6 flex flex-col md:flex-row items-center gap-10">
        <div class="md:w-1/2">
            <h1 class="text-5xl font-extrabold leading-tight mb-4">
                Nâng tầm tuyển dụng <br>
                <span class="text-lime-200">RCMS Talent Gateway</span>
            </h1>
            <p class="text-emerald-100 text-lg mb-6">
                Nền tảng giúp nhà tuyển dụng cá nhân đăng tin, quản lý hồ sơ và kết nối ứng viên nhanh chóng — thông minh và hiệu quả.
            </p>
            <div class="flex gap-4">
                <a href="${pageContext.request.contextPath}/jobs"
                   class="bg-white text-emerald-700 px-6 py-3 font-semibold rounded-lg shadow hover:bg-emerald-100 transition">
                    Tìm ứng viên
                </a>
                <a href="${pageContext.request.contextPath}/register"
                   class="border border-white px-6 py-3 rounded-lg font-semibold hover:bg-emerald-800 transition">
                    Đăng tin tuyển dụng
                </a>
            </div>
        </div>

        <div class="md:w-1/2 flex justify-center">
            <img src="${pageContext.request.contextPath}/assets/img/team.png"
                 class="rounded-2xl w-4/5 shadow-2xl border border-white/20" alt="Recruitment illustration">
        </div>
    </div>
</section>

<!-- STATISTICS -->
<section class="bg-white py-12">
    <div class="max-w-6xl mx-auto grid grid-cols-2 md:grid-cols-4 text-center gap-6">
        <div>
            <p class="text-4xl font-bold text-emerald-700 mb-1">500+</p>
            <p class="text-gray-600 text-sm">Ứng viên đã tham gia</p>
        </div>
        <div>
            <p class="text-4xl font-bold text-emerald-700 mb-1">120+</p>
            <p class="text-gray-600 text-sm">Doanh nghiệp tin dùng</p>
        </div>
        <div>
            <p class="text-4xl font-bold text-emerald-700 mb-1">50+</p>
            <p class="text-gray-600 text-sm">Tin tuyển dụng mỗi tuần</p>
        </div>
        <div>
            <p class="text-4xl font-bold text-emerald-700 mb-1">98%</p>
            <p class="text-gray-600 text-sm">Phản hồi tích cực</p>
        </div>
    </div>
</section>

<!-- FEATURED JOBS -->
<section class="py-16 bg-gray-50">
    <div class="max-w-7xl mx-auto px-6">
        <div class="flex justify-between items-center mb-10">
            <h2 class="text-3xl font-bold text-emerald-700">Cơ hội việc làm nổi bật</h2>
            <a href="${pageContext.request.contextPath}/jobs"
               class="text-emerald-700 font-medium hover:text-emerald-900 transition">Xem tất cả →</a>
        </div>

        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
            <c:forEach var="job" items="${featuredJobs}">
                <div class="bg-white p-6 rounded-xl shadow hover:shadow-lg transition hover:-translate-y-1">
                    <div class="flex items-center justify-between mb-3">
                        <h3 class="text-xl font-semibold text-emerald-700">${job.title}</h3>
                        <span class="text-xs bg-emerald-100 text-emerald-700 px-2 py-1 rounded-full">${job.type}</span>
                    </div>
                    <p class="text-gray-500 text-sm mb-2">
                        <i class="fa-solid fa-building text-emerald-500"></i> ${job.company}
                    </p>
                    <p class="text-gray-500 text-sm mb-3">
                        <i class="fa-solid fa-location-dot text-emerald-500"></i> ${job.location}
                    </p>
                    <p class="text-gray-600 text-sm line-clamp-3 mb-4">${job.description}</p>
                    <a href="${pageContext.request.contextPath}/jobs?action=detail&id=${job.jobId}"
                       class="text-emerald-700 hover:text-emerald-900 font-medium text-sm transition">
                        Chi tiết &rarr;
                    </a>
                </div>
            </c:forEach>

            <c:if test="${empty featuredJobs}">
                <div class="col-span-3 text-center text-gray-500 py-10">
                    Hiện chưa có việc làm nổi bật.
                </div>
            </c:if>
        </div>
    </div>
</section>

<!-- WHY CHOOSE US -->
<section class="py-16 bg-white">
    <div class="max-w-6xl mx-auto px-6 text-center">
        <h2 class="text-3xl font-bold text-emerald-700 mb-12">Tại sao chọn RCMS Portal?</h2>
        <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
            <div class="p-8 border rounded-xl hover:shadow-md transition">
                <div class="text-4xl text-emerald-600 mb-4"><i class="fa-solid fa-bolt"></i></div>
                <h3 class="text-xl font-semibold mb-2 text-gray-800">Nhanh chóng & hiệu quả</h3>
                <p class="text-gray-600 text-sm">Đăng tin trong vài phút, quản lý hồ sơ và phản hồi ứng viên dễ dàng.</p>
            </div>
            <div class="p-8 border rounded-xl hover:shadow-md transition">
                <div class="text-4xl text-emerald-600 mb-4"><i class="fa-solid fa-users"></i></div>
                <h3 class="text-xl font-semibold mb-2 text-gray-800">Kết nối thông minh</h3>
                <p class="text-gray-600 text-sm">AI hỗ trợ gợi ý ứng viên phù hợp theo kỹ năng và vị trí.</p>
            </div>
            <div class="p-8 border rounded-xl hover:shadow-md transition">
                <div class="text-4xl text-emerald-600 mb-4"><i class="fa-solid fa-shield-heart"></i></div>
                <h3 class="text-xl font-semibold mb-2 text-gray-800">Uy tín & Bảo mật</h3>
                <p class="text-gray-600 text-sm">Thông tin được bảo mật tuyệt đối và xác thực minh bạch.</p>
            </div>
        </div>
    </div>
</section>

<!-- CTA -->
<section class="py-20 bg-gradient-to-r from-emerald-700 to-lime-600 text-center text-white">
    <div class="max-w-3xl mx-auto px-6">
        <h2 class="text-4xl font-bold mb-4">Bắt đầu hành trình tuyển dụng của bạn</h2>
        <p class="text-emerald-100 mb-8">Đăng ký tài khoản miễn phí, đăng tin tuyển dụng và tìm ứng viên phù hợp chỉ trong vài bước!</p>
        <a href="${pageContext.request.contextPath}/register"
           class="bg-white text-emerald-700 font-semibold px-8 py-3 rounded-lg shadow hover:bg-emerald-100 transition">
            Đăng ký ngay
        </a>
    </div>
</section>
