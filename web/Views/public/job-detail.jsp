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

        <!-- Content -->
        <div class="p-6">
            <!-- Basic Info -->
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

            <!-- Footer -->
            <div class="mt-8 pt-6 border-t border-gray-200 flex flex-col sm:flex-row justify-between items-center">
                <div class="text-sm text-gray-500">
                    <p>Posted: ${job.postedAt}</p>
                    <p>Expires: ${job.expiredAt}</p>
                </div>
                <div class="mt-4 sm:mt-0">
                    <a href="#" class="bg-blue-600 text-white px-6 py-3 rounded-lg hover:bg-blue-700 transition-colors duration-200 font-semibold">
                        Apply Now
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>