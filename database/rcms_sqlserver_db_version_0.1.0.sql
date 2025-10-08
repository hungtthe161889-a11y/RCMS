-- Create the database if it doesn't already exist
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'rcms')
BEGIN
    CREATE DATABASE rcms;
END
GO

-- Switch to the context of the new database
USE rcms;
GO

-- Table structure for table `role`
IF OBJECT_ID('dbo.role', 'U') IS NOT NULL
    DROP TABLE dbo.role;
GO

CREATE TABLE [role] (
  [role_id] INT IDENTITY(1,1) NOT NULL,
  [role_name] NVARCHAR(20) NOT NULL,
  [description] NVARCHAR(MAX) NULL,
  PRIMARY KEY ([role_id])
);
GO

-- Table structure for table `user`
IF OBJECT_ID('dbo.user', 'U') IS NOT NULL
    DROP TABLE dbo.[user];
GO

CREATE TABLE [user] (
  [user_id] INT IDENTITY(1,1) NOT NULL,
  [role_id] INT NOT NULL,
  [status] NVARCHAR(100) NOT NULL,
  [fullname] NVARCHAR(256) NOT NULL,
  [email] NVARCHAR(256) NOT NULL,
  [password] NVARCHAR(1024) NOT NULL,
  [phone_number] NVARCHAR(15) NULL,
  [address] NVARCHAR(1024) NULL,
  [created_at] DATETIME2 NOT NULL,
  [updated_at] DATETIME2 NULL,
  PRIMARY KEY ([user_id]),
  CONSTRAINT [FK_user_role] FOREIGN KEY ([role_id]) REFERENCES [role] ([role_id])
);
GO

-- Table structure for table `skill`
IF OBJECT_ID('dbo.skill', 'U') IS NOT NULL
    DROP TABLE dbo.skill;
GO

CREATE TABLE [skill] (
  [skill_id] INT IDENTITY(1,1) NOT NULL,
  [skill_name] NVARCHAR(256) NOT NULL,
  PRIMARY KEY ([skill_id])
);
GO

-- Table structure for table `candidate_skill`
IF OBJECT_ID('dbo.candidate_skill', 'U') IS NOT NULL
    DROP TABLE dbo.candidate_skill;
GO

CREATE TABLE [candidate_skill] (
  [user_id] INT NOT NULL,
  [skill_id] INT NOT NULL,
  [level] NVARCHAR(256) NOT NULL,
  PRIMARY KEY ([user_id], [skill_id]),
  CONSTRAINT [FK_candidate_skill_skill] FOREIGN KEY ([skill_id]) REFERENCES [skill] ([skill_id]),
  CONSTRAINT [FK_candidate_skill_user] FOREIGN KEY ([user_id]) REFERENCES [user] ([user_id])
);
GO

-- Table structure for table `candidate_document`
IF OBJECT_ID('dbo.candidate_document', 'U') IS NOT NULL
    DROP TABLE dbo.candidate_document;
GO

CREATE TABLE [candidate_document] (
  [document_id] INT IDENTITY(1,1) NOT NULL,
  [user_id] INT NOT NULL,
  [title] NVARCHAR(1024) NOT NULL,
  [file_path] NVARCHAR(256) NOT NULL,
  [doc_type] NVARCHAR(30) NOT NULL,
  [uploaded_at] DATETIME2 NOT NULL,
  PRIMARY KEY ([document_id]),
  CONSTRAINT [FK_candidate_document_user] FOREIGN KEY ([user_id]) REFERENCES [user] ([user_id])
);
GO

-- Table structure for table `contract`
IF OBJECT_ID('dbo.contract', 'U') IS NOT NULL
    DROP TABLE dbo.contract;
GO

CREATE TABLE [contract] (
  [contract_id] INT IDENTITY(1,1) NOT NULL,
  [user_id] INT NOT NULL,
  [salary] DECIMAL(10, 0) NOT NULL,
  [start_date] DATE NOT NULL,
  [end_date] DATE NOT NULL,
  [contract_type] NVARCHAR(256) NOT NULL,
  [file_path] NVARCHAR(1024) NULL,
  [created_at] DATETIME2 NOT NULL,
  PRIMARY KEY ([contract_id]),
  CONSTRAINT [FK_contract_user] FOREIGN KEY ([user_id]) REFERENCES [user] ([user_id])
);
GO

-- Table structure for table `location`
IF OBJECT_ID('dbo.location', 'U') IS NOT NULL
    DROP TABLE dbo.location;
GO

CREATE TABLE [location] (
  [location_id] INT IDENTITY(1,1) NOT NULL,
  [province] NVARCHAR(256) NOT NULL,
  [ward] NVARCHAR(256) NOT NULL,
  [detail] NVARCHAR(MAX) NULL,
  PRIMARY KEY ([location_id])
);
GO

