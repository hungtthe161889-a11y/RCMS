<%-- 
    Document   : login
    Created on : Oct 10, 2025, 11:45:42 PM
    Author     : Hung
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>RCMS - Login</title>
        <script src="https://cdn.tailwindcss.com"></script>
    </head>
    <body class="">
        <div class="min-h-screen flex items-center justify-center p-4">
            <div class="w-full max-w-6xl flex items-center justify-between gap-12">
                <!-- Left side - Login form -->
                <div class="w-full max-w-md">
                    <h1 class="text-4xl font-bold text-green-600 mb-12 text-center">RCMS</h1>

                    <h2 class="text-3xl font-bold text-green-600 mb-4 text-center">
                        "Choose your best jobs"
                    </h2>

                    <p class="text-gray-600 mb-8 text-center">Register for the recruitment app RCMS</p>

                    <div class="bg-white rounded-2xl shadow-lg p-8">
                        <button class="w-full flex items-center justify-center gap-3 bg-white border-2 border-gray-200 rounded-lg py-3 px-4 mb-4 hover:bg-gray-50 transition-colors">
                            <svg class="w-5 h-5" viewBox="0 0 24 24">
                            <path fill="#4285F4" d="M22.56 12.25c0-.78-.07-1.53-.2-2.25H12v4.26h5.92c-.26 1.37-1.04 2.53-2.21 3.31v2.77h3.57c2.08-1.92 3.28-4.74 3.28-8.09z"/>
                            <path fill="#34A853" d="M12 23c2.97 0 5.46-.98 7.28-2.66l-3.57-2.77c-.98.66-2.23 1.06-3.71 1.06-2.86 0-5.29-1.93-6.16-4.53H2.18v2.84C3.99 20.53 7.7 23 12 23z"/>
                            <path fill="#FBBC05" d="M5.84 14.09c-.22-.66-.35-1.36-.35-2.09s.13-1.43.35-2.09V7.07H2.18C1.43 8.55 1 10.22 1 12s.43 3.45 1.18 4.93l2.85-2.22.81-.62z"/>
                            <path fill="#EA4335" d="M12 5.38c1.62 0 3.06.56 4.21 1.64l3.15-3.15C17.45 2.09 14.97 1 12 1 7.7 1 3.99 3.47 2.18 7.07l3.66 2.84c.87-2.6 3.3-4.53 6.16-4.53z"/>
                            </svg>
                            <span class="text-gray-700 font-medium">Continue with Google</span>
                        </button>

                        <div class="flex items-center gap-3 my-6">
                            <div class="flex-1 h-px bg-gray-300"></div>
                            <span class="text-gray-500 text-sm">or</span>
                            <div class="flex-1 h-px bg-gray-300"></div>
                        </div>

                        <form method="POST" action="${pageContext.request.contextPath}/login">
                            <div class="mb-4">
                                <input
                                    type="text"
                                    placeholder="Full name"
                                    class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-green-500 focus:border-transparent"
                                    />
                            </div>
                            
                            <div class="mb-4">
                                <input
                                    type="text"
                                    placeholder="Phone number"
                                    class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-green-500 focus:border-transparent"
                                    />
                            </div>
                            
                            <div class="mb-4">
                                <input
                                    type="email"
                                    placeholder="Email"
                                    class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-green-500 focus:border-transparent"
                                    />
                            </div>

                            <div class="mb-6">
                                <input
                                    type="password"
                                    placeholder="Password"
                                    class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-green-500 focus:border-transparent"
                                    />
                            </div>

                            <div class="mb-6">
                                <input
                                    type="password"
                                    placeholder="Confirm password"
                                    class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-green-500 focus:border-transparent"
                                    />
                            </div>

                            <button
                                type="submit"
                                class="w-full bg-green-600 text-white font-medium py-3 rounded-lg hover:bg-green-700 transition-colors mb-6"
                                >
                                Continue
                            </button>

                            <div class="text-center">
                                <p class="text-gray-600 text-sm mb-2">
                                    Don't have an account? 
                                    <a href="#" class="text-gray-900 underline hover:text-green-600">Create your account</a>
                                </p>
                                <a href="${pageContext.request.contextPath}/home" class="text-gray-900 underline hover:text-green-600 text-sm">Or just take a look</a>
                            </div>
                        </form>
                    </div>

                    <div class="mt-12">
                        <p class="text-center drop-shadow font-bold text-green-600">@RCMS</p>
                    </div>
                </div>

                <!-- Right side - Illustration -->
                <div class="hidden lg:block w-full max-w-xl">
                    <div class="relative">
                        <!-- Decorative elements -->
                        <div class="absolute top-0 right-20 w-4 h-4 bg-yellow-400 rounded-full"></div>
                        <div class="absolute top-10 right-0 w-20 h-20 bg-blue-100 rounded-full opacity-50"></div>
                        <div class="absolute bottom-20 left-0 w-16 h-16 bg-pink-100 rounded-full opacity-50"></div>

                        <!-- Paper airplane -->
                        <svg class="absolute top-0 right-40 w-16 h-16 text-blue-500" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <path d="M3 3l18 9-18 9 3-9-3-9z"/>
                        </svg>

                        <!-- Main illustration container -->
                        <div class="bg-white rounded-3xl shadow-2xl p-8 border-4 border-blue-300">
                            <!-- Browser dots -->
                            <div class="flex gap-2 mb-6">
                                <div class="w-3 h-3 bg-red-400 rounded-full"></div>
                                <div class="w-3 h-3 bg-yellow-400 rounded-full"></div>
                                <div class="w-3 h-3 bg-green-400 rounded-full"></div>
                            </div>

                            <!-- Profile cards grid -->
                            <div class="grid grid-cols-2 gap-4 mb-6">
                                <!-- Profile card 1 -->
                                <div class="bg-orange-100 rounded-xl p-4">
                                    <div class="w-12 h-12 bg-orange-300 rounded-full mb-2"></div>
                                    <div class="h-2 bg-orange-300 rounded w-3/4 mb-1"></div>
                                    <div class="h-2 bg-orange-300 rounded w-1/2"></div>
                                </div>

                                <!-- Profile card 2 (highlighted) -->
                                <div class="bg-blue-200 rounded-xl p-4 ring-4 ring-blue-500">
                                    <div class="w-12 h-12 bg-blue-400 rounded-full mb-2"></div>
                                    <div class="h-2 bg-blue-400 rounded w-3/4 mb-1"></div>
                                    <div class="h-2 bg-blue-400 rounded w-1/2"></div>
                                </div>

                                <!-- Profile card 3 -->
                                <div class="bg-blue-100 rounded-xl p-4">
                                    <div class="w-12 h-12 bg-blue-300 rounded-full mb-2"></div>
                                    <div class="h-2 bg-blue-300 rounded w-3/4 mb-1"></div>
                                    <div class="h-2 bg-blue-300 rounded w-1/2"></div>
                                </div>

                                <!-- Profile card 4 -->
                                <div class="bg-pink-100 rounded-xl p-4">
                                    <div class="w-12 h-12 bg-pink-300 rounded-full mb-2"></div>
                                    <div class="h-2 bg-pink-300 rounded w-3/4 mb-1"></div>
                                    <div class="h-2 bg-pink-300 rounded w-1/2"></div>
                                </div>
                            </div>

                            <!-- Additional info lines -->
                            <div class="space-y-2">
                                <div class="h-2 bg-gray-200 rounded w-full"></div>
                                <div class="h-2 bg-gray-200 rounded w-5/6"></div>
                                <div class="h-2 bg-gray-200 rounded w-4/6"></div>
                            </div>
                        </div>

                        <!-- Character illustrations (simplified) -->
                        <div class="absolute -bottom-4 -left-8 w-24 h-32 bg-blue-500 rounded-t-full"></div>
                        <div class="absolute -bottom-4 -right-8 w-24 h-32 bg-pink-500 rounded-t-full"></div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>