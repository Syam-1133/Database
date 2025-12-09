-- ============================================================================
-- Database Design and Implementation Project
-- University Course Registration System
-- SQL Server Database Implementation Script
-- ============================================================================
-- This script creates the complete database schema including:
-- - Database creation
-- - Tables with primary keys, foreign keys, and constraints
-- - Indexes for performance optimization
-- - Views for common queries
-- ============================================================================

-- Drop database if exists (for clean testing)
IF EXISTS (SELECT name FROM sys.databases WHERE name = 'UniversityRegistration')
BEGIN
    ALTER DATABASE UniversityRegistration SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE UniversityRegistration;
END
GO

-- Create new database
CREATE DATABASE UniversityRegistration;
GO

-- Use the new database
USE UniversityRegistration;
GO

PRINT 'Database UniversityRegistration created successfully.';
GO

-- ============================================================================
-- TABLE CREATION
-- ============================================================================

-- ----------------------------------------------------------------------------
-- 1. DEPARTMENT Table
-- ----------------------------------------------------------------------------
PRINT 'Creating DEPARTMENT table...';
GO

CREATE TABLE DEPARTMENT (
    DepartmentCode VARCHAR(10) PRIMARY KEY,
    DepartmentName VARCHAR(100) NOT NULL UNIQUE,
    Building VARCHAR(50),
    HeadInstructorID INT NULL,  -- Will be added as FK after INSTRUCTOR table is created
    Phone VARCHAR(15),
    Email VARCHAR(100),
    CONSTRAINT CHK_Department_Email CHECK (Email LIKE '%@%')
);
GO

PRINT 'DEPARTMENT table created successfully.';
GO

-- ----------------------------------------------------------------------------
-- 2. INSTRUCTOR Table
-- ----------------------------------------------------------------------------
PRINT 'Creating INSTRUCTOR table...';
GO

CREATE TABLE INSTRUCTOR (
    InstructorID INT PRIMARY KEY IDENTITY(1,1),
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    Phone VARCHAR(15),
    DepartmentCode VARCHAR(10) NOT NULL,
    OfficeLocation VARCHAR(50),
    HireDate DATE NOT NULL DEFAULT GETDATE(),
    Rank VARCHAR(30) NOT NULL,
    CONSTRAINT FK_Instructor_Department 
        FOREIGN KEY (DepartmentCode) REFERENCES DEPARTMENT(DepartmentCode)
        ON UPDATE CASCADE
        ON DELETE NO ACTION,
    CONSTRAINT CHK_Instructor_Email CHECK (Email LIKE '%@%'),
    CONSTRAINT CHK_Instructor_Rank CHECK (
        Rank IN ('Assistant Professor', 'Associate Professor', 'Professor', 'Lecturer', 'Adjunct')
    )
);
GO

PRINT 'INSTRUCTOR table created successfully.';
GO

-- Add foreign key constraint for Department Head (now that INSTRUCTOR exists)
PRINT 'Adding HeadInstructorID foreign key to DEPARTMENT...';
GO

ALTER TABLE DEPARTMENT
ADD CONSTRAINT FK_Department_HeadInstructor
    FOREIGN KEY (HeadInstructorID) REFERENCES INSTRUCTOR(InstructorID)
    ON UPDATE CASCADE
    ON DELETE SET NULL;
GO

-- ----------------------------------------------------------------------------
-- 3. STUDENT Table
-- ----------------------------------------------------------------------------
PRINT 'Creating STUDENT table...';
GO

CREATE TABLE STUDENT (
    StudentID INT PRIMARY KEY IDENTITY(1000,1),  -- Start from 1000
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    Phone VARCHAR(15),
    DateOfBirth DATE,
    EnrollmentDate DATE NOT NULL DEFAULT GETDATE(),
    MajorDeptCode VARCHAR(10) NOT NULL,
    Status VARCHAR(20) NOT NULL DEFAULT 'Active',
    GPA DECIMAL(3,2) DEFAULT 0.00,
    TotalCredits INT DEFAULT 0,
    CONSTRAINT FK_Student_Department 
        FOREIGN KEY (MajorDeptCode) REFERENCES DEPARTMENT(DepartmentCode)
        ON UPDATE CASCADE
        ON DELETE NO ACTION,
    CONSTRAINT CHK_Student_Email CHECK (Email LIKE '%@%'),
    CONSTRAINT CHK_Student_Status CHECK (
        Status IN ('Active', 'Graduated', 'On Leave', 'Withdrawn')
    ),
    CONSTRAINT CHK_Student_GPA CHECK (GPA >= 0.00 AND GPA <= 4.00),
    CONSTRAINT CHK_Student_Credits CHECK (TotalCredits >= 0)
);
GO

