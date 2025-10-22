<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="container mx-auto px-4 py-8">
    <div class="flex flex-col md:flex-row md:items-center md:justify-between mb-6">
        <h1 class="text-3xl font-bold text-gray-800">My Job Postings</h1>
          <a href="${pageContext.request.contextPath}/recruiter/jobs/create" 
           class="inline-flex items-center bg-blue-600 text-white px-6 py-3 rounded-lg hover:bg-blue-700 transition-colors duration-200 font-semibold mt-4 md:mt-0">
            <i class="fas fa-plus mr-2"></i>
            Create New Job
        </a>
    </div>

    <!-- Messages -->
    <c:if test="${not empty message}">
        <div class="bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded-lg mb-6">
            ${message}
        </div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded-lg mb-6">
            ${error}
        </div>
    </c:if>

    <c:if test="${empty jobs}">
        <div class="bg-yellow-100 border border-yellow-400 text-yellow-700 px-4 py-3 rounded-lg">
            You haven't posted any jobs yet.
        </div>
    </c:if>

    <div class="grid gap-6">
        <c:forEach var="job" items="${jobs}">
            <div class="bg-white rounded-lg shadow-md hover:shadow-lg transition-shadow duration-300 p-6">
                <div class="flex flex-col lg:flex-row lg:items-center lg:justify-between">
                    <div class="flex-1">
                        <h3 class="text-xl font-semibold text-gray-800 mb-2">${job.title}</h3>
                        <div class="flex flex-wrap gap-2 mb-3">
                            <span class="bg-blue-100 text-blue-800 px-3 py-1 rounded-full text-sm">
                                ${job.categoryName}
                            </span>
                            <span class="bg-green-100 text-green-800 px-3 py-1 rounded-full text-sm">
                                ${job.locationName}
                            </span>
                            <span class="px-3 py-1 rounded-full text-sm font-semibold 
                                ${job.status == 'Open' ? 'bg-green-100 text-green-800' : 
                                  job.status == 'Pending' ? 'bg-yellow-100 text-yellow-800' : 
                                  'bg-red-100 text-red-800'}">
                                ${job.status}
                            </span>
                        </div>
                        <div class="text-sm text-gray-600">
                            <span class="mr-4">Posted: ${job.postedAt.toLocalDate()}</span>
                            <span>Expires: ${job.expiredAt.toLocalDate()}</span>
                            <c:if test="${job.approvedAt != null}">
                                <span class="ml-4">Approved: ${job.approvedAt.toLocalDate()}</span>
                            </c:if>
                        </div>
                    </div>
                    <div class="mt-4 lg:mt-0 flex space-x-2">
                          <a href="${pageContext.request.contextPath}/recruiter/jobs/edit?id=${job.jobId}" 
                           class="inline-flex items-center bg-blue-600 text-white px-4 py-2 rounded-lg hover:bg-blue-700 transition-colors duration-200">
                            <i class="fas fa-edit mr-2"></i>
                            Edit
                        </a>
                        <form action="jobs/" method="post" class="inline" onsubmit="return confirm('Are you sure you want to delete this job posting?')">
                            <input type="hidden" name="action" value="delete">
                            <input type="hidden" name="jobId" value="${job.jobId}">
                            <button type="submit" 
                                    class="inline-flex items-center bg-red-600 text-white px-4 py-2 rounded-lg hover:bg-red-700 transition-colors duration-200">
                                <svg class="w-4 h-4 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"/>
                                </svg>
                                Delete
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>