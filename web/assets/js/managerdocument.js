function openEditModal(btn) {
    // Lấy dữ liệu từ nút
    const id = btn.getAttribute("data-id");
    const title = btn.getAttribute("data-title");
    const docType = btn.getAttribute("data-doctype");
    const issuedBy = btn.getAttribute("data-issuedby");
    const issuedAt = btn.getAttribute("data-issuedat");
    const expiresAt = btn.getAttribute("data-expiresat");
    const filePath = btn.getAttribute("data-filepath");

    // Gán dữ liệu vào form
    document.getElementById("edit_documentId").value = id;
    document.getElementById("edit_title").value = title;
    document.getElementById("edit_docType").value = docType;
    document.getElementById("edit_issuedBy").value = issuedBy;
    document.getElementById("edit_issuedAt").value = issuedAt || "";
    document.getElementById("edit_expiresAt").value = expiresAt && expiresAt !== "—" ? expiresAt : "";

    // 🧩 Hiển thị file hiện tại
    const currentFile = document.getElementById("currentFileName");
    if (filePath && filePath.trim() !== "") {
        const fileName = filePath.split("/").pop(); // chỉ lấy tên file
        currentFile.innerHTML = `📄 <span class="font-medium">${fileName}</span> 
      <a href="managerdocument?action=view&id=${id}" target="_blank" class="text-blue-500 underline ml-2">Xem file</a>`;
    } else {
        currentFile.innerHTML = `<span class="text-gray-400">Không có tệp đính kèm</span>`;
    }

    // Reset hiển thị file mới
    document.getElementById("newFileName").classList.add("hidden");
    document.getElementById("newFileName").innerText = "";

    // Hiển thị modal
    const modal = document.getElementById("editModal");
    modal.classList.remove("hidden");
    modal.classList.add("flex");
}

document.getElementById("edit_file").addEventListener("change", function (e) {
    const newFileNameBox = document.getElementById("newFileName");
    if (this.files && this.files.length > 0) {
        const file = this.files[0];
        newFileNameBox.innerText = `🆕 File mới: ${file.name}`;
        newFileNameBox.classList.remove("hidden");
    } else {
        newFileNameBox.classList.add("hidden");
        newFileNameBox.innerText = "";
    }
});

function closeEditModal() {
    const modal = document.getElementById("editModal");
    modal.classList.add("hidden");
    modal.classList.remove("flex");
}

function closeEditModal() {
    const modal = document.getElementById('editModal');
    modal.classList.add('hidden');
    modal.classList.remove('flex');
}

// Validate ngày client-side (giống server-side)
document.getElementById('editForm').addEventListener('submit', function (e) {
    const issuedAtVal = document.getElementById('edit_issuedAt').value;
    const expiresAtVal = document.getElementById('edit_expiresAt').value;

    const errBox = document.getElementById('edit_error');
    errBox.classList.add('hidden');
    errBox.innerText = '';

    if (!issuedAtVal)
        return; // đã required

    const issued = new Date(issuedAtVal);
    const today = new Date();
    today.setHours(0, 0, 0, 0);

    // 2) issuedAt không được là ngày trong tương lai
    if (issued > today) {
        e.preventDefault();
        errBox.innerText = '⚠️ Ngày cấp không được là ngày trong tương lai!';
        errBox.classList.remove('hidden');
        return;
    }

    if (expiresAtVal) {
        const expires = new Date(expiresAtVal);

        // 1) issuedAt <= expiresAt
        if (issued > expires) {
            e.preventDefault();
            errBox.innerText = '⚠️ Ngày cấp không được sau ngày hết hạn!';
            errBox.classList.remove('hidden');
            return;
        }

        // 3) Thời hạn không quá 100 năm
        const years = (expires.getFullYear() - issued.getFullYear())
                - ((expires.getMonth() < issued.getMonth() || (expires.getMonth() === issued.getMonth() && expires.getDate() < issued.getDate())) ? 1 : 0);
        if (years > 100) {
            e.preventDefault();
            errBox.innerText = '⚠️ Thời hạn chứng chỉ không được vượt quá 100 năm!';
            errBox.classList.remove('hidden');
            return;
        }
    }
});

