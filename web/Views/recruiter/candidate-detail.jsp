<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="container mx-auto px-4 py-8">
    <!-- Header with Navigation -->
    <div class="flex items-center justify-between mb-6">
        <div class="flex items-center space-x-4">
            <a href="${pageContext.request.contextPath}/recruiter/candidates/" 
               class="inline-flex items-center text-blue-600 hover:text-blue-800 transition-colors duration-200">
                <i class="fas fa-arrow-left mr-2"></i>
                Back to Candidates
            </a>
            <div class="h-6 border-l border-gray-300"></div>
            <h1 class="text-2xl font-bold text-gray-800">Candidate Details</h1>
        </div>
        <div class="flex space-x-2">
            <c:if test="${not empty candidate.resumeFilePath}">
                <a href="${pageContext.request.contextPath}/download?file=${candidate.resumeFilePath}" 
                   target="_blank"
                   class="inline-flex items-center bg-green-600 text-white px-4 py-2 rounded-lg hover:bg-green-700 transition-colors duration-200">
                    <i class="fas fa-download mr-2"></i>Download Resume
                </a>
            </c:if>
            <button onclick="window.print()" 
                    class="inline-flex items-center bg-gray-600 text-white px-4 py-2 rounded-lg hover:bg-gray-700 transition-colors duration-200">
                <i class="fas fa-print mr-2"></i>Print
            </button>
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

    <div class="grid grid-cols-1 lg:grid-cols-3 gap-6">
        <!-- Left Column - Candidate Info -->
        <div class="lg:col-span-1">
            <!-- Candidate Profile Card -->
            <div class="bg-white rounded-lg shadow-md p-6 mb-6">
                <div class="text-center mb-6">
                    <div class="w-24 h-24 bg-blue-500 rounded-full flex items-center justify-center mx-auto mb-4">
                        <span class="text-white font-bold text-2xl">
                            ${candidate.fullname.substring(0, 1)}
                        </span>
                    </div>
                    <h2 class="text-xl font-bold text-gray-800">${candidate.fullname}</h2>
                    <p class="text-gray-600">Candidate</p>
                </div>

                <div class="space-y-4">
                    <div class="flex items-center">
                        <i class="fas fa-envelope text-gray-400 w-6"></i>
                        <div>
                            <p class="text-sm text-gray-500">Email</p>
                            <p class="text-gray-800">${candidate.email}</p>
                        </div>
                    </div>
                    
                    <c:if test="${not empty candidate.phoneNumber}">
                        <div class="flex items-center">
                            <i class="fas fa-phone text-gray-400 w-6"></i>
                            <div>
                                <p class="text-sm text-gray-500">Phone</p>
                                <p class="text-gray-800">${candidate.phoneNumber}</p>
                            </div>
                        </div>
                    </c:if>

                    <c:if test="${not empty candidate.address}">
                        <div class="flex items-start">
                            <i class="fas fa-map-marker-alt text-gray-400 w-6 mt-1"></i>
                            <div>
                                <p class="text-sm text-gray-500">Address</p>
                                <p class="text-gray-800">${candidate.address}</p>
                            </div>
                        </div>
                    </c:if>

                    <div class="flex items-center">
                        <i class="fas fa-calendar-alt text-gray-400 w-6"></i>
                        <div>
                            <p class="text-sm text-gray-500">Member Since</p>
                            <p class="text-gray-800">${candidate.createdAt.toLocalDate()}</p>
                        </div>
                    </div>

                    <div class="flex items-center">
                        <i class="fas fa-user-check text-gray-400 w-6"></i>
                        <div>
                            <p class="text-sm text-gray-500">Status</p>
                            <span class="px-2 py-1 text-xs font-semibold rounded-full 
                                ${candidate.status == 'Active' ? 'bg-green-100 text-green-800' : 'bg-red-100 text-red-800'}">
                                ${candidate.status}
                            </span>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Quick Actions -->
            <div class="bg-white rounded-lg shadow-md p-6">
                <h3 class="text-lg font-semibold text-gray-800 mb-4">Quick Actions</h3>
                <div class="space-y-2">
                    <a href="mailto:${candidate.email}" 
                       class="w-full flex items-center justify-center bg-blue-600 text-white px-4 py-2 rounded-lg hover:bg-blue-700 transition-colors duration-200">
                        <i class="fas fa-envelope mr-2"></i>Send Email
                    </a>
                    <c:if test="${not empty candidate.phoneNumber}">
                        <a href="tel:${candidate.phoneNumber}" 
                           class="w-full flex items-center justify-center bg-green-600 text-white px-4 py-2 rounded-lg hover:bg-green-700 transition-colors duration-200">
                            <i class="fas fa-phone mr-2"></i>Call Candidate
                        </a>
                    </c:if>
                    <button onclick="scheduleInterview(${candidate.userId})" 
                            class="w-full flex items-center justify-center bg-purple-600 text-white px-4 py-2 rounded-lg hover:bg-purple-700 transition-colors duration-200">
                        <i class="fas fa-calendar-plus mr-2"></i>Schedule Interview
                    </button>
                </div>
            </div>
        </div>

        <!-- Right Column - Detailed Information -->
        <div class="lg:col-span-2">
            <!-- Resume Summary -->
            <c:if test="${not empty candidate.summary}">
                <div class="bg-white rounded-lg shadow-md p-6 mb-6">
                    <h3 class="text-lg font-semibold text-gray-800 mb-4 flex items-center">
                        <i class="fas fa-file-alt mr-2"></i>Professional Summary
                    </h3>
                    <p class="text-gray-700 leading-relaxed">${candidate.summary}</p>
                </div>
            </c:if>

            <!-- Skills -->
            <c:if test="${not empty candidate.skillsText}">
                <div class="bg-white rounded-lg shadow-md p-6 mb-6">
                    <h3 class="text-lg font-semibold text-gray-800 mb-4 flex items-center">
                        <i class="fas fa-tools mr-2"></i>Skills & Expertise
                    </h3>
                    <div class="flex flex-wrap gap-2">
                        <c:forTokens items="${candidate.skillsText}" delims="," var="skill">
                            <span class="bg-blue-100 text-blue-800 px-3 py-1 rounded-full text-sm">
                                ${skill.trim()}
                            </span>
                        </c:forTokens>
                    </div>
                </div>
            </c:if>

            <!-- Experience -->
            <c:if test="${not empty candidate.experience}">
                <div class="bg-white rounded-lg shadow-md p-6 mb-6">
                    <h3 class="text-lg font-semibold text-gray-800 mb-4 flex items-center">
                        <i class="fas fa-briefcase mr-2"></i>Work Experience
                    </h3>
                    <div class="prose max-w-none">
                        <p class="text-gray-700 whitespace-pre-line">${candidate.experience}</p>
                    </div>
                </div>
            </c:if>

            <!-- Education -->
            <c:if test="${not empty candidate.education}">
                <div class="bg-white rounded-lg shadow-md p-6 mb-6">
                    <h3 class="text-lg font-semibold text-gray-800 mb-4 flex items-center">
                        <i class="fas fa-graduation-cap mr-2"></i>Education
                    </h3>
                    <div class="prose max-w-none">
                        <p class="text-gray-700 whitespace-pre-line">${candidate.education}</p>
                    </div>
                </div>
            </c:if>

            <!-- Application History -->
            <div class="bg-white rounded-lg shadow-md p-6">
                <h3 class="text-lg font-semibold text-gray-800 mb-4 flex items-center">
                    <i class="fas fa-history mr-2"></i>Application History
                </h3>
                
                <c:if test="${empty candidate.applications}">
                    <div class="text-center py-8 text-gray-500">
                        <i class="fas fa-inbox text-3xl mb-3"></i>
                        <p>No application history found.</p>
                    </div>
                </c:if>

                <c:if test="${not empty candidate.applications}">
                    <div class="space-y-4">
                        <c:forEach var="application" items="${candidate.applications}">
                            <div class="border border-gray-200 rounded-lg p-4 hover:border-blue-300 transition-colors duration-200">
                                <div class="flex justify-between items-start mb-2">
                                    <div>
                                        <h4 class="font-semibold text-gray-800">${application.jobTitle}</h4>
                                        <p class="text-sm text-gray-500">
                                            Applied: ${application.appliedAt.toLocalDate()} at ${application.appliedAt.toLocalTime()}
                                        </p>
                                    </div>
                                    <div class="flex items-center space-x-2">
                                        <span class="px-3 py-1 text-xs font-semibold rounded-full 
                                            ${application.status == 'Applied' ? 'bg-blue-100 text-blue-800' : 
                                              application.status == 'Screening' ? 'bg-yellow-100 text-yellow-800' : 
                                              application.status == 'Interview' ? 'bg-orange-100 text-orange-800' : 
                                              application.status == 'Offer' ? 'bg-green-100 text-green-800' : 
                                              application.status == 'Hired' ? 'bg-purple-100 text-purple-800' : 
                                              'bg-red-100 text-red-800'}">
                                            ${application.status}
                                        </span>
                                        
                                        <!-- Status Update Dropdown -->
                                        <div class="relative">
                                            <button onclick="toggleDropdown('statusDropdown${application.applicationId}')" 
                                                    class="text-gray-400 hover:text-gray-600 transition-colors duration-200">
                                                <i class="fas fa-ellipsis-v"></i>
                                            </button>
                                            <div id="statusDropdown${application.applicationId}" 
                                                 class="absolute right-0 mt-2 w-48 bg-white rounded-lg shadow-lg border border-gray-200 hidden z-10">
                                                <form action="${pageContext.request.contextPath}/recruiter/candidates/" 
                                                      method="post" 
                                                      class="p-2 space-y-1">
                                                    <input type="hidden" name="action" value="updateStatus">
                                                    <input type="hidden" name="applicationId" value="${application.applicationId}">
                                                    <input type="hidden" name="redirectUrl" value="${pageContext.request.contextPath}/recruiter/candidates/view?id=${candidate.userId}">
                                                    
                                                    <button type="submit" name="status" value="Screening" 
                                                            class="w-full text-left px-3 py-2 text-sm text-yellow-600 hover:bg-yellow-50 rounded-md transition-colors duration-200">
                                                        <i class="fas fa-search mr-2"></i>Move to Screening
                                                    </button>
                                                    <button type="submit" name="status" value="Interview" 
                                                            class="w-full text-left px-3 py-2 text-sm text-orange-600 hover:bg-orange-50 rounded-md transition-colors duration-200">
                                                        <i class="fas fa-calendar-alt mr-2"></i>Schedule Interview
                                                    </button>
                                                    <button type="submit" name="status" value="Offer" 
                                                            class="w-full text-left px-3 py-2 text-sm text-green-600 hover:bg-green-50 rounded-md transition-colors duration-200">
                                                        <i class="fas fa-handshake mr-2"></i>Send Offer
                                                    </button>
                                                    <button type="submit" name="status" value="Hired" 
                                                            class="w-full text-left px-3 py-2 text-sm text-purple-600 hover:bg-purple-50 rounded-md transition-colors duration-200">
                                                        <i class="fas fa-user-check mr-2"></i>Mark as Hired
                                                    </button>
                                                    <hr>
                                                    <button type="submit" name="status" value="Rejected" 
                                                            class="w-full text-left px-3 py-2 text-sm text-red-600 hover:bg-red-50 rounded-md transition-colors duration-200"
                                                            onclick="return confirm('Are you sure you want to reject this application?')">
                                                        <i class="fas fa-times mr-2"></i>Reject
                                                    </button>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="flex justify-between items-center mt-3">
                                    <div class="text-sm text-gray-500">
                                        Application ID: #${application.applicationId}
                                    </div>
                                    <a href="${pageContext.request.contextPath}/manager/jobs/preview?id=${application.jobId}" 
                                       target="_blank"
                                       class="text-blue-600 hover:text-blue-800 text-sm flex items-center transition-colors duration-200">
                                        <i class="fas fa-external-link-alt mr-1"></i>View Job
                                    </a>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:if>
            </div>

            <!-- Notes Section -->
            <div class="bg-white rounded-lg shadow-md p-6 mt-6">
                <h3 class="text-lg font-semibold text-gray-800 mb-4 flex items-center">
                    <i class="fas fa-sticky-note mr-2"></i>Recruiter Notes
                </h3>
                <form action="#" method="post">
                    <textarea name="notes" rows="4" 
                              class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent" 
                              placeholder="Add your notes about this candidate..."></textarea>
                    <div class="mt-3 flex justify-end">
                        <button type="submit" 
                                class="bg-blue-600 text-white px-4 py-2 rounded-lg hover:bg-blue-700 transition-colors duration-200">
                            Save Notes
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
// Toggle dropdown menus
function toggleDropdown(dropdownId) {
    const dropdown = document.getElementById(dropdownId);
    dropdown.classList.toggle('hidden');
}

