<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>RCMS - Register</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-50">
    <div class="min-h-screen flex items-center justify-center p-6">
        <div class="w-full max-w-6xl flex flex-col lg:flex-row items-center justify-between gap-12">
            
            <!-- Left: Register form -->
            <div class="w-full max-w-md bg-white rounded-2xl shadow-lg p-8">
                <h1 class="text-4xl font-extrabold text-green-600 text-center mb-3">RCMS</h1>
                <p class="text-gray-500 text-center mb-8">Create an account to find your dream job 🚀</p>

                <!-- Hiển thị lỗi hoặc message -->
                <c:if test="${not empty error}">
                    <div id="alertBox" class="p-3 bg-red-100 border border-red-400 text-red-600 rounded-lg text-sm mb-4 transition-opacity duration-700 ease-in-out">
                        ${error}
                    </div>
                </c:if>
                <c:if test="${not empty message}">
                    <div id="alertBox" class="p-3 bg-green-100 border border-green-400 text-green-700 rounded-lg text-sm mb-4 transition-opacity duration-700 ease-in-out">
                        ${message}
                    </div>
                </c:if>

                <form method="POST" action="${pageContext.request.contextPath}/register" class="space-y-4">
                    <input type="text" name="fullname" placeholder="Full name" required
                           value="${fullname != null ? fullname : ''}"
                           class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-green-500">

                    <input type="text" name="phone" placeholder="Phone number"
                           value="${phone != null ? phone : ''}"
                           class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-green-500">

                    <input type="email" name="email" placeholder="Email" required
                           value="${email != null ? email : ''}"
                           class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-green-500">

                    <!-- Password -->
                    <div class="relative">
                        <input type="password" id="password" name="password" placeholder="Password" required
                               class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-green-500">
                        <button type="button" onclick="togglePassword('password', this)"
                                class="absolute right-3 top-1/2 -translate-y-1/2 text-gray-500 hover:text-green-600">
                            👁️
                        </button>
                    </div>

                    <!-- Confirm password -->
                    <div class="relative">
                        <input type="password" id="confirm" name="confirm" placeholder="Confirm password" required
                               class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-green-500">
                        <button type="button" onclick="togglePassword('confirm', this)"
                                class="absolute right-3 top-1/2 -translate-y-1/2 text-gray-500 hover:text-green-600">
                            👁️
                        </button>
                    </div>

                    <button type="submit"
                            class="w-full bg-green-600 text-white font-semibold py-3 rounded-lg hover:bg-green-700 transition-all">
                        Continue
                    </button>
                </form>

                <div class="mt-6 text-center">
                    <p class="text-gray-600 text-sm">
                        Already have an account?
                        <a href="${pageContext.request.contextPath}/login" class="text-green-600 font-semibold hover:underline">Login now</a>
                    </p>
                    <a href="${pageContext.request.contextPath}/home"
                       class="text-gray-500 text-xs hover:underline block mt-2">Or just take a look</a>
                </div>
            </div>

            <!-- Right: Illustration -->
            <div class="hidden lg:flex flex-col items-center justify-center space-y-6">
                <img src="https://cdn-icons-png.flaticon.com/512/4140/4140048.png"
                     alt="Register Illustration" class="w-72 drop-shadow-lg">
                <p class="text-gray-500 text-center max-w-sm">
                    Join <span class="text-green-600 font-semibold">RCMS</span> and connect your skills with the best companies.
                </p>
            </div>
        </div>
    </div>

    <script>
        function togglePassword(id, btn) {
            const input = document.getElementById(id);
            if (input.type === "password") {
                input.type = "text";
                btn.textContent = "🙈"; 
            } else {
                input.type = "password";
                btn.textContent = "👁️"; 
            }
        }

        document.addEventListener("DOMContentLoaded", () => {
            const alertBox = document.getElementById("alertBox");
            if (alertBox) {
                setTimeout(() => {
                    alertBox.style.opacity = "0";
                    alertBox.style.transform = "translateY(-10px)";
                    setTimeout(() => alertBox.remove(), 700);
                }, 3000);
            }
        });
    </script>
</body>
</html>
