document.addEventListener("DOMContentLoaded", () => {
    // 🔹 Kích hoạt DataTable
    if (document.querySelector("#datatablesSimple")) {
        new simpleDatatables.DataTable("#datatablesSimple");
    }

    // ====== 🔹 Modal cập nhật trạng thái ======
    const modal = document.getElementById("statusModal");
    const closeBtn = document.getElementById("closeModal");
    const formAppId = document.getElementById("formAppId");
    const formNewStatus = document.getElementById("formNewStatus");

    document.querySelectorAll(".open-modal-btn").forEach(btn => {
        btn.addEventListener("click", () => {
            formAppId.value = btn.dataset.id;
            formNewStatus.value = btn.dataset.status;
            modal.classList.remove("hidden");
        });
    });

    if (closeBtn) {
        closeBtn.addEventListener("click", () => modal.classList.add("hidden"));
    }

    window.addEventListener("click", e => {
        if (e.target === modal) modal.classList.add("hidden");
    });

    // ====== 🔹 Modal xem chi tiết ======
    const detailModal = document.getElementById("detailModal");
    const detailContent = document.getElementById("detailContent");

    document.querySelectorAll(".view-detail-btn").forEach(btn => {
        btn.addEventListener("click", async () => {
            const id = btn.dataset.id;

            try {
                // 🛰️ Gọi servlet để lấy chi tiết đơn ứng tuyển
                const res = await fetch(`applications?action=detail&id=${id}`);
                if (!res.ok) throw new Error("Fetch failed");
                const data = await res.json();

                // 🔍 Tìm dòng chứa nút bấm
                const row = btn.closest("tr");
                const userName = row?.children[1]?.innerText.trim().split("\n")[0] || "Unknown";
                const jobTitle = row?.children[2]?.innerText.trim() || "Unknown";

                // 🧩 Render nội dung chi tiết
                detailContent.innerHTML = `
                    <p><strong>Application ID:</strong> #${data.applicationId}</p>
                    <p><strong>Applicant:</strong> ${userName}</p>
                    <p><strong>Job Title:</strong> ${jobTitle}</p>
                    <p><strong>Status:</strong> ${data.status}</p>
                    <p><strong>Applied Date:</strong> ${data.appliedAt || "N/A"}</p>
                    ${
                        data.resumeId
                            ? `
                                <hr class="my-3">
                                <p><strong>Resume ID:</strong> ${data.resumeId}</p>
                                <a href="managerresume?action=view&id=${data.resumeId}" 
                                   target="_blank" 
                                   class="text-blue-600 hover:underline">View Resume</a>
                              `
                            : ""
                    }
                `;

                detailModal.classList.remove("hidden");

            } catch (err) {
                console.error("❌ Error loading application detail:", err);
                detailContent.innerHTML = `<p class="text-red-600">❌ Failed to load details.</p>`;
                detailModal.classList.remove("hidden");
            }
        });
    });

    // 🔹 Đóng modal chi tiết
    const closeDetailBtn = document.getElementById("closeDetail");
    if (closeDetailBtn) {
        closeDetailBtn.addEventListener("click", () => {
            detailModal.classList.add("hidden");
        });
    }
});
