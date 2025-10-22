<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="container mx-auto px-4 py-8">
    <div class="flex flex-col md:flex-row md:items-center md:justify-between mb-6">
        <h1 class="text-3xl font-bold text-gray-800">
            <c:choose>
                <c:when test="${not empty job}">
                    Candidates for: ${job.title}
                </c:when>
                <c:otherwise>
                    Candidate Management
                </c:otherwise>
            </c:choose>
        </h1>
        <div class="flex space-x-2 mt-4 md:mt-0">
            <a href="${pageContext.request.contextPath}/recruiter/jobs/" 
               class="bg-blue-600 text-white px-4 py-2 rounded-lg hover:bg-blue-700 transition-colors duration-200">
                <i class="fas fa-briefcase mr-2"></i>View Jobs
            </a>
        </div>
    </div>

    <!-- Statistics Cards -->
    <div class="grid grid-cols-1 md:grid-cols-4 gap-4 mb-6">
        <div class="bg-white rounded-lg shadow-md p-4 border-l-4 border-blue-500">
            <div class="flex items-center justify-between">
                <div>
                    <p class="text-sm font-medium text-gray-600">Total Candidates</p>
                    <p class="text-2xl font-bold text-gray-900">${totalCandidates}</p>
                </div>
                <div class="bg-blue-100 p-3 rounded-full">
                    <i class="fas fa-users text-blue-600 text-xl"></i>
                </div>
            </div>
        </div>
        
        <div class="bg-white rounded-lg shadow-md p-4 border-l-4 border-green-500">
            <div class="flex items-center justify-between">
                <div>
                    <p class="text-sm font-medium text-gray-600">New Applications</p>
                    <p class="text-2xl font-bold text-gray-900">${newApplications}</p>
                </div>
                <div class="bg-green-100 p-3 rounded-full">
                    <i class="fas fa-file-alt text-green-600 text-xl"></i>
                </div>
            </div>
        </div>
        
        <div class="bg-white rounded-lg shadow-md p-4 border-l-4 border-yellow-500">
            <div class="flex items-center justify-between">
                <div>
                    <p class="text-sm font-medium text-gray-600">Interviewed</p>
                    <p class="text-2xl font-bold text-gray-900">${interviewed}</p>
                </div>
                <div class="bg-yellow-100 p-3 rounded-full">
                    <i class="fas fa-calendar-check text-yellow-600 text-xl"></i>
                </div>
            </div>
        </div>
        
        <div class="bg-white rounded-lg shadow-md p-4 border-l-4 border-purple-500">
            <div class="flex items-center justify-between">
                <div>
                    <p class="text-sm font-medium text-gray-600">Offered</p>
                    <p class="text-2xl font-bold text-gray-900">${offered}</p>
                </div>
                <div class="bg-purple-100 p-3 rounded-full">
                    <i class="fas fa-handshake text-purple-600 text-xl"></i>
                </div>
            </div>
        </div>
    </div>

    <!-- Filter Form -->
    <div class="bg-white rounded-lg shadow-md p-6 mb-6">
        <form method="get" class="grid grid-cols-1 md:grid-cols-4 gap-4">
            <div>
                <label class="block text-sm font-medium text-gray-700 mb-2">Search</label>
                <input type="text" name="keyword" 
                       class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500" 
                       placeholder="Name, email, skills..." 
                       value="${searchKeyword}">
            </div>
            
            <div>
                <label class="block text-sm font-medium text-gray-700 mb-2">Status</label>
                <select name="status" class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
                    <option value="">All Status</option>
                    <option value="Applied" ${statusFilter == 'Applied' ? 'selected' : ''}>Applied</option>
                    <option value="Screening" ${statusFilter == 'Screening' ? 'selected' : ''}>Screening</option>
                    <option value="Interview" ${statusFilter == 'Interview' ? 'selected' : ''}>Interview</option>
                    <option value="Offer" ${statusFilter == 'Offer' ? 'selected' : ''}>Offer</option>
                    <option value="Hired" ${statusFilter == 'Hired' ? 'selected' : ''}>Hired</option>
                    <option value="Rejected" ${statusFilter == 'Rejected' ? 'selected' : ''}>Rejected</option>
                </select>
            </div>
            
            <div>
                <label class="block text-sm font-medium text-gray-700 mb-2">Job</label>
                <select name="jobId" class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
                    <option value="">All Jobs</option>
                    <c:forEach var="jobItem" items="${jobs}">
                        <option value="${jobItem.jobId}" ${jobFilter == jobItem.jobId ? 'selected' : ''}>
                            ${jobItem.title}
                        </option>
                    </c:forEach>
                </select>
            </div>
            
            <div class="flex items-end space-x-2">
                <button type="submit" 
                        class="w-full bg-blue-600 text-white px-4 py-2 rounded-md hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-blue-500 transition-colors duration-200">
                    <i class="fas fa-filter mr-2"></i>Filter
                </button>
                <a href="${pageContext.request.contextPath}/recruiter/candidates/" 
                   class="bg-gray-500 text-white px-4 py-2 rounded-md hover:bg-gray-600 focus:outline-none focus:ring-2 focus:ring-gray-500 transition-colors duration-200">
                    <i class="fas fa-times mr-2"></i>Clear
                </a>
            </div>
        </form>
        
        <!-- Active Filters Display -->
        <c:if test="${not empty searchKeyword or not empty statusFilter or not empty jobFilter}">
            <div class="mt-4 p-3 bg-blue-50 rounded-lg">
                <div class="flex items-center text-sm text-blue-700">
                    <i class="fas fa-filter mr-2"></i>
                    <span class="font-medium">Active filters: </span>
                    <div class="flex flex-wrap gap-2 ml-2">
                        <c:if test="${not empty searchKeyword}">
                            <span class="bg-blue-100 px-3 py-1 rounded-full text-xs font-semibold">
                                Search: "${searchKeyword}"
                            </span>
                        </c:if>
                        <c:if test="${not empty statusFilter}">
                            <span class="bg-blue-100 px-3 py-1 rounded-full text-xs font-semibold">
                                Status: ${statusFilter}
                            </span>
                        </c:if>
                        <c:if test="${not empty jobFilter}">
                            <c:forEach var="jobItem" items="${jobs}">
                                <c:if test="${jobItem.jobId == jobFilter}">
                                    <span class="bg-blue-100 px-3 py-1 rounded-full text-xs font-semibold">
                                        Job: ${jobItem.title}
                                    </span>
                                </c:if>
                            </c:forEach>
                        </c:if>
                    </div>
                </div>
            </div>
        </c:if>
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

    <c:if test="${empty candidates}">
        <div class="bg-yellow-100 border border-yellow-400 text-yellow-700 px-4 py-6 rounded-lg text-center">
            <i class="fas fa-users text-3xl mb-3"></i>
            <h3 class="text-lg font-semibold mb-2">No Candidates Found</h3>
            <p class="text-sm mb-4">
                <c:choose>
                    <c:when test="${not empty searchKeyword or not empty statusFilter or not empty jobFilter}">
                        No candidates match your current filters. Try adjusting your search criteria.
                    </c:when>
                    <c:otherwise>
                        No candidates have applied to your job postings yet.
                    </c:otherwise>
                </c:choose>
            </p>
            <a href="${pageContext.request.contextPath}/recruiter/jobs/" 
               class="bg-blue-600 text-white px-4 py-2 rounded-lg hover:bg-blue-700 transition-colors duration-200">
                View Your Jobs
            </a>
        </div>
    </c:if>

    <c:if test="${not empty candidates}">
        <div class="bg-white rounded-lg shadow-md overflow-hidden">
            <div class="overflow-x-auto">
                <table class="min-w-full divide-y divide-gray-200">
                    <thead class="bg-gray-50">
                        <tr>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                Candidate
                            </th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                Job Applied
                            </th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                Status
                            </th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                Applied Date
                            </th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                Actions
                            </th>
                        </tr>
                    </thead>
                    <tbody class="bg-white divide-y divide-gray-200">
                        <c:forEach var="candidate" items="${candidates}">
                            <tr class="hover:bg-gray-50 transition-colors duration-150">
                                <td class="px-6 py-4 whitespace-nowrap">
                                    <div class="flex items-center">
                                        <div class="flex-shrink-0 h-10 w-10 bg-blue-500 rounded-full flex items-center justify-center">
                                            <span class="text-white font-semibold text-sm">
                                                ${candidate.fullname.substring(0, 1)}
                                            </span>
                                        </div>
                                        <div class="ml-4">
                                            <div class="text-sm font-medium text-gray-900">
                                                ${candidate.fullname}
                                            </div>
                                            <div class="text-sm text-gray-500">
                                                ${candidate.email}
                                            </div>
                                            <c:if test="${not empty candidate.phoneNumber}">
                                                <div class="text-sm text-gray-500">
                                                    <i class="fas fa-phone mr-1"></i>${candidate.phoneNumber}
                                                </div>
                                            </c:if>
                                        </div>
                                    </div>
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap">
                                    <div class="text-sm text-gray-900">${candidate.jobTitle}</div>
                                    <c:if test="${not empty candidate.resumeTitle}">
                                        <div class="text-sm text-gray-500">
                                            <i class="fas fa-file-alt mr-1"></i>${candidate.resumeTitle}
                                        </div>
                                    </c:if>
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap">
                                    <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full 
                                        ${candidate.applicationStatus == 'Applied' ? 'bg-blue-100 text-blue-800' : 
                                          candidate.applicationStatus == 'Interview' ? 'bg-yellow-100 text-yellow-800' : 
                                          candidate.applicationStatus == 'Offer' ? 'bg-green-100 text-green-800' : 
                                          candidate.applicationStatus == 'Hired' ? 'bg-purple-100 text-purple-800' : 
                                          'bg-red-100 text-red-800'}">
                                        ${candidate.applicationStatus}
                                    </span>
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                    ${candidate.appliedAt.toLocalDate()}
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap text-sm font-medium">
                                    <div class="flex space-x-2">
                                        <a href="${pageContext.request.contextPath}/recruiter/candidates/view?id=${candidate.userId}" 
                                           class="text-blue-600 hover:text-blue-900 transition-colors duration-200">
                                            <i class="fas fa-eye mr-1"></i>View
                                        </a>
                                        <c:if test="${not empty candidate.resumeFilePath}">
                                            <a href="${pageContext.request.contextPath}/download?file=${candidate.resumeFilePath}" 
                                               target="_blank"
                                               class="text-green-600 hover:text-green-900 transition-colors duration-200">
                                                <i class="fas fa-download mr-1"></i>Resume
                                            </a>
                                        </c:if>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
        
        <!-- Results Summary -->
        <div class="mt-4 flex justify-between items-center">
            <p class="text-sm text-gray-600">
                Showing <span class="font-semibold">${candidates.size()}</span> candidate(s)
            </p>
            <c:if test="${not empty searchKeyword or not empty statusFilter or not empty jobFilter}">
                <a href="${pageContext.request.contextPath}/recruiter/candidates/" 
                   class="text-blue-600 hover:text-blue-800 text-sm flex items-center">
                    <i class="fas fa-times mr-1"></i> Clear all filters
                </a>
            </c:if>
        </div>
    </c:if>
</div>