// Phần tải file

const dropzone = document.getElementById('dropzone');
const fileInput = document.getElementById('fileInput');
const fileNameBox = document.getElementById('fileName');

// 🧩 Khi chọn file qua nút "Chọn file"
fileInput.addEventListener('change', function () {
    showSelectedFile(this.files);
});

// 🧩 Kéo & thả file
dropzone.addEventListener('dragover', (e) => {
    e.preventDefault();
    dropzone.classList.add('bg-blue-50', 'border-blue-400');
});

dropzone.addEventListener('dragleave', () => {
    dropzone.classList.remove('bg-blue-50', 'border-blue-400');
});

dropzone.addEventListener('drop', (e) => {
    e.preventDefault();
    dropzone.classList.remove('bg-blue-50', 'border-blue-400');

    const files = e.dataTransfer.files;
    if (files.length > 0) {
        fileInput.files = files; // gán vào input thật
        showSelectedFile(files);
    }
});

// 🧠 Hàm hiển thị file đã chọn
function showSelectedFile(files) {
    if (!files || files.length === 0) {
        fileNameBox.innerHTML = '<span class="text-gray-400">Chưa chọn file nào</span>';
        return;
    }

    const file = files[0];
    const sizeKB = (file.size / 1024).toFixed(1);
    const icon = getFileIcon(file.name);

    fileNameBox.innerHTML = `
      <div class="flex items-center justify-center gap-2 mt-2">
        ${icon}
        <span class="text-gray-700 font-medium">${file.name}</span>
        <span class="text-gray-400 text-xs">(${sizeKB} KB)</span>
      </div>
    `;
}

// 🧩 Icon tùy loại file
function getFileIcon(filename) {
    const ext = filename.split('.').pop().toLowerCase();
    let color = 'text-blue-500', icon = 'fa-file';
    if (['pdf'].includes(ext)) {
        color = 'text-red-500';
        icon = 'fa-file-pdf';
    } else if (['jpg', 'jpeg', 'png'].includes(ext)) {
        color = 'text-green-500';
        icon = 'fa-file-image';
    } else if (['doc', 'docx'].includes(ext)) {
        color = 'text-indigo-500';
        icon = 'fa-file-word';
    }
    return `<i class="fa-solid ${icon} ${color}"></i>`;
}

// Hiển thị mặc định
fileNameBox.innerHTML = '<span class="text-gray-400">Chưa chọn file nào</span>';
function showNotification(type, message) {
    const modal = document.getElementById("notificationModal");
    const iconBox = document.getElementById("notifIcon");
    const msgBox = document.getElementById("notifMessage");

    modal.classList.remove("hidden");
    modal.classList.add("flex");

    // reset style
    iconBox.className = "text-5xl mb-4";
    msgBox.className = "text-lg font-semibold mb-4";

    // setup icon & color
    if (type === "success") {
        iconBox.innerHTML = '<i class="fa-solid fa-circle-check text-green-500"></i>';
        msgBox.classList.add("text-green-700");
    } else if (type === "error") {
        iconBox.innerHTML = '<i class="fa-solid fa-circle-xmark text-red-500"></i>';
        msgBox.classList.add("text-red-700");
    } else if (type === "warning") {
        iconBox.innerHTML = '<i class="fa-solid fa-triangle-exclamation text-yellow-500"></i>';
        msgBox.classList.add("text-yellow-700");
    } else {
        iconBox.innerHTML = '<i class="fa-solid fa-circle-info text-blue-500"></i>';
        msgBox.classList.add("text-blue-700");
    }

    msgBox.innerHTML = message;

    // Tự ẩn sau 4 giây
    setTimeout(() => closeNotification(), 4000);
}

function closeNotification() {
    const modal = document.getElementById("notificationModal");
    modal.classList.add("hidden");
    modal.classList.remove("flex");
}