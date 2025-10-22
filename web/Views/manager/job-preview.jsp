<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="container mx-auto px-4 py-8">
    <div class="flex items-center justify-between mb-6">
        <a href="${pageContext.request.contextPath}/manager/jobs/" 
           class="inline-flex items-center text-blue-600 hover:text-blue-800">
            <i class="fas fa-arrow-left mr-2"></i>
            Back to Jobs
        </a>
        <div class="flex space-x-2">
            <c:if test="${job.approvedAt == null}">
                <form action="${pageContext.request.contextPath}/manager/jobs/" method="post" class="inline">
                    <input type="hidden" name="action" value="approve">
                    <input type="hidden" name="jobId" value="${job.jobId}">
                    <button type="submit" 
                            class="inline-flex items-center bg-green-600 text-white px-4 py-2 rounded-lg hover:bg-green-700 transition-colors duration-200 font-semibold">
                        <i class="fas fa-check mr-2"></i>Approve Job
                    </button>
                </form>
                <form action="${pageContext.request.contextPath}/manager/jobs/" method="post" class="inline">
                    <input type="hidden" name="action" value="reject">
                    <input type="hidden" name="jobId" value="${job.jobId}">
                    <button type="submit" 
                            class="inline-flex items-center bg-red-600 text-white px-4 py-2 rounded-lg hover:bg-red-700 transition-colors duration-200 font-semibold"
                            onclick="return confirm('Are you sure you want to reject this job posting?')">
                        <i class="fas fa-times mr-2"></i>Reject Job
                    </button>
                </form>
            </c:if>
        </div>
    </div>
    
    <div class="bg-white rounded-lg shadow-lg overflow-hidden">
        <!-- Header với thông tin quản lý -->
        <div class="bg-gradient-to-r from-blue-600 to-blue-800 px-6 py-8 text-white">
            <div class="flex flex-col md:flex-row md:items-start md:justify-between">
                <div class="flex-1">
                    <h1 class="text-3xl font-bold mb-2">${job.title}</h1>
                    <div class="flex flex-wrap gap-4 text-blue-100 mb-4">
                        <span class="flex items-center">
                            <i class="fas fa-tag mr-2"></i>
                            ${job.categoryName}
                        </span>
                        <span class="flex items-center">
                            <i class="fas fa-map-marker-alt mr-2"></i>
                            ${job.locationName}
                        </span>
                        <span class="flex items-center px-3 py-1 rounded-full text-sm font-semibold 
                            ${job.status == 'Open' ? 'bg-green-500' : 
                              job.status == 'Pending' ? 'bg-yellow-500' : 
                              'bg-red-500'}">
                            <i class="fas fa-circle mr-2"></i>
                            ${job.status}
                        </span>
                    </div>
                </div>
                <div class="mt-4 md:mt-0 bg-white/20 rounded-lg p-4">
                    <h3 class="font-semibold mb-2">Manager Information</h3>
                    <div class="text-sm">
                        <div>Job ID: <strong>${job.jobId}</strong></div>
                        <div>Created By: 
                            <strong>
                                <c:choose>
                                    <c:when test="${not empty job.recruiterName}">
                                        ${job.recruiterName}
                                        <c:if test="${not empty job.recruiterEmail}">
                                            <br><span class="text-blue-100">(${job.recruiterEmail})</span>
                                        </c:if>
                                    </c:when>
                                    <c:otherwise>
                                        Recruiter #${job.createdBy}
                                    </c:otherwise>
                                </c:choose>
                            </strong>
                        </div>
                        <c:if test="${job.approvedAt != null}">
                            <div>Approved At: <strong>${job.approvedAt.toLocalDate()}</strong></div>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>

        <!-- Content -->
        <div class="p-6">
            <!-- Thông tin cơ bản -->
            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-8">
                <div class="bg-gray-50 rounded-lg p-4">
                    <h3 class="font-semibold text-gray-700 mb-2 flex items-center">
                        <i class="fas fa-briefcase mr-2"></i>Experience
                    </h3>
                    <p class="text-gray-900">${job.experience}</p>
                </div>
                <div class="bg-gray-50 rounded-lg p-4">
                    <h3 class="font-semibold text-gray-700 mb-2 flex items-center">
                        <i class="fas fa-chart-line mr-2"></i>Level
                    </h3>
                    <p class="text-gray-900">${job.level}</p>
                </div>
                <div class="bg-gray-50 rounded-lg p-4">
                    <h3 class="font-semibold text-gray-700 mb-2 flex items-center">
                        <i class="fas fa-graduation-cap mr-2"></i>Education
                    </h3>
                    <p class="text-gray-900">${job.education}</p>
                </div>
                <div class="bg-gray-50 rounded-lg p-4">
                    <h3 class="font-semibold text-gray-700 mb-2 flex items-center">
                        <i class="fas fa-clock mr-2"></i>Work Type
                    </h3>
                    <p class="text-gray-900">${job.workType}</p>
                </div>
            </div>

            <!-- Salary -->
            <c:if test="${job.minSalary != null && job.maxSalary != null}">
                <div class="bg-green-50 border border-green-200 rounded-lg p-4 mb-6">
                    <h3 class="font-semibold text-green-800 mb-2 flex items-center">
                        <i class="fas fa-money-bill-wave mr-2"></i>Salary Range
                    </h3>
                    <p class="text-2xl font-bold text-green-700">${job.minSalary} - ${job.maxSalary} VND</p>
                </div>
            </c:if>

            <!-- Thông tin quản lý -->
            <div class="bg-blue-50 border border-blue-200 rounded-lg p-4 mb-6">
                <h3 class="font-semibold text-blue-800 mb-3 flex items-center">
                    <i class="fas fa-info-circle mr-2"></i>Management Information
                </h3>
                <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4 text-sm">
                    <div>
                        <span class="font-medium">Quantity:</span> ${job.quantity}
                    </div>
                    <div>
                        <span class="font-medium">Posted:</span> ${job.postedAt.toLocalDate()}
                    </div>
                    <div>
                        <span class="font-medium">Expires:</span> ${job.expiredAt.toLocalDate()}
                    </div>
                    <div>
                        <span class="font-medium">Status:</span> 
                        <span class="px-2 py-1 rounded-full text-xs font-semibold 
                            ${job.status == 'Open' ? 'bg-green-100 text-green-800' : 
                              job.status == 'Pending' ? 'bg-yellow-100 text-yellow-800' : 
                              'bg-red-100 text-red-800'}">
                            ${job.status}
                        </span>
                    </div>
                    <div>
                        <span class="font-medium">Approval:</span> 
                        <c:choose>
                            <c:when test="${job.approvedAt != null}">
                                <span class="text-green-600 font-semibold">Approved</span>
                            </c:when>
                            <c:otherwise>
                                <span class="text-yellow-600 font-semibold">Pending</span>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <div>
                        <span class="font-medium">Recruiter:</span> 
                        <c:choose>
                            <c:when test="${not empty job.recruiterName}">
                                ${job.recruiterName}
                            </c:when>
                            <c:otherwise>
                                Recruiter #${job.createdBy}
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <div>
                        <span class="font-medium">Category:</span> ${job.categoryName}
                    </div>
                    <div>
                        <span class="font-medium">Location:</span> ${job.locationName}
                    </div>
                </div>
            </div>

            <!-- Job Details -->
            <div class="space-y-6">
                <div>
                    <h2 class="text-xl font-semibold text-gray-800 mb-3 flex items-center">
                        <i class="fas fa-file-alt mr-2"></i>Job Description
                    </h2>
                    <div class="prose max-w-none bg-gray-50 rounded-lg p-4">
                        <p class="text-gray-700 whitespace-pre-line">${job.description}</p>
                    </div>
                </div>

                <div>
                    <h2 class="text-xl font-semibold text-gray-800 mb-3 flex items-center">
                        <i class="fas fa-list-check mr-2"></i>Requirements
                    </h2>
                    <div class="prose max-w-none bg-gray-50 rounded-lg p-4">
                        <p class="text-gray-700 whitespace-pre-line">${job.requirement}</p>
                    </div>
                </div>

                <c:if test="${not empty job.interest}">
                    <div>
                        <h2 class="text-xl font-semibold text-gray-800 mb-3 flex items-center">
                            <i class="fas fa-gift mr-2"></i>Benefits
                        </h2>
                        <div class="prose max-w-none bg-gray-50 rounded-lg p-4">
                            <p class="text-gray-700 whitespace-pre-line">${job.interest}</p>
                        </div>
                    </div>
                </c:if>

                <c:if test="${not empty job.income}">
                    <div>
                        <h2 class="text-xl font-semibold text-gray-800 mb-3 flex items-center">
                            <i class="fas fa-chart-line mr-2"></i>Income Information
                        </h2>
                        <div class="prose max-w-none bg-gray-50 rounded-lg p-4">
                            <p class="text-gray-700">${job.income}</p>
                        </div>
                    </div>
                </c:if>
            </div>

            <!-- Action Buttons -->
            <div class="mt-8 pt-6 border-t border-gray-200 flex flex-col sm:flex-row justify-between items-center">
                <div class="text-sm text-gray-500">
                    <p><strong>Job ID:</strong> ${job.jobId} | <strong>Created:</strong> ${job.postedAt.toLocalDate()}</p>
                    <p><strong>Status:</strong> ${job.status} | 
                       <strong>Approval:</strong> 
                       <c:choose>
                           <c:when test="${job.approvedAt != null}">Approved at ${job.approvedAt.toLocalDate()}</c:when>
                           <c:otherwise>Pending</c:otherwise>
                       </c:choose>
                    </p>
                </div>
                <div class="mt-4 sm:mt-0 flex space-x-2">
                    <c:if test="${job.approvedAt == null}">
                        <form action="${pageContext.request.contextPath}/manager/jobs/" method="post">
                            <input type="hidden" name="action" value="approve">
                            <input type="hidden" name="jobId" value="${job.jobId}">
                            <button type="submit" 
                                    class="inline-flex items-center bg-green-600 text-white px-6 py-3 rounded-lg hover:bg-green-700 transition-colors duration-200 font-semibold">
                                <i class="fas fa-check mr-2"></i>Approve
                            </button>
                        </form>
                        <form action="${pageContext.request.contextPath}/manager/jobs/" method="post">
                            <input type="hidden" name="action" value="reject">
                            <input type="hidden" name="jobId" value="${job.jobId}">
                            <button type="submit" 
                                    class="inline-flex items-center bg-red-600 text-white px-6 py-3 rounded-lg hover:bg-red-700 transition-colors duration-200 font-semibold"
                                    onclick="return confirm('Are you sure you want to reject this job posting?')">
                                <i class="fas fa-times mr-2"></i>Reject
                            </button>
                        </form>
                    </c:if>
                    <a href="${pageContext.request.contextPath}/jobs?action=view&id=${job.jobId}" 
                       target="_blank"
                       class="inline-flex items-center bg-blue-600 text-white px-6 py-3 rounded-lg hover:bg-blue-700 transition-colors duration-200 font-semibold">
                        <i class="fas fa-external-link-alt mr-2"></i>Public View
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>