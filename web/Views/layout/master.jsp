<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title><c:out value="${pageTitle != null ? pageTitle : 'RCMS Portal'}" /></title>
        
        <!-- Tailwind CSS -->
        <script src="https://cdn.tailwindcss.com"></script>
        <link href="https://cdn.jsdelivr.net/npm/tailwindcss@3.3.0/dist/tailwind.min.css" rel="stylesheet">
        
        <!-- Font Awesome -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        
        <!-- Custom CSS -->
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
    </head>
    <body class="flex flex-col min-h-screen bg-gray-50">
        <!-- Header -->
        <jsp:include page="/Views/layout/header.jsp"/>

        <!-- Main content -->
        <main class="flex-grow">
            <jsp:include page="${contentPage}" />
        </main>

        <!-- Footer -->
        <jsp:include page="/Views/layout/footer.jsp"/>
        
        <!-- Scripts -->
        <script>
            // Xử lý dropdown menus
            document.addEventListener('DOMContentLoaded', function() {
                // Auto-hide messages after 5 seconds
                setTimeout(() => {
                    const messages = document.querySelectorAll('.alert');
                    messages.forEach(message => {
                        message.style.transition = 'opacity 0.5s ease';
                        message.style.opacity = '0';
                        setTimeout(() => message.remove(), 500);
                    });
                }, 5000);
            });
        </script>
    </body>
</html>