<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="container mx-auto px-4 py-8">
    <div class="flex flex-col md:flex-row md:items-center md:justify-between mb-6">
        <h1 class="text-3xl font-bold text-gray-800">${pageTitle}</h1>
        <div class="flex space-x-4 mt-4 md:mt-0">
            <a href="${pageContext.request.contextPath}/manager/jobs/" 
               class="px-4 py-2 rounded-lg ${pageTitle == 'All Job Postings' ? 'bg-blue-600 text-white' : 'bg-gray-200 text-gray-700 hover:bg-gray-300'} transition-colors duration-200">
                All Jobs
            </a>
            <a href="${pageContext.request.contextPath}/manager/jobs/pending" 
               class="px-4 py-2 rounded-lg ${pageTitle == 'Pending Approval Jobs' ? 'bg-blue-600 text-white' : 'bg-gray-200 text-gray-700 hover:bg-gray-300'} transition-colors duration-200">
                Pending Approval
                <c:if test="${pageTitle == 'All Job Postings'}">
                    <c:set var="pendingCount" value="0" />
                    <c:forEach var="job" items="${jobs}">
                        <c:if test="${job.approvedAt == null}">
                            <c:set var="pendingCount" value="${pendingCount + 1}" />
                        </c:if>
                    </c:forEach>
                    <c:if test="${pendingCount > 0}">
                        <span class="ml-1 bg-red-500 text-white text-xs rounded-full px-2 py-1">${pendingCount}</span>
                    </c:if>
                </c:if>
            </a>
        </div>
    </div>

    <!-- Messages -->
    <c:if test="${not empty message}">
        <div class="bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded-lg mb-6">
            <i class="fas fa-check-circle mr-2"></i>${message}
        </div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded-lg mb-6">
            <i class="fas fa-exclamation-circle mr-2"></i>${error}
        </div>
    </c:if>

    <!-- Filter Form -->
    <div class="bg-white rounded-lg shadow-md p-6 mb-6">
        <form method="get" class="grid grid-cols-1 md:grid-cols-4 gap-4">
            <c:if test="${pageTitle == 'All Job Postings'}">
                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-2">Status</label>
                    <select name="status" class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
                        <option value="">All Status</option>
                        <option value="Pending" ${statusFilter == 'Pending' ? 'selected' : ''}>Pending</option>
                        <option value="Open" ${statusFilter == 'Open' ? 'selected' : ''}>Open</option>
                        <option value="Rejected" ${statusFilter == 'Rejected' ? 'selected' : ''}>Rejected</option>
                    </select>
                </div>
            </c:if>
            <div>
                <label class="block text-sm font-medium text-gray-700 mb-2">Category</label>
                <select name="category" class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
                    <option value="">All Categories</option>
                    <c:forEach var="category" items="${categories}">
                        <option value="${category.categoryId}" ${categoryFilter == category.categoryId.toString() ? 'selected' : ''}>
                            ${category.categoryName}
                        </option>
                    </c:forEach>
                </select>
            </div>
            <div>
                <label class="block text-sm font-medium text-gray-700 mb-2">Recruiter</label>
                <input type="text" name="recruiter" value="${recruiterFilter}" 
                       placeholder="Search recruiter..."
                       class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
            </div>
            <div class="flex items-end space-x-2">
                <button type="submit" 
                        class="w-full bg-blue-600 text-white px-4 py-2 rounded-md hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-blue-500 transition-colors duration-200">
                    <i class="fas fa-filter mr-2"></i>Filter
                </button>
                <a href="${pageContext.request.contextPath}${pageTitle == 'Pending Approval Jobs' ? '/manager/jobs/pending' : '/manager/jobs/'}"
                   class="bg-gray-500 text-white px-4 py-2 rounded-md hover:bg-gray-600 focus:outline-none focus:ring-2 focus:ring-gray-500 transition-colors duration-200">
                    <i class="fas fa-times mr-2"></i>Clear
                </a>
            </div>
        </form>
        
        <!-- Filter Results Info -->
        <c:if test="${not empty statusFilter or not empty categoryFilter or not empty recruiterFilter}">
            <div class="mt-4 p-3 bg-blue-50 rounded-lg">
                <div class="flex items-center text-sm text-blue-700">
                    <i class="fas fa-info-circle mr-2"></i>
                    <span class="font-medium">Filtered by: </span>
                    <div class="flex flex-wrap gap-2 ml-2">
                        <c:if test="${not empty statusFilter}">
                            <span class="bg-blue-100 px-3 py-1 rounded-full text-xs font-semibold">
                                Status: ${statusFilter}
                            </span>
                        </c:if>
                        <c:if test="${not empty categoryFilter}">
                            <c:forEach var="category" items="${categories}">
                                <c:if test="${category.categoryId == Integer.parseInt(categoryFilter)}">
                                    <span class="bg-blue-100 px-3 py-1 rounded-full text-xs font-semibold">
                                        Category: ${category.categoryName}
                                    </span>
                                </c:if>
                            </c:forEach>
                        </c:if>
                        <c:if test="${not empty recruiterFilter}">
                            <span class="bg-blue-100 px-3 py-1 rounded-full text-xs font-semibold">
                                Recruiter: ${recruiterFilter}
                            </span>
                        </c:if>
                    </div>
                </div>
            </div>
        </c:if>
    </div>

    <!-- Statistics Cards -->
    <div class="grid grid-cols-1 md:grid-cols-4 gap-4 mb-6">
        <div class="bg-white rounded-lg shadow-md p-4 border-l-4 border-blue-500">
            <div class="flex items-center justify-between">
                <div>
                    <p class="text-sm font-medium text-gray-600">Total Jobs</p>
                    <p class="text-2xl font-bold text-gray-900">${jobs.size()}</p>
                </div>
                <div class="bg-blue-100 p-3 rounded-full">
                    <i class="fas fa-briefcase text-blue-600 text-xl"></i>
                </div>
            </div>
        </div>
        
        <c:if test="${pageTitle == 'All Job Postings'}">
            <div class="bg-white rounded-lg shadow-md p-4 border-l-4 border-green-500">
                <div class="flex items-center justify-between">
                    <div>
                        <p class="text-sm font-medium text-gray-600">Approved</p>
                        <p class="text-2xl font-bold text-gray-900">
                            <c:set var="approvedCount" value="0" />
                            <c:forEach var="job" items="${jobs}">
                                <c:if test="${job.status == 'Open'}">
                                    <c:set var="approvedCount" value="${approvedCount + 1}" />
                                </c:if>
                            </c:forEach>
                            ${approvedCount}
                        </p>
                    </div>
                    <div class="bg-green-100 p-3 rounded-full">
                        <i class="fas fa-check-circle text-green-600 text-xl"></i>
                    </div>
                </div>
            </div>
            
            <div class="bg-white rounded-lg shadow-md p-4 border-l-4 border-yellow-500">
                <div class="flex items-center justify-between">
                    <div>
                        <p class="text-sm font-medium text-gray-600">Pending</p>
                        <p class="text-2xl font-bold text-gray-900">
                            <c:set var="pendingCount" value="0" />
                            <c:forEach var="job" items="${jobs}">
                                <c:if test="${job.status == 'Pending'}">
                                    <c:set var="pendingCount" value="${pendingCount + 1}" />
                                </c:if>
                            </c:forEach>
                            ${pendingCount}
                        </p>
                    </div>
                    <div class="bg-yellow-100 p-3 rounded-full">
                        <i class="fas fa-clock text-yellow-600 text-xl"></i>
                    </div>
                </div>
            </div>
            
            <div class="bg-white rounded-lg shadow-md p-4 border-l-4 border-red-500">
                <div class="flex items-center justify-between">
                    <div>
                        <p class="text-sm font-medium text-gray-600">Rejected</p>
                        <p class="text-2xl font-bold text-gray-900">
                            <c:set var="rejectedCount" value="0" />
                            <c:forEach var="job" items="${jobs}">
                                <c:if test="${job.status == 'Rejected'}">
                                    <c:set var="rejectedCount" value="${rejectedCount + 1}" />
                                </c:if>
                            </c:forEach>
                            ${rejectedCount}
                        </p>
                    </div>
                    <div class="bg-red-100 p-3 rounded-full">
                        <i class="fas fa-times-circle text-red-600 text-xl"></i>
                    </div>
                </div>
            </div>
        </c:if>
        
        <c:if test="${pageTitle == 'Pending Approval Jobs'}">
            <div class="bg-white rounded-lg shadow-md p-4 border-l-4 border-yellow-500">
                <div class="flex items-center justify-between">
                    <div>
                        <p class="text-sm font-medium text-gray-600">Waiting Approval</p>
                        <p class="text-2xl font-bold text-gray-900">${jobs.size()}</p>
                    </div>
                    <div class="bg-yellow-100 p-3 rounded-full">
                        <i class="fas fa-clock text-yellow-600 text-xl"></i>
                    </div>
                </div>
            </div>
            
            <div class="bg-white rounded-lg shadow-md p-4 border-l-4 border-blue-500">
                <div class="flex items-center justify-between">
                    <div>
                        <p class="text-sm font-medium text-gray-600">Categories</p>
                        <p class="text-2xl font-bold text-gray-900">
                            <c:set var="categorySet" value="${[]}" />
                            <c:forEach var="job" items="${jobs}">
                                <c:if test="${!categorySet.contains(job.categoryName)}">
                                    <c:set var="categorySet" value="${categorySet.add(job.categoryName)}" />
                                </c:if>
                            </c:forEach>
                            ${categorySet.size()}
                        </p>
                    </div>
                    <div class="bg-blue-100 p-3 rounded-full">
                        <i class="fas fa-tags text-blue-600 text-xl"></i>
                    </div>
                </div>
            </div>
            
            <div class="bg-white rounded-lg shadow-md p-4 border-l-4 border-green-500">
                <div class="flex items-center justify-between">
                    <div>
                        <p class="text-sm font-medium text-gray-600">Recruiters</p>
                        <p class="text-2xl font-bold text-gray-900">
                            <c:set var="recruiterSet" value="${[]}" />
                            <c:forEach var="job" items="${jobs}">
                                <c:if test="${not empty job.recruiterName && !recruiterSet.contains(job.recruiterName)}">
                                    <c:set var="recruiterSet" value="${recruiterSet.add(job.recruiterName)}" />
                                </c:if>
                            </c:forEach>
                            ${recruiterSet.size()}
                        </p>
                    </div>
                    <div class="bg-green-100 p-3 rounded-full">
                        <i class="fas fa-users text-green-600 text-xl"></i>
                    </div>
                </div>
            </div>
        </c:if>
    </div>

    <c:if test="${empty jobs}">
        <div class="bg-yellow-100 border border-yellow-400 text-yellow-700 px-4 py-6 rounded-lg text-center">
            <i class="fas fa-inbox text-3xl mb-3"></i>
            <h3 class="text-lg font-semibold mb-2">No Jobs Found</h3>
            <p class="text-sm">
                <c:choose>
                    <c:when test="${pageTitle == 'Pending Approval Jobs'}">
                        There are no jobs pending approval at the moment.
                    </c:when>
                    <c:otherwise>
                        No job postings match your current filters.
                    </c:otherwise>
                </c:choose>
            </p>
        </div>
    </c:if>

    <c:if test="${not empty jobs}">
        <div class="grid gap-6">
            <c:forEach var="job" items="${jobs}">
                <div class="bg-white rounded-lg shadow-md hover:shadow-lg transition-shadow duration-300 p-6">
                    <div class="flex flex-col lg:flex-row lg:items-start lg:justify-between">
                        <div class="flex-1">
                            <div class="flex items-start justify-between mb-3">
                                <h3 class="text-xl font-semibold text-gray-800 mb-2">${job.title}</h3>
                                <span class="px-3 py-1 rounded-full text-sm font-semibold 
                                    ${job.status == 'Open' ? 'bg-green-100 text-green-800' : 
                                      job.status == 'Pending' ? 'bg-yellow-100 text-yellow-800' : 
                                      'bg-red-100 text-red-800'}">
                                    ${job.status}
                                </span>
                            </div>
                            
                            <div class="flex flex-wrap gap-2 mb-3">
                                <span class="bg-blue-100 text-blue-800 px-3 py-1 rounded-full text-sm flex items-center">
                                    <i class="fas fa-tag mr-1"></i>
                                    ${job.categoryName}
                                </span>
                                <span class="bg-green-100 text-green-800 px-3 py-1 rounded-full text-sm flex items-center">
                                    <i class="fas fa-map-marker-alt mr-1"></i>
                                    ${job.locationName}
                                </span>
                                <c:if test="${job.approvedAt != null}">
                                    <span class="bg-purple-100 text-purple-800 px-3 py-1 rounded-full text-sm flex items-center">
                                        <i class="fas fa-check-circle mr-1"></i>
                                        Approved
                                    </span>
                                </c:if>
                            </div>
                            
                            <div class="grid grid-cols-1 md:grid-cols-2 gap-4 text-sm text-gray-600 mb-3">
                                <div class="flex items-center">
                                    <i class="fas fa-briefcase mr-2 text-gray-400"></i>
                                    <span>${job.experience}</span>
                                </div>
                                <div class="flex items-center">
                                    <i class="fas fa-user-tie mr-2 text-gray-400"></i>
                                    <span>${job.level}</span>
                                </div>
                                <div class="flex items-center">
                                    <i class="fas fa-graduation-cap mr-2 text-gray-400"></i>
                                    <span>${job.education}</span>
                                </div>
                                <div class="flex items-center">
                                    <i class="fas fa-clock mr-2 text-gray-400"></i>
                                    <span>${job.workType}</span>
                                </div>
                            </div>
                            
                            <c:if test="${job.minSalary != null && job.maxSalary != null}">
                                <p class="text-green-600 font-semibold text-lg mb-2">
                                    <i class="fas fa-money-bill-wave mr-2"></i>
                                    ${job.minSalary} - ${job.maxSalary} VND
                                </p>
                            </c:if>
                            
                            <div class="flex flex-wrap gap-4 text-sm text-gray-500">
                                <span class="flex items-center">
                                    <i class="fas fa-calendar-alt mr-2"></i>
                                    Posted: ${job.postedAt.toLocalDate()}
                                </span>
                                <span class="flex items-center">
                                    <i class="fas fa-clock mr-2"></i>
                                    Expires: ${job.expiredAt.toLocalDate()}
                                </span>
                                <span class="flex items-center">
                                    <i class="fas fa-user mr-2"></i>
                                    Recruiter: 
                                    <c:choose>
                                        <c:when test="${not empty job.recruiterName}">
                                            ${job.recruiterName}
                                        </c:when>
                                        <c:otherwise>
                                            Recruiter #${job.createdBy}
                                        </c:otherwise>
                                    </c:choose>
                                </span>
                                <c:if test="${job.approvedAt != null}">
                                    <span class="flex items-center text-green-600">
                                        <i class="fas fa-check-circle mr-2"></i>
                                        Approved: ${job.approvedAt.toLocalDate()}
                                    </span>
                                </c:if>
                            </div>
                        </div>
                        
                        <div class="mt-4 lg:mt-0 lg:ml-6 flex flex-col space-y-2 min-w-[200px]">
                            <a href="${pageContext.request.contextPath}/manager/jobs/preview?id=${job.jobId}" 
                               class="inline-flex items-center justify-center bg-blue-600 text-white px-4 py-2 rounded-lg hover:bg-blue-700 transition-colors duration-200 font-semibold">
                                <i class="fas fa-eye mr-2"></i>Preview
                            </a>
                            
                            <c:if test="${job.approvedAt == null}">
                                <div class="flex space-x-2">
                                    <form action="${pageContext.request.contextPath}/manager/jobs/" method="post" class="flex-1">
                                        <input type="hidden" name="action" value="approve">
                                        <input type="hidden" name="jobId" value="${job.jobId}">
                                        <button type="submit" 
                                                class="w-full inline-flex items-center justify-center bg-green-600 text-white px-3 py-2 rounded-lg hover:bg-green-700 transition-colors duration-200 text-sm font-semibold">
                                            <i class="fas fa-check mr-1"></i>Approve
                                        </button>
                                    </form>
                                    <form action="${pageContext.request.contextPath}/manager/jobs/" method="post" class="flex-1">
                                        <input type="hidden" name="action" value="reject">
                                        <input type="hidden" name="jobId" value="${job.jobId}">
                                        <button type="submit" 
                                                class="w-full inline-flex items-center justify-center bg-red-600 text-white px-3 py-2 rounded-lg hover:bg-red-700 transition-colors duration-200 text-sm font-semibold"
                                                onclick="return confirm('Are you sure you want to reject this job posting?')">
                                            <i class="fas fa-times mr-1"></i>Reject
                                        </button>
                                    </form>
                                </div>
                            </c:if>
                            
                            <c:if test="${job.approvedAt != null}">
                                <div class="text-center text-sm text-green-600 bg-green-50 rounded-lg p-2">
                                    <i class="fas fa-check-circle mr-1"></i>
                                    <div>Approved</div>
                                </div>
                            </c:if>
                            
                            <a href="${pageContext.request.contextPath}/jobs?action=view&id=${job.jobId}" 
                               target="_blank"
                               class="inline-flex items-center justify-center bg-gray-600 text-white px-4 py-2 rounded-lg hover:bg-gray-700 transition-colors duration-200 text-sm font-semibold">
                                <i class="fas fa-external-link-alt mr-2"></i>Public View
                            </a>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
        
        <!-- Results Count -->
        <div class="mt-6 text-sm text-gray-500 flex justify-between items-center">
            <span>Showing ${jobs.size()} job(s)</span>
            <c:if test="${not empty statusFilter or not empty categoryFilter or not empty recruiterFilter}">
                <a href="${pageContext.request.contextPath}${pageTitle == 'Pending Approval Jobs' ? '/manager/jobs/pending' : '/manager/jobs/'}"
                   class="text-blue-600 hover:text-blue-800 flex items-center">
                    <i class="fas fa-sync-alt mr-1"></i>Clear all filters
                </a>
            </c:if>
        </div>
    </c:if>
</div>