PRINT 'STUDENT table created successfully.';
GO

-- ----------------------------------------------------------------------------
-- 4. COURSE Table
-- ----------------------------------------------------------------------------
PRINT 'Creating COURSE table...';
GO

CREATE TABLE COURSE (
    CourseCode VARCHAR(10) PRIMARY KEY,
    CourseTitle VARCHAR(200) NOT NULL,
    Description TEXT,
    CreditHours INT NOT NULL,
    DepartmentCode VARCHAR(10) NOT NULL,
    Level VARCHAR(20) NOT NULL,
    PrerequisiteCourseCode VARCHAR(10) NULL,
    CONSTRAINT FK_Course_Department 
        FOREIGN KEY (DepartmentCode) REFERENCES DEPARTMENT(DepartmentCode)
        ON UPDATE CASCADE
        ON DELETE NO ACTION,
    CONSTRAINT FK_Course_Prerequisite 
        FOREIGN KEY (PrerequisiteCourseCode) REFERENCES COURSE(CourseCode)
        ON UPDATE CASCADE
        ON DELETE SET NULL,
    CONSTRAINT CHK_Course_CreditHours CHECK (CreditHours BETWEEN 1 AND 6),
    CONSTRAINT CHK_Course_Level CHECK (Level IN ('Undergraduate', 'Graduate'))
);
GO

PRINT 'COURSE table created successfully.';
GO

-- ----------------------------------------------------------------------------
-- 5. SECTION Table
-- ----------------------------------------------------------------------------
PRINT 'Creating SECTION table...';
GO

CREATE TABLE SECTION (
    SectionID INT PRIMARY KEY IDENTITY(1,1),
    CourseCode VARCHAR(10) NOT NULL,
    SectionNumber VARCHAR(5) NOT NULL,
    Semester VARCHAR(10) NOT NULL,
    Year INT NOT NULL,
    Schedule VARCHAR(50),
    RoomLocation VARCHAR(50),
    MaxEnrollment INT NOT NULL,
    InstructorID INT NOT NULL,
    CONSTRAINT FK_Section_Course 
        FOREIGN KEY (CourseCode) REFERENCES COURSE(CourseCode)
        ON UPDATE CASCADE
        ON DELETE NO ACTION,
    CONSTRAINT FK_Section_Instructor 
        FOREIGN KEY (InstructorID) REFERENCES INSTRUCTOR(InstructorID)
        ON UPDATE CASCADE
        ON DELETE NO ACTION,
    CONSTRAINT CHK_Section_Semester CHECK (Semester IN ('Fall', 'Spring', 'Summer')),
    CONSTRAINT CHK_Section_Year CHECK (Year >= 2000),
    CONSTRAINT CHK_Section_MaxEnrollment CHECK (MaxEnrollment > 0),
    CONSTRAINT UQ_Section_Unique UNIQUE (CourseCode, SectionNumber, Semester, Year)
);
GO

PRINT 'SECTION table created successfully.';
GO

-- ----------------------------------------------------------------------------
-- 6. ENROLLMENT Table
-- ----------------------------------------------------------------------------
PRINT 'Creating ENROLLMENT table...';
GO

CREATE TABLE ENROLLMENT (
    EnrollmentID INT PRIMARY KEY IDENTITY(1,1),
    StudentID INT NOT NULL,
    SectionID INT NOT NULL,
    EnrollmentDate DATE NOT NULL DEFAULT GETDATE(),
    Grade VARCHAR(3) NULL,
    Status VARCHAR(20) NOT NULL DEFAULT 'Enrolled',
    CONSTRAINT FK_Enrollment_Student 
        FOREIGN KEY (StudentID) REFERENCES STUDENT(StudentID)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT FK_Enrollment_Section 
        FOREIGN KEY (SectionID) REFERENCES SECTION(SectionID)
        ON UPDATE CASCADE
        ON DELETE NO ACTION,
    CONSTRAINT CHK_Enrollment_Status CHECK (
        Status IN ('Enrolled', 'Completed', 'Dropped', 'Withdrawn')
    ),
    CONSTRAINT CHK_Enrollment_Grade CHECK (
        Grade IN ('A', 'A-', 'B+', 'B', 'B-', 'C+', 'C', 'C-', 'D+', 'D', 'D-', 'F', 'W', 'I', 'P') 
        OR Grade IS NULL
    ),
    CONSTRAINT UQ_Enrollment_Unique UNIQUE (StudentID, SectionID)
);
GO