-- Table structure for table `job_category`
IF OBJECT_ID('dbo.job_category', 'U') IS NOT NULL
    DROP TABLE dbo.job_category;
GO

CREATE TABLE [job_category] (
  [category_id] INT IDENTITY(1,1) NOT NULL,
  [category_name] NVARCHAR(50) NOT NULL,
  [description] NVARCHAR(MAX) NULL,
  PRIMARY KEY ([category_id])
);
GO

-- Table structure for table `job_posting`
IF OBJECT_ID('dbo.job_posting', 'U') IS NOT NULL
    DROP TABLE dbo.job_posting;
GO

CREATE TABLE [job_posting] (
  [job_id] INT IDENTITY(1,1) NOT NULL,
  [category_id] INT NOT NULL,
  [location_id] INT NOT NULL,
  [title] NVARCHAR(1048) NOT NULL,
  [experience] NVARCHAR(256) NULL,
  [level] NVARCHAR(256) NULL,
  [education] NVARCHAR(256) NULL,
  [quantity] NVARCHAR(256) NULL,
  [work_type] NVARCHAR(MAX) NULL,
  [description] NVARCHAR(MAX) NULL,
  [requirement] NVARCHAR(MAX) NULL,
  [income] NVARCHAR(MAX) NULL,
  [interest] NVARCHAR(MAX) NULL,
  [min_salary] DECIMAL(10, 0) NULL,
  [max_salary] DECIMAL(10, 0) NULL,
  [status] NVARCHAR(256) NULL,
  [posted_at] DATETIME2 NOT NULL,
  [expired_at] DATETIME2 NOT NULL,
  PRIMARY KEY ([job_id]),
  CONSTRAINT [FK_job_posting_category] FOREIGN KEY ([category_id]) REFERENCES [job_category] ([category_id]),
  CONSTRAINT [FK_job_posting_location] FOREIGN KEY ([location_id]) REFERENCES [location] ([location_id])
);
GO

-- Table structure for table `application`
IF OBJECT_ID('dbo.application', 'U') IS NOT NULL
    DROP TABLE dbo.application;
GO

CREATE TABLE [application] (
  [application_id] INT IDENTITY(1,1) NOT NULL,
  [job_id] INT NOT NULL,
  [user_id] INT NOT NULL,
  [resume_id] INT NOT NULL,
  [status] NVARCHAR(256) NOT NULL,
  [applied_at] DATETIME2 NOT NULL,
  PRIMARY KEY ([application_id])
);
GO

-- Table structure for table `interview`
IF OBJECT_ID('dbo.interview', 'U') IS NOT NULL
    DROP TABLE dbo.interview;
GO

CREATE TABLE [interview] (
  [interview_id] INT IDENTITY(1,1) NOT NULL,
  [application_id] INT NOT NULL,
  [scheduled_at] DATETIME2 NOT NULL,
  [location_id] INT NOT NULL,
  [interviewer_fullname] NVARCHAR(256) NOT NULL,
  [notes] NVARCHAR(MAX) NULL,
  PRIMARY KEY ([interview_id])
  -- NOTE: You may want to add a FOREIGN KEY constraint to application(application_id)
);
GO

-- Table structure for table `interview_feedback`
IF OBJECT_ID('dbo.interview_feedback', 'U') IS NOT NULL
    DROP TABLE dbo.interview_feedback;
GO

CREATE TABLE [interview_feedback] (
  [feedback_id] INT IDENTITY(1,1) NOT NULL,
  [interview_id] INT NOT NULL,
  [reviewer_id] INT NOT NULL,
  [rating] DECIMAL(10, 0) NOT NULL,
  [comment] NVARCHAR(MAX) NULL,
  [created_at] DATETIME2 NOT NULL,
  PRIMARY KEY ([feedback_id]),
  CONSTRAINT [FK_interview_feedback_interview] FOREIGN KEY ([interview_id]) REFERENCES [interview] ([interview_id]),
  CONSTRAINT [FK_interview_feedback_user] FOREIGN KEY ([reviewer_id]) REFERENCES [user] ([user_id])
);
GO

-- Table structure for table `log`
IF OBJECT_ID('dbo.log', 'U') IS NOT NULL
    DROP TABLE dbo.log;
GO

CREATE TABLE [log] (
  [log_id] INT IDENTITY(1,1) NOT NULL,
  [log_time] DATETIME2 NOT NULL,
  [log_type] NVARCHAR(10) NOT NULL,
  [log_from] NVARCHAR(256) NULL,
  [request_by] NVARCHAR(256) NULL,
  [log_content] NVARCHAR(MAX) NULL,
  PRIMARY KEY ([log_id])
);
GO

