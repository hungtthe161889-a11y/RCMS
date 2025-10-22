<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="container mx-auto px-4 py-8">
    <a href="../recruiter/jobs/" class="inline-flex items-center text-blue-600 hover:text-blue-800 mb-6">
        <svg class="w-4 h-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 19l-7-7m0 0l7-7m-7 7h18"/>
        </svg>
        Back to Jobs
    </a>
    
    <div class="bg-white rounded-lg shadow-lg p-6">
        <h1 class="text-3xl font-bold text-gray-800 mb-6">
            <c:choose>
                <c:when test="${not empty job}">Edit Job Posting</c:when>
                <c:otherwise>Create New Job Posting</c:otherwise>
            </c:choose>
        </h1>

        <form action="jobs/" method="post" class="space-y-6">
            <c:if test="${not empty job}">
                <input type="hidden" name="jobId" value="${job.jobId}">
                <input type="hidden" name="action" value="update">
            </c:if>
            <c:if test="${empty job}">
                <input type="hidden" name="action" value="create">
            </c:if>

            <!-- Basic Information -->
            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-2">Job Title *</label>
                    <input type="text" name="title" value="${job.title}" required
                           class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent">
                </div>
                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-2">Category *</label>
                    <select name="categoryId" required
                            class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent">
                        <option value="">Select Category</option>
                        <c:forEach var="category" items="${categories}">
                            <option value="${category.categoryId}" 
                                    ${job.categoryId == category.categoryId ? 'selected' : ''}>
                                ${category.categoryName}
                            </option>
                        </c:forEach>
                    </select>
                </div>
            </div>

            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-2">Location *</label>
                    <select name="locationId" required
                            class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent">
                        <option value="">Select Location</option>
                        <c:forEach var="location" items="${locations}">
                            <option value="${location.locationId}" 
                                    ${job.locationId == location.locationId ? 'selected' : ''}>
                                ${location.province}, ${location.ward}
                            </option>
                        </c:forEach>
                    </select>
                </div>
                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-2">Expiry Date *</label>
                    <input type="date" name="expiredAt" value="${job.expiredAt.toLocalDate()}" required
                           class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent">
                </div>
            </div>

            <!-- Job Details -->
            <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-2">Experience</label>
                    <input type="text" name="experience" value="${job.experience}"
                           class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent">
                </div>
                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-2">Level</label>
                    <input type="text" name="level" value="${job.level}"
                           class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent">
                </div>
                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-2">Education</label>
                    <input type="text" name="education" value="${job.education}"
                           class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent">
                </div>
            </div>

            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-2">Quantity</label>
                    <input type="text" name="quantity" value="${job.quantity}"
                           class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent">
                </div>
                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-2">Work Type</label>
                    <input type="text" name="workType" value="${job.workType}"
                           class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent">
                </div>
            </div>

            <!-- Salary -->
            <div>
                <label class="block text-sm font-medium text-gray-700 mb-2">Salary Range (VND)</label>
                <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                    <input type="number" name="minSalary" placeholder="Minimum Salary" value="${job.minSalary}"
                           class="px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent">
                    <input type="number" name="maxSalary" placeholder="Maximum Salary" value="${job.maxSalary}"
                           class="px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent">
                </div>
            </div>

            <!-- Description & Requirements -->
            <div>
                <label class="block text-sm font-medium text-gray-700 mb-2">Job Description *</label>
                <textarea name="description" rows="4" required
                          class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent">${job.description}</textarea>
            </div>

            <div>
                <label class="block text-sm font-medium text-gray-700 mb-2">Requirements *</label>
                <textarea name="requirement" rows="4" required
                          class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent">${job.requirement}</textarea>
            </div>

            <div>
                <label class="block text-sm font-medium text-gray-700 mb-2">Benefits</label>
                <textarea name="interest" rows="3"
                          class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent">${job.interest}</textarea>
            </div>

            <div>
                <label class="block text-sm font-medium text-gray-700 mb-2">Income Information</label>
                <input type="text" name="income" value="${job.income}"
                       class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent">
            </div>

            <!-- Submit Button -->
            <div class="flex justify-end">
                <button type="submit" 
                        class="bg-blue-600 text-white px-8 py-3 rounded-lg hover:bg-blue-700 transition-colors duration-200 font-semibold">
                    <c:choose>
                        <c:when test="${not empty job}">Update Job</c:when>
                        <c:otherwise>Create Job</c:otherwise>
                    </c:choose>
                </button>
            </div>
        </form>
    </div>
</div>