PRINT 'ENROLLMENT table created successfully.';
GO

-- ============================================================================
-- INDEX CREATION FOR PERFORMANCE OPTIMIZATION
-- ============================================================================

PRINT 'Creating indexes for performance optimization...';
GO

-- Indexes on STUDENT
CREATE INDEX idx_student_major ON STUDENT(MajorDeptCode);
CREATE INDEX idx_student_status ON STUDENT(Status);
GO

-- Indexes on INSTRUCTOR
CREATE INDEX idx_instructor_dept ON INSTRUCTOR(DepartmentCode);
CREATE INDEX idx_instructor_rank ON INSTRUCTOR(Rank);
GO

-- Indexes on COURSE
CREATE INDEX idx_course_dept ON COURSE(DepartmentCode);
CREATE INDEX idx_course_level ON COURSE(Level);
GO

-- Indexes on SECTION
CREATE INDEX idx_section_course ON SECTION(CourseCode);
CREATE INDEX idx_section_instructor ON SECTION(InstructorID);
CREATE INDEX idx_section_semester ON SECTION(Semester, Year);
GO

-- Indexes on ENROLLMENT
CREATE INDEX idx_enrollment_student ON ENROLLMENT(StudentID);
CREATE INDEX idx_enrollment_section ON ENROLLMENT(SectionID);
CREATE INDEX idx_enrollment_status ON ENROLLMENT(Status);
GO

PRINT 'Indexes created successfully.';
GO

-- ============================================================================
-- VIEW CREATION FOR COMMON QUERIES
-- ============================================================================

PRINT 'Creating views for common queries...';
GO

-- ----------------------------------------------------------------------------
-- View: Current Enrollments with Details
-- ----------------------------------------------------------------------------
CREATE VIEW vw_CurrentEnrollments AS
SELECT 
    e.EnrollmentID,
    s.StudentID,
    s.FirstName + ' ' + s.LastName AS StudentName,
    s.Email AS StudentEmail,
    c.CourseCode,
    c.CourseTitle,
    sec.SectionNumber,
    sec.Semester,
    sec.Year,
    sec.Schedule,
    sec.RoomLocation,
    i.FirstName + ' ' + i.LastName AS InstructorName,
    e.EnrollmentDate,
    e.Grade,
    e.Status AS EnrollmentStatus
FROM ENROLLMENT e
INNER JOIN STUDENT s ON e.StudentID = s.StudentID
INNER JOIN SECTION sec ON e.SectionID = sec.SectionID
INNER JOIN COURSE c ON sec.CourseCode = c.CourseCode
INNER JOIN INSTRUCTOR i ON sec.InstructorID = i.InstructorID;
GO

-- ----------------------------------------------------------------------------
-- View: Section Enrollment Counts
-- ----------------------------------------------------------------------------
CREATE VIEW vw_SectionEnrollmentCounts AS
SELECT 
    sec.SectionID,
    c.CourseCode,
    c.CourseTitle,
    sec.SectionNumber,
    sec.Semester,
    sec.Year,
    i.FirstName + ' ' + i.LastName AS InstructorName,
    sec.MaxEnrollment,
    COUNT(e.EnrollmentID) AS CurrentEnrollment,
    sec.MaxEnrollment - COUNT(e.EnrollmentID) AS AvailableSeats
FROM SECTION sec
INNER JOIN COURSE c ON sec.CourseCode = c.CourseCode
INNER JOIN INSTRUCTOR i ON sec.InstructorID = i.InstructorID
LEFT JOIN ENROLLMENT e ON sec.SectionID = e.SectionID AND e.Status = 'Enrolled'
GROUP BY 
    sec.SectionID, c.CourseCode, c.CourseTitle, sec.SectionNumber,
    sec.Semester, sec.Year, i.FirstName, i.LastName, sec.MaxEnrollment;
