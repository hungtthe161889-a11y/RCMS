<%@page contentType="text/html;charset=UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>${job.title} - Tuyển dụng</title>
        <script src="https://cdn.tailwindcss.com"></script>
    </head>
    <body class="bg-gray-50 text-gray-800">

        <!-- HEADER -->
        <header class="bg-white shadow">
            <div class="max-w-7xl mx-auto px-6 py-4 flex justify-between items-center">
                <a href="home" class="text-2xl font-bold text-indigo-600 flex items-center gap-2">
                    <i class="fa-solid fa-briefcase"></i> Recruitment
                </a>
                <nav>
                    <a href="home" class="text-gray-600 hover:text-indigo-600 font-medium">Trang chủ</a>
                </nav>
            </div>
        </header>

        <!-- JOB HEADER -->
        <section class="bg-gradient-to-r from-indigo-500 to-purple-600 text-white py-10">
            <div class="max-w-6xl mx-auto px-6">
                <h1 class="text-4xl font-bold mb-3">${job.title}</h1>
                <div class="flex flex-wrap gap-3 text-sm">
                    <span class="bg-yellow-400 text-black px-4 py-1 rounded-full font-semibold">
                        <c:choose>
                            <c:when test="${job.minSalary != null && job.maxSalary != null}">
                                <fmt:formatNumber value="${job.minSalary}" type="number"/> - <fmt:formatNumber value="${job.maxSalary}" type="number"/> VND
                            </c:when>
                            <c:otherwise>Thương lượng</c:otherwise>
                        </c:choose>
                    </span>
                    <span class="bg-white/20 px-4 py-1 rounded-full">${job.locationName}</span>
                    <span class="bg-white/20 px-4 py-1 rounded-full">${job.categoryName}</span>
                </div>
            </div>
        </section>

        <!-- JOB CONTENT -->
        <main class="max-w-6xl mx-auto px-6 py-10 grid grid-cols-1 lg:grid-cols-3 gap-8">

            <!-- LEFT COLUMN -->
            <div class="lg:col-span-2 space-y-8">
                <section class="bg-white shadow rounded-xl p-6">
                    <h2 class="text-xl font-semibold border-l-4 border-indigo-600 pl-3 mb-4">Mô tả công việc</h2>
                    <p>${job.description}</p>
                </section>

                <c:if test="${not empty job.requirement}">
                    <section class="bg-white shadow rounded-xl p-6">
                        <h2 class="text-xl font-semibold border-l-4 border-indigo-600 pl-3 mb-4">Yêu cầu</h2>
                        <p>${job.requirement}</p>
                    </section>
                </c:if>

                <c:if test="${not empty job.income}">
                    <section class="bg-white shadow rounded-xl p-6">
                        <h2 class="text-xl font-semibold border-l-4 border-indigo-600 pl-3 mb-4">Quyền lợi</h2>
                        <p>${job.income}</p>
                    </section>
                </c:if>
            </div>

            <!-- RIGHT COLUMN -->
            <div class="space-y-6">
                <div class="bg-white shadow rounded-xl p-6">
                    <h3 class="font-semibold text-lg mb-3">Thông tin tuyển dụng</h3>
                    <p><strong>Hạn nộp:</strong>
                        <fmt:parseDate value="${job.expiredAt}" pattern="yyyy-MM-dd'T'HH:mm:ss" var="exp"/>
                        <fmt:formatDate value="${exp}" pattern="dd/MM/yyyy"/>
                    </p>
                    <p><strong>Hình thức:</strong> ${job.workType}</p>
                    <p><strong>Số lượng:</strong> ${job.quantity}</p>
                </div>

                <c:if test="${sessionScope.uid != null}">
                    <button type="button"
                            onclick="openModal()"
                            class="w-full bg-green-500 hover:bg-green-600 text-white py-3 rounded-xl font-semibold shadow">
                        <i class="fa-solid fa-paper-plane me-2"></i>Ứng tuyển ngay
                    </button>
                </c:if>



                <c:if test="${sessionScope.uid == null}">
                    <a href="login" class="block w-full bg-indigo-500 hover:bg-indigo-600 text-white py-3 text-center rounded-xl font-semibold shadow">
                        Đăng nhập để ứng tuyển
                    </a>
                </c:if>
            </div>
        </main>

        <!-- APPLY MODAL -->
        <div id="applyModal" class="hidden fixed inset-0 bg-black/50 flex items-center justify-center z-50">
            <div class="bg-white w-full max-w-lg rounded-2xl shadow-xl p-6 relative">
                <h2 class="text-xl font-bold mb-4 text-indigo-600">Ứng tuyển công việc</h2>

                <form action="apply" method="post" enctype="multipart/form-data" class="space-y-4">
                    <input type="hidden" name="jobId" value="${job.jobId}" />

                    <c:choose>
                        <c:when test="${empty resumes}">
                            <p class="text-gray-600">Bạn chưa có CV. Hãy tạo CV mới để ứng tuyển.</p>

                            <input type="text" name="resumeTitle" placeholder="Tên CV" class="w-full border rounded-lg px-3 py-2" required>
                            <input type="file" name="newResumeFile" accept=".pdf,.doc,.docx" class="w-full border rounded-lg px-3 py-2" required>

                            <textarea name="summary" placeholder="Tóm tắt bản thân" class="w-full border rounded-lg px-3 py-2"></textarea>
                            <textarea name="experience" placeholder="Kinh nghiệm làm việc" class="w-full border rounded-lg px-3 py-2"></textarea>
                            <textarea name="education" placeholder="Học vấn" class="w-full border rounded-lg px-3 py-2"></textarea>
                            <textarea name="skills" placeholder="Kỹ năng" class="w-full border rounded-lg px-3 py-2"></textarea>

                        </c:when>

                        <c:otherwise>
                            <p class="text-gray-600">Chọn CV bạn muốn dùng:</p>
                            <select name="resumeId" class="w-full border rounded-lg px-3 py-2">
                                <c:forEach var="cv" items="${resumes}">
                                    <option value="${cv.resumeId}">${cv.title}</option>
                                </c:forEach>
                            </select>

                            <div class="border-t border-gray-200 pt-3">
                                <p class="text-sm text-gray-500 mb-2">Hoặc tải lên CV mới:</p>
                                <input type="text" name="resumeTitle" placeholder="Tên CV (tuỳ chọn)" class="w-full border rounded-lg px-3 py-2 mb-2">
                                <input type="file" name="newResumeFile" accept=".pdf,.doc,.docx" class="w-full border rounded-lg px-3 py-2">
                            </div>
                        </c:otherwise>
                    </c:choose>

                    <div class="flex justify-end gap-3 pt-4">
                        <button type="button" onclick="closeModal()" class="px-4 py-2 bg-gray-200 rounded-lg hover:bg-gray-300">Hủy</button>
                        <button type="submit" class="px-4 py-2 bg-green-500 text-white rounded-lg hover:bg-green-600">Nộp đơn</button>
                    </div>
                </form>

                <button onclick="closeModal()" class="absolute top-3 right-3 text-gray-400 hover:text-gray-600">✕</button>
            </div>
        </div>


        <script>
            function openModal() {
                document.getElementById('applyModal').classList.remove('hidden');
            }
            function closeModal() {
                document.getElementById('applyModal').classList.add('hidden');
            }
        </script>

    </body>
</html>
