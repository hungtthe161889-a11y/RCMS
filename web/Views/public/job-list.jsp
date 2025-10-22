<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="container mx-auto px-4 py-8">
    <h1 class="text-3xl font-bold text-gray-800 mb-6">Job Opportunities</h1>
    
    <!-- Advanced Search & Filter Form -->
    <div class="bg-white rounded-lg shadow-md p-6 mb-6">
        <form action="jobs" method="get" class="space-y-4">
            <input type="hidden" name="action" value="search">
            
            <!-- Keyword Search -->
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
                    <select name="categoryId" class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
                        <option value="">All Categories</option>
                        <c:forEach var="category" items="${categories}">
                            <option value="${category.categoryId}" ${selectedCategory == category.categoryId ? 'selected' : ''}>
                                ${category.categoryName}
                            </option>
                        </c:forEach>
                    </select>
                </div>
                
                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-2">Location</label>
                    <select name="locationId" class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
                        <option value="">All Locations</option>
                        <c:forEach var="location" items="${locations}">
                            <option value="${location.locationId}" ${selectedLocation == location.locationId ? 'selected' : ''}>
                                ${location.province}, ${location.ward}
                            </option>
                        </c:forEach>
                    </select>
                </div>
                
                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-2">Experience</label>
                    <select name="experience" class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
                        <option value="">All Experience</option>
                        <option value="Fresher" ${selectedExperience == 'Fresher' ? 'selected' : ''}>Fresher</option>
                        <option value="1" ${selectedExperience == '1' ? 'selected' : ''}>1+ years</option>
                        <option value="2" ${selectedExperience == '2' ? 'selected' : ''}>2+ years</option>
                        <option value="3" ${selectedExperience == '3' ? 'selected' : ''}>3+ years</option>
                        <option value="5" ${selectedExperience == '5' ? 'selected' : ''}>5+ years</option>
                    </select>
                </div>
            </div>
            
            <!-- Additional Filters -->
            <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-2">Work Type</label>
                    <select name="workType" class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
                        <option value="">All Work Types</option>
                        <option value="Full-time" ${selectedWorkType == 'Full-time' ? 'selected' : ''}>Full-time</option>
                        <option value="Part-time" ${selectedWorkType == 'Part-time' ? 'selected' : ''}>Part-time</option>
                        <option value="Remote" ${selectedWorkType == 'Remote' ? 'selected' : ''}>Remote</option>
                        <option value="Hybrid" ${selectedWorkType == 'Hybrid' ? 'selected' : ''}>Hybrid</option>
                    </select>
                </div>
                
                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-2">Salary Range</label>
                    <select name="salary" class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
                        <option value="">All Salaries</option>
                        <option value="under10" ${selectedSalary == 'under10' ? 'selected' : ''}>Under 10M VND</option>
                        <option value="10to15" ${selectedSalary == '10to15' ? 'selected' : ''}>10M - 15M VND</option>
                        <option value="15to20" ${selectedSalary == '15to20' ? 'selected' : ''}>15M - 20M VND</option>
                        <option value="20to25" ${selectedSalary == '20to25' ? 'selected' : ''}>20M - 25M VND</option>
                        <option value="over25" ${selectedSalary == 'over25' ? 'selected' : ''}>Over 25M VND</option>
                    </select>
                </div>
                
                <div class="flex items-end space-x-2">
                    <button type="submit" 
                            class="w-full bg-blue-600 text-white px-4 py-2 rounded-md hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-blue-500 transition-colors duration-200">
                        <i class="fas fa-search mr-2"></i>Search Jobs
                    </button>
                    <a href="jobs" 
                       class="bg-gray-500 text-white px-4 py-2 rounded-md hover:bg-gray-600 focus:outline-none focus:ring-2 focus:ring-gray-500 transition-colors duration-200">
                        <i class="fas fa-times mr-2"></i>Clear
                    </a>
                </div>
            </div>
        </form>
        
        <!-- Active Filters Display -->
        <c:if test="${not empty searchKeyword or not empty selectedCategory or not empty selectedLocation or not empty selectedExperience or not empty selectedWorkType or not empty selectedSalary}">
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
                        <c:if test="${not empty selectedCategory}">
                            <c:forEach var="category" items="${categories}">
                                <c:if test="${category.categoryId == selectedCategory}">
                                    <span class="bg-blue-100 px-3 py-1 rounded-full text-xs font-semibold">
                                        Category: ${category.categoryName}
                                    </span>
                                </c:if>
                            </c:forEach>
                        </c:if>
                        <c:if test="${not empty selectedLocation}">
                            <c:forEach var="location" items="${locations}">
                                <c:if test="${location.locationId == selectedLocation}">
                                    <span class="bg-blue-100 px-3 py-1 rounded-full text-xs font-semibold">
                                        Location: ${location.province}, ${location.ward}
                                    </span>
                                </c:if>
                            </c:forEach>
                        </c:if>
                        <c:if test="${not empty selectedExperience}">
                            <span class="bg-blue-100 px-3 py-1 rounded-full text-xs font-semibold">
                                Experience: ${selectedExperience}
                            </span>
                        </c:if>
                        <c:if test="${not empty selectedWorkType}">
                            <span class="bg-blue-100 px-3 py-1 rounded-full text-xs font-semibold">
                                Work Type: ${selectedWorkType}
                            </span>
                        </c:if>
                        <c:if test="${not empty selectedSalary}">
                            <span class="bg-blue-100 px-3 py-1 rounded-full text-xs font-semibold">
                                Salary: 
                                <c:choose>
                                    <c:when test="${selectedSalary == 'under10'}">Under 10M VND</c:when>
                                    <c:when test="${selectedSalary == '10to15'}">10M - 15M VND</c:when>
                                    <c:when test="${selectedSalary == '15to20'}">15M - 20M VND</c:when>
                                    <c:when test="${selectedSalary == '20to25'}">20M - 25M VND</c:when>
                                    <c:when test="${selectedSalary == 'over25'}">Over 25M VND</c:when>
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
            <c:if test="${not empty searchKeyword or not empty selectedCategory or not empty selectedLocation}">
                matching your criteria
            </c:if>
        </p>
        <c:if test="${not empty searchKeyword or not empty selectedCategory or not empty selectedLocation or not empty selectedExperience or not empty selectedWorkType or not empty selectedSalary}">
            <a href="jobs" class="text-blue-600 hover:text-blue-800 text-sm flex items-center">
                <i class="fas fa-times mr-1"></i> Clear all filters
            </a>
        </c:if>
    </div>

    <!-- Job List -->
    <c:if test="${empty jobs}">
        <div class="bg-yellow-100 border border-yellow-400 text-yellow-700 px-4 py-6 rounded-lg text-center">
            <i class="fas fa-search text-3xl mb-3"></i>
            <h3 class="text-lg font-semibold mb-2">No Jobs Found</h3>
            <p class="text-sm mb-4">
                <c:choose>
                    <c:when test="${not empty searchKeyword or not empty selectedCategory or not empty selectedLocation}">
                        No jobs match your current filters. Try adjusting your search criteria.
                    </c:when>
                    <c:otherwise>
                        There are no job openings at the moment. Please check back later.
                    </c:otherwise>
                </c:choose>
            </p>
            <a href="jobs" class="bg-blue-600 text-white px-4 py-2 rounded-lg hover:bg-blue-700 transition-colors duration-200">
                Browse All Jobs
            </a>
        </div>
    </c:if>

    <c:if test="${not empty jobs}">
        <div class="space-y-4">
            <c:forEach var="job" items="${jobs}">
                <div class="bg-white rounded-lg shadow-md hover:shadow-lg transition-shadow duration-300 p-6">
                    <div class="flex flex-col lg:flex-row lg:items-start lg:justify-between">
                        <div class="flex-1">
                            <h3 class="text-xl font-semibold text-gray-800 mb-2">
                                <a href="jobs?action=view&id=${job.jobId}" class="hover:text-blue-600 transition-colors duration-200">
                                    ${job.title}
                                </a>
                            </h3>
                            
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
                                <div class="text-xs text-gray-500">
                                    <c:if test="${job.approvedAt != null}">
                                        <div class="text-green-600 flex items-center justify-center lg:justify-end">
                                            <i class="fas fa-check-circle mr-1"></i>Verified
                                        </div>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
        
        <!-- Results Summary -->
        <div class="mt-6 pt-4 border-t border-gray-200">
            <p class="text-center text-gray-500 text-sm">
                Showing ${jobs.size()} job(s) 
                <c:if test="${not empty searchKeyword}">
                    for "<strong>${searchKeyword}</strong>"
                </c:if>
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