<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="container mx-auto px-4 py-8">
    <a href="jobs" class="inline-flex items-center text-blue-600 hover:text-blue-800 mb-6">
        <svg class="w-4 h-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 19l-7-7m0 0l7-7m-7 7h18"/>
        </svg>
        Back to Jobs
    </a>
    
    <div class="bg-white rounded-lg shadow-lg overflow-hidden">
        <!-- Header -->
        <div class="bg-gradient-to-r from-blue-600 to-blue-800 px-6 py-8 text-white">
            <div class="flex flex-col md:flex-row md:items-center md:justify-between">
                <div>
                    <h1 class="text-3xl font-bold mb-2">${job.title}</h1>
                    <div class="flex flex-wrap gap-4 text-blue-100">
                        <span class="flex items-center">
                            <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 21l-7-5-7 5V5a2 2 0 012-2h10a2 2 0 012 2v16z"/>
                            </svg>
                            ${job.categoryName}
                        </span>
                        <span class="flex items-center">
                            <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17.657 16.657L13.414 20.9a1.998 1.998 0 01-2.827 0l-4.244-4.243a8 8 0 1111.314 0z"/>
                            </svg>
                            ${job.locationName}
                        </span>
                    </div>
                </div>
                <div class="mt-4 md:mt-0">
                    <c:choose>
                        <c:when test="${hasApplied}">
                            <span class="inline-flex items-center bg-green-100 text-green-800 px-4 py-2 rounded-full text-sm font-semibold">
                                <svg class="w-4 h-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"/>
                                </svg>
                                Already Applied
                            </span>
                        </c:when>
                        <c:otherwise>
                            <a href="apply?jobId=${job.jobId}" 
                               class="inline-flex items-center bg-green-600 text-white px-6 py-3 rounded-lg hover:bg-green-700 transition-colors duration-200 font-semibold">
                                <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6v6m0 0v6m0-6h6m-6 0H6"/>
                                </svg>
                                Apply Now
                            </a>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>

        <!-- Rest of the content same as public/job-detail.jsp -->
        <div class="p-6">
            <!-- Basic Info Grid -->
            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-8">
                <div class="bg-gray-50 rounded-lg p-4">
                    <h3 class="font-semibold text-gray-700 mb-2">Experience</h3>
                    <p class="text-gray-900">${job.experience}</p>
                </div>
                <div class="bg-gray-50 rounded-lg p-4">
                    <h3 class="font-semibold text-gray-700 mb-2">Level</h3>
                    <p class="text-gray-900">${job.level}</p>
                </div>
                <div class="bg-gray-50 rounded-lg p-4">
                    <h3 class="font-semibold text-gray-700 mb-2">Education</h3>
                    <p class="text-gray-900">${job.education}</p>
                </div>
                <div class="bg-gray-50 rounded-lg p-4">
                    <h3 class="font-semibold text-gray-700 mb-2">Work Type</h3>
                    <p class="text-gray-900">${job.workType}</p>
                </div>
            </div>

            <!-- Salary -->
            <c:if test="${job.minSalary != null && job.maxSalary != null}">
                <div class="bg-green-50 border border-green-200 rounded-lg p-4 mb-6">
                    <h3 class="font-semibold text-green-800 mb-2">Salary Range</h3>
                    <p class="text-2xl font-bold text-green-700">${job.minSalary} - ${job.maxSalary} VND</p>
                </div>
            </c:if>

            <!-- Job Details -->
            <div class="space-y-6">
                <div>
                    <h2 class="text-xl font-semibold text-gray-800 mb-3">Job Description</h2>
                    <div class="prose max-w-none">
                        <p class="text-gray-700 whitespace-pre-line">${job.description}</p>
                    </div>
                </div>

                <div>
                    <h2 class="text-xl font-semibold text-gray-800 mb-3">Requirements</h2>
                    <div class="prose max-w-none">
                        <p class="text-gray-700 whitespace-pre-line">${job.requirement}</p>
                    </div>
                </div>

                <c:if test="${not empty job.interest}">
                    <div>
                        <h2 class="text-xl font-semibold text-gray-800 mb-3">Benefits</h2>
                        <div class="prose max-w-none">
                            <p class="text-gray-700 whitespace-pre-line">${job.interest}</p>
                        </div>
                    </div>
                </c:if>
            </div>
        </div>
    </div>
</div>