-- Table structure for table `notification`
IF OBJECT_ID('dbo.notification', 'U') IS NOT NULL
    DROP TABLE dbo.notification;
GO

CREATE TABLE [notification] (
  [notification_id] INT IDENTITY(1,1) NOT NULL,
  [user_id] INT NOT NULL,
  [message] NVARCHAR(MAX) NULL,
  [is_read] BIT NULL,
  [created_at] DATETIME2 NOT NULL,
  PRIMARY KEY ([notification_id]),
  CONSTRAINT [FK_notification_user] FOREIGN KEY ([user_id]) REFERENCES [user] ([user_id])
);
GO

-- Table structure for table `offer`
IF OBJECT_ID('dbo.offer', 'U') IS NOT NULL
    DROP TABLE dbo.offer;
GO

CREATE TABLE [offer] (
  [offer_id] INT IDENTITY(1,1) NOT NULL,
  [application_id] INT NOT NULL,
  [position_title] NVARCHAR(1048) NOT NULL,
  [offered_salary] DECIMAL(10, 0) NOT NULL,
  [currency] NVARCHAR(50) NOT NULL,
  [start_date] DATE NOT NULL,
  [expired_at] DATETIME2 NOT NULL,
  [offered_at] DATETIME2 NOT NULL,
  [status] NVARCHAR(256) NOT NULL,
  [notes] NVARCHAR(MAX) NULL,
  PRIMARY KEY ([offer_id])
  -- NOTE: You may want to add a FOREIGN KEY constraint to application(application_id)
);
GO

-- Table structure for table `resume`
IF OBJECT_ID('dbo.resume', 'U') IS NOT NULL
    DROP TABLE dbo.resume;
GO

CREATE TABLE [resume] (
  [resume_id] INT IDENTITY(1,1) NOT NULL,
  [user_id] INT NOT NULL,
  [title] NVARCHAR(256) NULL,
  [summary] NVARCHAR(MAX) NULL,
  [experience] NVARCHAR(MAX) NULL,
  [education] NVARCHAR(MAX) NULL,
  [skills_text] NVARCHAR(MAX) NULL,
  [created_at] DATETIME2 NOT NULL,
  [file_path] NVARCHAR(256) NULL,
  PRIMARY KEY ([resume_id]),
  CONSTRAINT [FK_resume_user] FOREIGN KEY ([user_id]) REFERENCES [user] ([user_id])
);
GO

-- =================================================================
-- USE the rcms DATABASE
-- =================================================================
USE rcms;
GO

-- =================================================================
-- INSERT DATA INTO 'role' TABLE
-- =================================================================
-- Turn on IDENTITY_INSERT if you need to specify IDs, but it's not needed here.
-- We'll assume the role_id is an IDENTITY column starting at 1.
-- role_id 1: Admin
-- role_id 2: Candidate
-- role_id 3: HR Manager
PRINT 'Inserting data into role table...';
INSERT INTO [role] ([role_name], [description])
VALUES
    ('Admin', 'System administrator with full access rights.'),
    ('Candidate', 'Job seeker applying for positions.'),
    ('HR Manager', 'Human Resources manager responsible for recruitment.');
GO

-- =================================================================
-- INSERT DATA INTO 'user' TABLE
-- =================================================================
-- Note: Passwords should be securely hashed in a real application.
-- Using a placeholder 'defaultpassword' for demonstration.
PRINT 'Inserting data into user table...';
DECLARE @current_time DATETIME2 = GETDATE();

-- Insert 5 Admins (role_id = 1)
INSERT INTO [user] ([role_id], [status], [fullname], [email], [password], [phone_number], [address], [created_at])
VALUES
    (1, 'Active', N'Nguyễn Văn An', 'admin.an.nguyen@company.com', 'defaultpassword', '0912345678', N'123 Đường Láng, Đống Đa, Hà Nội', @current_time),
    (1, 'Active', N'Trần Thị Bích', 'admin.bich.tran@company.com', 'defaultpassword', '0987654321', N'456 Lê Lợi, Quận 1, TP. Hồ Chí Minh', @current_time),
    (1, 'Active', N'Lê Minh Cường', 'admin.cuong.le@company.com', 'defaultpassword', '0905112233', N'789 Hùng Vương, Hải Châu, Đà Nẵng', @current_time),
    (1, 'Active', N'Phạm Thuỳ Dung', 'admin.dung.pham@company.com', 'defaultpassword', '0934556677', N'101 Nguyễn Trãi, Thanh Xuân, Hà Nội', @current_time),
    (1, 'Inactive', N'Vũ Hoàng Anh', 'admin.anh.vu@company.com', 'defaultpassword', '0945889900', N'212 Cách Mạng Tháng Tám, Quận 3, TP. Hồ Chí Minh', @current_time);