// Close dropdowns when clicking outside
document.addEventListener('click', function(event) {
    const dropdowns = document.querySelectorAll('[id^="statusDropdown"]');
    dropdowns.forEach(dropdown => {
        if (!dropdown.contains(event.target) && !event.target.closest('button')) {
            dropdown.classList.add('hidden');
        }
    });
});

// Schedule interview function
function scheduleInterview(candidateId) {
    const interviewDate = prompt('Enter interview date and time (YYYY-MM-DD HH:MM):');
    if (interviewDate) {
        // Here you would typically make an AJAX call to schedule the interview
        alert(`Interview scheduled for candidate ${candidateId} at ${interviewDate}`);
        // Update status to Interview
        updateApplicationStatus(candidateId, 'Interview');
    }
}

// Update application status
function updateApplicationStatus(candidateId, status) {
    // This would typically be an AJAX call to update the status
    console.log(`Updating candidate ${candidateId} status to ${status}`);
}

// Print-friendly styles
@media print {
    .no-print {
        display: none !important;
    }
    
    .bg-white {
        background: white !important;
    }
    
    .shadow-md {
        box-shadow: none !important;
    }
    
    .border {
        border: 1px solid #e5e7eb !important;
    }
}
</script>

<style>
.prose {
    max-width: none;
}
.prose p {
    margin-bottom: 1rem;
    line-height: 1.6;
}
.prose ul {
    list-style-type: disc;
    margin-left: 1.5rem;
    margin-bottom: 1rem;
}
.prose ol {
    list-style-type: decimal;
    margin-left: 1.5rem;
    margin-bottom: 1rem;
}
</style>