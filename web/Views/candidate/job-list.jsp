<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="container mx-auto px-4 py-8">
    <div class="flex flex-col md:flex-row md:items-center md:justify-between mb-6">
        <h1 class="text-3xl font-bold text-gray-800">${pageTitle}</h1>
        <div class="flex space-x-4 mt-4 md:mt-0">
            <a href="jobs" 
               class="px-4 py-2 rounded-lg ${pageTitle == 'Available Jobs' ? 'bg-blue-600 text-white' : 'bg-gray-200 text-gray-700 hover:bg-gray-300'} transition-colors duration-200">
                Available Jobs
            </a>
            <a href="jobs?action=applied" 
               class="px-4 py-2 rounded-lg ${pageTitle == 'Applied Jobs' ? 'bg-blue-600 text-white' : 'bg-gray-200 text-gray-700 hover:bg-gray-300'} transition-colors duration-200">
                Applied Jobs
            </a>
        </div>
    </div>

    <c:if test="${pageTitle == 'Available Jobs'}">
        <!-- Filter Form for Available Jobs -->
        <div class="bg-white rounded-lg shadow-md p-6 mb-6">
            <form method="get" class="space-y-4">
                <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-2">Keyword</label>
                        <input type="text" name="keyword" 
                               class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500" 
                               placeholder="Job title, keyword..." 
                               value="${searchKeyword}">
                    </div>
                    
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
                        <label class="block text-sm font-medium text-gray-700 mb-2">Location</label>
                        <select name="location" class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
                            <option value="">All Locations</option>
                            <c:forEach var="location" items="${locations}">
                                <option value="${location.locationId}" ${locationFilter == location.locationId.toString() ? 'selected' : ''}>
                                    ${location.province}, ${location.ward}
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                    
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-2">Experience</label>
                        <select name="experience" class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
                            <option value="">All Experience</option>
                            <option value="Fresher" ${experienceFilter == 'Fresher' ? 'selected' : ''}>Fresher</option>
                            <option value="1" ${experienceFilter == '1' ? 'selected' : ''}>1+ years</option>
                            <option value="2" ${experienceFilter == '2' ? 'selected' : ''}>2+ years</option>
                            <option value="3" ${experienceFilter == '3' ? 'selected' : ''}>3+ years</option>
                            <option value="5" ${experienceFilter == '5' ? 'selected' : ''}>5+ years</option>
                        </select>
                    </div>
                </div>
                
                <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-2">Work Type</label>
                        <select name="workType" class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
                            <option value="">All Work Types</option>
                            <option value="Full-time" ${workTypeFilter == 'Full-time' ? 'selected' : ''}>Full-time</option>
                            <option value="Part-time" ${workTypeFilter == 'Part-time' ? 'selected' : ''}>Part-time</option>
                            <option value="Remote" ${workTypeFilter == 'Remote' ? 'selected' : ''}>Remote</option>
                            <option value="Hybrid" ${workTypeFilter == 'Hybrid' ? 'selected' : ''}>Hybrid</option>
                        </select>
                    </div>
                    
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-2">Salary Range</label>
                        <select name="salary" class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
                            <option value="">All Salaries</option>
                            <option value="under10" ${salaryFilter == 'under10' ? 'selected' : ''}>Under 10M VND</option>
                            <option value="10to15" ${salaryFilter == '10to15' ? 'selected' : ''}>10M - 15M VND</option>
                            <option value="15to20" ${salaryFilter == '15to20' ? 'selected' : ''}>15M - 20M VND</option>
                            <option value="20to25" ${salaryFilter == '20to25' ? 'selected' : ''}>20M - 25M VND</option>
                            <option value="over25" ${salaryFilter == 'over25' ? 'selected' : ''}>Over 25M VND</option>
                        </select>
                    </div>
                    
                    <div class="flex items-end space-x-2">
                        <button type="submit" 
                                class="w-full bg-blue-600 text-white px-4 py-2 rounded-md hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-blue-500 transition-colors duration-200">
                            <i class="fas fa-filter mr-2"></i>Apply Filters
                        </button>
                        <a href="jobs" 
                           class="bg-gray-500 text-white px-4 py-2 rounded-md hover:bg-gray-600 focus:outline-none focus:ring-2 focus:ring-gray-500 transition-colors duration-200">
                            <i class="fas fa-times mr-2"></i>Clear
                        </a>
                    </div>
                </div>
            </form>
            
            <!-- Active Filters Display -->
            <c:if test="${not empty searchKeyword or not empty categoryFilter or not empty locationFilter or not empty experienceFilter or not empty workTypeFilter or not empty salaryFilter}">
                <div class="mt-4 p-3 bg-blue-50 rounded-lg">
                    <div class="flex items-center text-sm text-blue-700">
                        <i class="fas fa-filter mr-2"></i>
                        <span class="font-medium">Active filters: </span>
                        <div class="flex flex-wrap gap-2 ml-2">
                            <c:if test="${not empty searchKeyword}">
                                <span class="bg-blue-100 px-3 py-1 rounded-full text-xs font-semibold">
                                    Keyword: "${searchKeyword}"
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
                            <c:if test="${not empty locationFilter}">
                                <c:forEach var="location" items="${locations}">
                                    <c:if test="${location.locationId == Integer.parseInt(locationFilter)}">
                                        <span class="bg-blue-100 px-3 py-1 rounded-full text-xs font-semibold">
                                            Location: ${location.province}, ${location.ward}
                                        </span>
                                    </c:if>
                                </c:forEach>
                            </c:if>
                            <c:if test="${not empty experienceFilter}">
                                <span class="bg-blue-100 px-3 py-1 rounded-full text-xs font-semibold">
                                    Experience: ${experienceFilter}
                                </span>
                            </c:if>
                            <c:if test="${not empty workTypeFilter}">
                                <span class="bg-blue-100 px-3 py-1 rounded-full text-xs font-semibold">
                                    Work Type: ${workTypeFilter}
                                </span>
                            </c:if>
                            <c:if test="${not empty salaryFilter}">
                                <span class="bg-blue-100 px-3 py-1 rounded-full text-xs font-semibold">
                                    Salary: 
                                    <c:choose>
                                        <c:when test="${salaryFilter == 'under10'}">Under 10M VND</c:when>
                                        <c:when test="${salaryFilter == '10to15'}">10M - 15M VND</c:when>
                                        <c:when test="${salaryFilter == '15to20'}">15M - 20M VND</c:when>
                                        <c:when test="${salaryFilter == '20to25'}">20M - 25M VND</c:when>
                                        <c:when test="${salaryFilter == 'over25'}">Over 25M VND</c:when>
                                    </c:choose>
                                </span>
                            </c:if>
                        </div>
                    </div>
                </div>
            </c:if>
        </div>

        <!-- Results Count -->
        <div class="flex justify-between items-center mb-4">
            <p class="text-gray-600">
                Found <span class="font-semibold">${jobs.size()}</span> job(s)
                <c:if test="${not empty searchKeyword or not empty categoryFilter or not empty locationFilter}">
                    matching your criteria
                </c:if>
            </p>
            <c:if test="${not empty searchKeyword or not empty categoryFilter or not empty locationFilter or not empty experienceFilter or not empty workTypeFilter or not empty salaryFilter}">
                <a href="jobs" class="text-blue-600 hover:text-blue-800 text-sm flex items-center">
                    <i class="fas fa-times mr-1"></i> Clear all filters
                </a>
            </c:if>
        </div>
    </c:if>

    <c:if test="${empty jobs}">
        <div class="bg-yellow-100 border border-yellow-400 text-yellow-700 px-4 py-6 rounded-lg text-center">
            <i class="fas fa-inbox text-3xl mb-3"></i>
            <h3 class="text-lg font-semibold mb-2">
                <c:choose>
                    <c:when test="${pageTitle == 'Applied Jobs'}">No Applications Yet</c:when>
                    <c:otherwise>No Jobs Found</c:otherwise>
                </c:choose>
            </h3>
            <p class="text-sm mb-4">
                <c:choose>
                    <c:when test="${pageTitle == 'Applied Jobs'}">
                        You haven't applied to any jobs yet. Start browsing available jobs to apply!
                    </c:when>
                    <c:when test="${not empty searchKeyword or not empty categoryFilter or not empty locationFilter}">
                        No jobs match your current filters. Try adjusting your search criteria.
                    </c:when>
                    <c:otherwise>
                        There are no job openings at the moment. Please check back later.
                    </c:otherwise>
                </c:choose>
            </p>
            <c:if test="${pageTitle == 'Applied Jobs'}">
                <a href="jobs" class="bg-blue-600 text-white px-4 py-2 rounded-lg hover:bg-blue-700 transition-colors duration-200">
                    Browse Available Jobs
                </a>
            </c:if>
            <c:if test="${pageTitle == 'Available Jobs'}">
                <a href="jobs" class="bg-blue-600 text-white px-4 py-2 rounded-lg hover:bg-blue-700 transition-colors duration-200">
                    Browse All Jobs
                </a>
            </c:if>
        </div>
    </c:if>

    <c:if test="${not empty jobs}">
        <div class="grid gap-6">
            <c:forEach var="job" items="${jobs}">
                <div class="bg-white rounded-lg shadow-md hover:shadow-lg transition-shadow duration-300 p-6">
                    <div class="flex flex-col lg:flex-row lg:items-start lg:justify-between">
                        <div class="flex-1">
                            <div class="flex items-start justify-between mb-3">
                                <h3 class="text-xl font-semibold text-gray-800 mb-2">
                                    <a href="jobs?action=view&id=${job.jobId}" class="hover:text-blue-600 transition-colors duration-200">
                                        ${job.title}
                                    </a>
                                </h3>
                                <c:if test="${pageTitle == 'Applied Jobs'}">
                                    <span class="px-3 py-1 rounded-full text-sm font-semibold bg-green-100 text-green-800">
                                        <i class="fas fa-check mr-1"></i>Applied
                                    </span>
                                </c:if>
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
                                <c:if test="${not empty job.experience}">
                                    <span class="bg-purple-100 text-purple-800 px-3 py-1 rounded-full text-sm flex items-center">
                                        <i class="fas fa-briefcase mr-1"></i>
                                        ${job.experience}
                                    </span>
                                </c:if>
                                <c:if test="${not empty job.workType}">
                                    <span class="bg-orange-100 text-orange-800 px-3 py-1 rounded-full text-sm flex items-center">
                                        <i class="fas fa-clock mr-1"></i>
                                        ${job.workType}
                                    </span>
                                </c:if>
                            </div>
                            
                            <p class="text-gray-600 mb-3 line-clamp-2">
                                <c:if test="${not empty job.description}">
                                    ${job.description.length() > 150 ? job.description.substring(0, 150) + '...' : job.description}
                                </c:if>
                            </p>
                            
                            <div class="flex flex-wrap items-center gap-4 text-sm text-gray-500">
                                <c:if test="${job.minSalary != null && job.maxSalary != null}">
                                    <span class="text-green-600 font-semibold flex items-center">
                                        <i class="fas fa-money-bill-wave mr-1"></i>
                                        ${job.minSalary} - ${job.maxSalary} VND
                                    </span>
                                </c:if>
                                <span class="flex items-center">
                                    <i class="fas fa-calendar-alt mr-1"></i>
                                    Posted: ${job.postedAt.toLocalDate()}
                                </span>
                                <span class="flex items-center">
                                    <i class="fas fa-clock mr-1"></i>
                                    Expires: ${job.expiredAt.toLocalDate()}
                                </span>
                            </div>
                        </div>
                        
                        <div class="mt-4 lg:mt-0 lg:ml-6 lg:text-right">
                            <div class="space-y-2">
                                <a href="jobs?action=view&id=${job.jobId}" 
                                   class="inline-block bg-blue-600 text-white px-6 py-2 rounded-lg hover:bg-blue-700 transition-colors duration-200 font-semibold">
                                    View Details
                                </a>
                                <c:if test="${pageTitle == 'Available Jobs'}">
                                    <div class="text-xs text-gray-500">
                                        <c:if test="${job.approvedAt != null}">
                                            <div class="text-green-600 flex items-center justify-center lg:justify-end">
                                                <i class="fas fa-check-circle mr-1"></i>Verified
                                            </div>
                                        </c:if>
                                    </div>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
        
        <!-- Results Summary -->
        <div class="mt-6 pt-4 border-t border-gray-200">
            <p class="text-center text-gray-500 text-sm">
                <c:choose>
                    <c:when test="${pageTitle == 'Applied Jobs'}">
                        You have applied to ${jobs.size()} job(s)
                    </c:when>
                    <c:otherwise>
                        Showing ${jobs.size()} job(s) 
                        <c:if test="${not empty searchKeyword}">
                            for "<strong>${searchKeyword}</strong>"
                        </c:if>
                    </c:otherwise>
                </c:choose>
            </p>
        </div>
    </c:if>
</div>

<style>
.line-clamp-2 {
    display: -webkit-box;
    -webkit-line-clamp: 2;
    -webkit-box-orient: vertical;
    overflow: hidden;
}
</style>