-- Insert 5 Candidates (role_id = 2)
INSERT INTO [user] ([role_id], [status], [fullname], [email], [password], [phone_number], [address], [created_at])
VALUES
    (2, 'Active', N'Hoàng Thị Lan', 'lan.hoang.candidate@email.com', 'defaultpassword', '0398123456', N'22 Ngõ 15, Cầu Giấy, Hà Nội', @current_time),
    (2, 'Active', N'Bùi Đức Trung', 'trung.bui.candidate@email.com', 'defaultpassword', '0387654987', N'333 Pasteur, Quận 3, TP. Hồ Chí Minh', @current_time),
    (2, 'Active', N'Đặng Mai Phương', 'phuong.dang.candidate@email.com', 'defaultpassword', '0376543210', N'44 Trần Phú, Ba Đình, Hà Nội', @current_time),
    (2, 'Active', N'Ngô Gia Huy', 'huy.ngo.candidate@email.com', 'defaultpassword', '0365111222', N'55 Nguyễn Văn Linh, Thanh Khê, Đà Nẵng', @current_time),
    (2, 'Active', N'Trịnh Lan Anh', 'lananh.trinh.candidate@email.com', 'defaultpassword', '0354333444', N'66 Võ Văn Tần, Quận 3, TP. Hồ Chí Minh', @current_time);

-- Insert 5 HR Managers (role_id = 3)
INSERT INTO [user] ([role_id], [status], [fullname], [email], [password], [phone_number], [address], [created_at])
VALUES
    (3, 'Active', N'Lý Thuỳ Linh', 'hr.linh.ly@company.com', 'defaultpassword', '0868111333', N'77 Lý Thường Kiệt, Hoàn Kiếm, Hà Nội', @current_time),
    (3, 'Active', N'Đỗ Hùng Dũng', 'hr.dung.do@company.com', 'defaultpassword', '0869222444', N'88 Hai Bà Trưng, Quận 1, TP. Hồ Chí Minh', @current_time),
    (3, 'Active', N'Phan Thị Thanh', 'hr.thanh.phan@company.com', 'defaultpassword', '0867333555', N'99 Điện Biên Phủ, Bình Thạnh, TP. Hồ Chí Minh', @current_time),
    (3, 'Inactive', N'Chử Đức Minh', 'hr.minh.chu@company.com', 'defaultpassword', '0866444666', N'111 Hoàng Diệu, Hải Châu, Đà Nẵng', @current_time),
    (3, 'Active', N'Tạ Quang Huy', 'hr.huy.ta@company.com', 'defaultpassword', '0865555777', N'122 Tôn Đức Thắng, Đống Đa, Hà Nội', @current_time);
GO

-- =================================================================
-- INSERT DATA INTO 'location' TABLE
-- =================================================================
PRINT 'Inserting data into location table...';
INSERT INTO [location] ([province], [ward], [detail])
VALUES
    (N'Hà Nội', N'Quận Ba Đình', N'Khu vực trung tâm hành chính'),
    (N'Hà Nội', N'Quận Hoàn Kiếm', N'Khu vực phố cổ, trung tâm thương mại'),
    (N'Hà Nội', N'Quận Cầu Giấy', N'Khu vực tập trung nhiều tòa nhà văn phòng, IT'),
    (N'Hà Nội', N'Quận Đống Đa', N'Khu vực dân cư đông đúc, nhiều trường đại học'),
    (N'TP. Hồ Chí Minh', N'Quận 1', N'Trung tâm tài chính, kinh tế của thành phố'),
    (N'TP. Hồ Chí Minh', N'Quận 3', N'Khu vực tập trung nhiều văn phòng, lãnh sự quán'),
    (N'TP. Hồ Chí Minh', N'Quận 7', N'Khu đô thị mới Phú Mỹ Hưng, nhiều công ty nước ngoài'),
    (N'TP. Hồ Chí Minh', N'Thành phố Thủ Đức', N'Khu công nghệ cao, Làng đại học'),
    (N'Đà Nẵng', N'Quận Hải Châu', N'Trung tâm thành phố, gần sân bay'),
    (N'Đà Nẵng', N'Quận Sơn Trà', N'Khu vực du lịch, gần biển'),
    (N'Cần Thơ', N'Quận Ninh Kiều', N'Trung tâm kinh tế, văn hóa của Đồng bằng sông Cửu Long'),
    (N'Hải Phòng', N'Quận Hồng Bàng', N'Trung tâm thành phố cảng'),
    (N'Bình Dương', N'Thành phố Thủ Dầu Một', N'Trung tâm công nghiệp phía Nam'),
    (N'Bắc Ninh', N'Thành phố Bắc Ninh', N'Trung tâm công nghiệp điện tử phía Bắc');
GO

PRINT 'Data insertion script completed successfully.';
GO