GO

-- ----------------------------------------------------------------------------
-- View: Instructor Teaching Loads
-- ----------------------------------------------------------------------------
CREATE VIEW vw_InstructorTeachingLoads AS
SELECT 
    i.InstructorID,
    i.FirstName + ' ' + i.LastName AS InstructorName,
    i.Rank,
    d.DepartmentName,
    sec.Semester,
    sec.Year,
    COUNT(sec.SectionID) AS SectionsTeaching,
    SUM(c.CreditHours) AS TotalCreditHours
FROM INSTRUCTOR i
INNER JOIN DEPARTMENT d ON i.DepartmentCode = d.DepartmentCode
LEFT JOIN SECTION sec ON i.InstructorID = sec.InstructorID
LEFT JOIN COURSE c ON sec.CourseCode = c.CourseCode
GROUP BY 
    i.InstructorID, i.FirstName, i.LastName, i.Rank,
    d.DepartmentName, sec.Semester, sec.Year;
GO

-- ----------------------------------------------------------------------------
-- View: Student Academic Records
-- ----------------------------------------------------------------------------
CREATE VIEW vw_StudentAcademicRecords AS
SELECT 
    s.StudentID,
    s.FirstName + ' ' + s.LastName AS StudentName,
    s.Email,
    d.DepartmentName AS Major,
    s.Status,
    s.GPA,
    s.TotalCredits,
    s.EnrollmentDate,
    COUNT(DISTINCT CASE WHEN e.Status = 'Enrolled' THEN e.EnrollmentID END) AS CurrentEnrollments,
    COUNT(DISTINCT CASE WHEN e.Status = 'Completed' THEN e.EnrollmentID END) AS CompletedCourses
FROM STUDENT s
INNER JOIN DEPARTMENT d ON s.MajorDeptCode = d.DepartmentCode
LEFT JOIN ENROLLMENT e ON s.StudentID = e.StudentID
GROUP BY 
    s.StudentID, s.FirstName, s.LastName, s.Email,
    d.DepartmentName, s.Status, s.GPA, s.TotalCredits, s.EnrollmentDate;
GO

-- ----------------------------------------------------------------------------
-- View: Department Statistics
-- ----------------------------------------------------------------------------
CREATE VIEW vw_DepartmentStatistics AS
SELECT 
    d.DepartmentCode,
    d.DepartmentName,
    d.Building,
    COUNT(DISTINCT s.StudentID) AS TotalStudents,
    COUNT(DISTINCT i.InstructorID) AS TotalInstructors,
    COUNT(DISTINCT c.CourseCode) AS TotalCourses,
    COUNT(DISTINCT sec.SectionID) AS TotalSections
FROM DEPARTMENT d
LEFT JOIN STUDENT s ON d.DepartmentCode = s.MajorDeptCode
LEFT JOIN INSTRUCTOR i ON d.DepartmentCode = i.DepartmentCode
LEFT JOIN COURSE c ON d.DepartmentCode = c.DepartmentCode
LEFT JOIN SECTION sec ON c.CourseCode = sec.CourseCode
GROUP BY d.DepartmentCode, d.DepartmentName, d.Building;
GO

PRINT 'Views created successfully.';
GO

-- ============================================================================
-- SUMMARY
-- ============================================================================

PRINT '';
PRINT '============================================================================';
PRINT 'Database Implementation Complete!';
PRINT '============================================================================';
PRINT '';
PRINT 'Tables Created:';
PRINT '  1. DEPARTMENT';
PRINT '  2. INSTRUCTOR';
PRINT '  3. STUDENT';
PRINT '  4. COURSE';
PRINT '  5. SECTION';
PRINT '  6. ENROLLMENT';
PRINT '';
PRINT 'Views Created:';
PRINT '  1. vw_CurrentEnrollments';
PRINT '  2. vw_SectionEnrollmentCounts';
PRINT '  3. vw_InstructorTeachingLoads';
PRINT '  4. vw_StudentAcademicRecords';
PRINT '  5. vw_DepartmentStatistics';
PRINT '';
PRINT 'Next Steps:';
PRINT '  - Execute 05-Sample-Data.sql to insert sample data';
PRINT '  - Execute 06-Query-Demonstrations.sql to test queries';
PRINT '';
PRINT '============================================================================';
GO
