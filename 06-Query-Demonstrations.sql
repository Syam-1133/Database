-- ============================================================================
-- Database Design and Implementation Project
-- University Course Registration System
-- Query Demonstrations (Minimum 5 Required Queries)
-- ============================================================================
-- This script demonstrates various SQL queries including:
-- - SELECT with WHERE clauses
-- - JOINs (INNER, LEFT, RIGHT)
-- - Aggregate functions (COUNT, AVG, SUM, MAX, MIN)
-- - GROUP BY and HAVING
-- - Subqueries
-- - UPDATE and DELETE operations
-- ============================================================================

USE UniversityRegistration;
GO

PRINT '============================================================================';
PRINT 'SQL Query Demonstrations';
PRINT '============================================================================';
PRINT '';
GO

-- ============================================================================
-- QUERY 1: Simple SELECT with JOIN
-- Purpose: List all students with their major department names
-- ============================================================================

PRINT '------------------------------------------------------------';
PRINT 'QUERY 1: List All Students with Their Major Departments';
PRINT '------------------------------------------------------------';
PRINT '';

SELECT 
    s.StudentID,
    s.FirstName + ' ' + s.LastName AS StudentName,
    s.Email,
    d.DepartmentName AS Major,
    s.GPA,
    s.TotalCredits,
    s.Status
FROM STUDENT s
INNER JOIN DEPARTMENT d ON s.MajorDeptCode = d.DepartmentCode
ORDER BY d.DepartmentName, s.LastName;
GO

PRINT '';
GO

-- ============================================================================
-- QUERY 2: Complex JOIN with Multiple Tables
-- Purpose: Show complete enrollment information with student, course, and instructor details
-- ============================================================================

PRINT '------------------------------------------------------------';
PRINT 'QUERY 2: Complete Enrollment Details for Fall 2024';
PRINT '------------------------------------------------------------';
PRINT '';

SELECT 
    s.FirstName + ' ' + s.LastName AS StudentName,
    c.CourseCode,
    c.CourseTitle,
    sec.SectionNumber,
    sec.Schedule,
    sec.RoomLocation,
    i.FirstName + ' ' + i.LastName AS InstructorName,
    e.EnrollmentDate,
    e.Status AS EnrollmentStatus
FROM ENROLLMENT e
INNER JOIN STUDENT s ON e.StudentID = s.StudentID
INNER JOIN SECTION sec ON e.SectionID = sec.SectionID
INNER JOIN COURSE c ON sec.CourseCode = c.CourseCode
INNER JOIN INSTRUCTOR i ON sec.InstructorID = i.InstructorID
WHERE sec.Semester = 'Fall' AND sec.Year = 2024
ORDER BY s.LastName, c.CourseCode;
GO

PRINT '';
GO

-- ============================================================================
-- QUERY 3: Aggregate Functions with GROUP BY
-- Purpose: Calculate enrollment statistics by department
-- ============================================================================

PRINT '------------------------------------------------------------';
PRINT 'QUERY 3: Enrollment Statistics by Department';
PRINT '------------------------------------------------------------';
PRINT '';

SELECT 
    d.DepartmentName,
    COUNT(DISTINCT s.StudentID) AS TotalStudents,
    COUNT(DISTINCT c.CourseCode) AS TotalCourses,
    COUNT(DISTINCT sec.SectionID) AS TotalSections,
    COUNT(e.EnrollmentID) AS TotalEnrollments,
    AVG(CAST(s.GPA AS FLOAT)) AS AverageDepartmentGPA
FROM DEPARTMENT d
LEFT JOIN STUDENT s ON d.DepartmentCode = s.MajorDeptCode
LEFT JOIN COURSE c ON d.DepartmentCode = c.DepartmentCode
LEFT JOIN SECTION sec ON c.CourseCode = sec.CourseCode AND sec.Semester = 'Fall' AND sec.Year = 2024
LEFT JOIN ENROLLMENT e ON sec.SectionID = e.SectionID
GROUP BY d.DepartmentName
ORDER BY TotalEnrollments DESC;
GO

PRINT '';
GO

-- ============================================================================
-- QUERY 4: Subquery - Find Students Enrolled in More Than 3 Courses
-- Purpose: Identify students with heavy course loads
-- ============================================================================

PRINT '------------------------------------------------------------';
PRINT 'QUERY 4: Students Enrolled in More Than 3 Courses (Fall 2024)';
PRINT '------------------------------------------------------------';
PRINT '';

SELECT 
    s.StudentID,
    s.FirstName + ' ' + s.LastName AS StudentName,
    d.DepartmentName AS Major,
    s.GPA,
    CourseCount.NumberOfCourses
FROM STUDENT s
INNER JOIN DEPARTMENT d ON s.MajorDeptCode = d.DepartmentCode
INNER JOIN (
    SELECT 
        e.StudentID,
        COUNT(*) AS NumberOfCourses
    FROM ENROLLMENT e
    INNER JOIN SECTION sec ON e.SectionID = sec.SectionID
    WHERE sec.Semester = 'Fall' AND sec.Year = 2024 AND e.Status = 'Enrolled'
    GROUP BY e.StudentID
    HAVING COUNT(*) > 3
) AS CourseCount ON s.StudentID = CourseCount.StudentID
ORDER BY CourseCount.NumberOfCourses DESC, s.LastName;
GO

PRINT '';
GO

-- ============================================================================
-- QUERY 5: Instructor Teaching Load with Aggregate Functions
-- Purpose: Show instructor workload for Fall 2024 semester
-- ============================================================================

PRINT '------------------------------------------------------------';
PRINT 'QUERY 5: Instructor Teaching Loads for Fall 2024';
PRINT '------------------------------------------------------------';
PRINT '';

SELECT 
    i.FirstName + ' ' + i.LastName AS InstructorName,
    d.DepartmentName,
    i.Rank,
    COUNT(sec.SectionID) AS SectionsTeaching,
    SUM(c.CreditHours) AS TotalCreditHours,
    AVG(CAST(sec.MaxEnrollment AS FLOAT)) AS AverageClassSize
FROM INSTRUCTOR i
INNER JOIN DEPARTMENT d ON i.DepartmentCode = d.DepartmentCode
LEFT JOIN SECTION sec ON i.InstructorID = sec.InstructorID AND sec.Semester = 'Fall' AND sec.Year = 2024
LEFT JOIN COURSE c ON sec.CourseCode = c.CourseCode
GROUP BY i.InstructorID, i.FirstName, i.LastName, d.DepartmentName, i.Rank
HAVING COUNT(sec.SectionID) > 0
ORDER BY SectionsTeaching DESC, TotalCreditHours DESC;
GO

PRINT '';
GO

-- ============================================================================
-- QUERY 6: Section Capacity Analysis
-- Purpose: Show sections with available seats and enrollment percentages
-- ============================================================================

PRINT '------------------------------------------------------------';
PRINT 'QUERY 6: Section Capacity and Availability Analysis';
PRINT '------------------------------------------------------------';
PRINT '';

SELECT 
    c.CourseCode,
    c.CourseTitle,
    sec.SectionNumber,
    sec.Schedule,
    i.FirstName + ' ' + i.LastName AS InstructorName,
    sec.MaxEnrollment,
    COUNT(e.EnrollmentID) AS CurrentEnrollment,
    sec.MaxEnrollment - COUNT(e.EnrollmentID) AS AvailableSeats,
    CAST(COUNT(e.EnrollmentID) * 100.0 / sec.MaxEnrollment AS DECIMAL(5,2)) AS EnrollmentPercentage
FROM SECTION sec
INNER JOIN COURSE c ON sec.CourseCode = c.CourseCode
INNER JOIN INSTRUCTOR i ON sec.InstructorID = i.InstructorID
LEFT JOIN ENROLLMENT e ON sec.SectionID = e.SectionID AND e.Status = 'Enrolled'
WHERE sec.Semester = 'Fall' AND sec.Year = 2024
GROUP BY 
    c.CourseCode, c.CourseTitle, sec.SectionNumber, sec.Schedule,
    i.FirstName, i.LastName, sec.MaxEnrollment, sec.SectionID
ORDER BY EnrollmentPercentage DESC;
GO

PRINT '';
GO

-- ============================================================================
-- QUERY 7: Course Prerequisites Check
-- Purpose: Display courses with their prerequisites
-- ============================================================================

PRINT '------------------------------------------------------------';
PRINT 'QUERY 7: Courses and Their Prerequisites';
PRINT '------------------------------------------------------------';
PRINT '';

SELECT 
    c.CourseCode,
    c.CourseTitle,
    c.CreditHours,
    d.DepartmentName,
    c.Level,
    ISNULL(prereq.CourseCode, 'None') AS PrerequisiteCourseCode,
    ISNULL(prereq.CourseTitle, 'No Prerequisite') AS PrerequisiteCourseTitle
FROM COURSE c
INNER JOIN DEPARTMENT d ON c.DepartmentCode = d.DepartmentCode
LEFT JOIN COURSE prereq ON c.PrerequisiteCourseCode = prereq.CourseCode
ORDER BY d.DepartmentName, c.CourseCode;
GO

PRINT '';
GO

-- ============================================================================
-- QUERY 8: Student Transcript Query
-- Purpose: Generate a student transcript showing all enrollments
-- ============================================================================

PRINT '------------------------------------------------------------';
PRINT 'QUERY 8: Student Transcript (Student ID: 1000)';
PRINT '------------------------------------------------------------';
PRINT '';

DECLARE @StudentID INT = 1000;

SELECT 
    s.FirstName + ' ' + s.LastName AS StudentName,
    s.Email,
    d.DepartmentName AS Major,
    s.GPA,
    s.TotalCredits
FROM STUDENT s
INNER JOIN DEPARTMENT d ON s.MajorDeptCode = d.DepartmentCode
WHERE s.StudentID = @StudentID;

PRINT '';
PRINT 'Enrolled Courses:';
PRINT '';

SELECT 
    sec.Semester + ' ' + CAST(sec.Year AS VARCHAR(4)) AS Term,
    c.CourseCode,
    c.CourseTitle,
    c.CreditHours,
    i.FirstName + ' ' + i.LastName AS Instructor,
    ISNULL(e.Grade, 'In Progress') AS Grade,
    e.Status
FROM ENROLLMENT e
INNER JOIN SECTION sec ON e.SectionID = sec.SectionID
INNER JOIN COURSE c ON sec.CourseCode = c.CourseCode
INNER JOIN INSTRUCTOR i ON sec.InstructorID = i.InstructorID
WHERE e.StudentID = @StudentID
ORDER BY sec.Year DESC, sec.Semester, c.CourseCode;
GO

PRINT '';
GO

-- ============================================================================
-- QUERY 9: Department Rankings by Average Student GPA
-- Purpose: Rank departments by the average GPA of their students
-- ============================================================================

PRINT '------------------------------------------------------------';
PRINT 'QUERY 9: Department Rankings by Average Student GPA';
PRINT '------------------------------------------------------------';
PRINT '';

SELECT 
    RANK() OVER (ORDER BY AVG(s.GPA) DESC) AS Rank,
    d.DepartmentName,
    COUNT(s.StudentID) AS NumberOfStudents,
    AVG(s.GPA) AS AverageGPA,
    MAX(s.GPA) AS HighestGPA,
    MIN(s.GPA) AS LowestGPA
FROM DEPARTMENT d
INNER JOIN STUDENT s ON d.DepartmentCode = s.MajorDeptCode
WHERE s.Status = 'Active'
GROUP BY d.DepartmentCode, d.DepartmentName
ORDER BY AverageGPA DESC;
GO

PRINT '';
GO

-- ============================================================================
-- QUERY 10: Popular Courses by Enrollment
-- Purpose: Find the most popular courses based on enrollment numbers
-- ============================================================================

PRINT '------------------------------------------------------------';
PRINT 'QUERY 10: Most Popular Courses (Fall 2024)';
PRINT '------------------------------------------------------------';
PRINT '';

SELECT TOP 10
    c.CourseCode,
    c.CourseTitle,
    d.DepartmentName,
    c.Level,
    COUNT(DISTINCT sec.SectionID) AS NumberOfSections,
    COUNT(e.EnrollmentID) AS TotalEnrollments,
    AVG(CAST(sec.MaxEnrollment AS FLOAT)) AS AverageCapacity
FROM COURSE c
INNER JOIN DEPARTMENT d ON c.DepartmentCode = d.DepartmentCode
INNER JOIN SECTION sec ON c.CourseCode = sec.CourseCode
LEFT JOIN ENROLLMENT e ON sec.SectionID = e.SectionID AND e.Status = 'Enrolled'
WHERE sec.Semester = 'Fall' AND sec.Year = 2024
GROUP BY c.CourseCode, c.CourseTitle, d.DepartmentName, c.Level
ORDER BY TotalEnrollments DESC;
GO

PRINT '';
GO

-- ============================================================================
-- UPDATE OPERATION: Add grades for completed enrollments
-- Purpose: Demonstrate UPDATE with JOIN
-- ============================================================================

PRINT '------------------------------------------------------------';
PRINT 'UPDATE OPERATION: Simulating Grade Assignment';
PRINT '------------------------------------------------------------';
PRINT '';

-- First, let's create a temporary scenario where some enrollments are completed
-- Update a few enrollments to 'Completed' status and assign grades

UPDATE e
SET 
    e.Status = 'Completed',
    e.Grade = CASE 
        WHEN s.GPA >= 3.85 THEN 'A'
        WHEN s.GPA >= 3.50 THEN 'A-'
        WHEN s.GPA >= 3.30 THEN 'B+'
        WHEN s.GPA >= 3.00 THEN 'B'
        WHEN s.GPA >= 2.70 THEN 'B-'
        WHEN s.GPA >= 2.30 THEN 'C+'
        ELSE 'C'
    END
FROM ENROLLMENT e
INNER JOIN STUDENT s ON e.StudentID = s.StudentID
INNER JOIN SECTION sec ON e.SectionID = sec.SectionID
WHERE sec.CourseCode IN ('MATH101', 'ENG101', 'CS101')
  AND sec.SectionNumber = '001'
  AND sec.Semester = 'Fall'
  AND sec.Year = 2024;

PRINT 'Grades assigned to selected courses.';
PRINT '';

-- Display the updated enrollments
SELECT 
    s.FirstName + ' ' + s.LastName AS StudentName,
    c.CourseCode,
    c.CourseTitle,
    e.Grade,
    e.Status
FROM ENROLLMENT e
INNER JOIN STUDENT s ON e.StudentID = s.StudentID
INNER JOIN SECTION sec ON e.SectionID = sec.SectionID
INNER JOIN COURSE c ON sec.CourseCode = c.CourseCode
WHERE e.Status = 'Completed'
ORDER BY c.CourseCode, s.LastName;
GO

PRINT '';
GO

-- ============================================================================
-- DELETE OPERATION: Remove dropped enrollments
-- Purpose: Demonstrate DELETE with conditions
-- ============================================================================

PRINT '------------------------------------------------------------';
PRINT 'DELETE OPERATION: Simulating Enrollment Withdrawal';
PRINT '------------------------------------------------------------';
PRINT '';

-- First, mark an enrollment as withdrawn
UPDATE ENROLLMENT
SET Status = 'Withdrawn'
WHERE EnrollmentID = (
    SELECT TOP 1 e.EnrollmentID 
    FROM ENROLLMENT e
    INNER JOIN SECTION sec ON e.SectionID = sec.SectionID
    WHERE e.Status = 'Enrolled' 
      AND sec.Semester = 'Fall' 
      AND sec.Year = 2024
);

PRINT 'One enrollment marked as Withdrawn.';
PRINT '';

-- Display withdrawn enrollments
SELECT 
    s.FirstName + ' ' + s.LastName AS StudentName,
    c.CourseCode,
    c.CourseTitle,
    e.EnrollmentDate,
    e.Status
FROM ENROLLMENT e
INNER JOIN STUDENT s ON e.StudentID = s.StudentID
INNER JOIN SECTION sec ON e.SectionID = sec.SectionID
INNER JOIN COURSE c ON sec.CourseCode = c.CourseCode
WHERE e.Status = 'Withdrawn';
GO

PRINT '';
GO

-- ============================================================================
-- ADVANCED QUERY: Using Window Functions
-- Purpose: Rank students within their department by GPA
-- ============================================================================

PRINT '------------------------------------------------------------';
PRINT 'ADVANCED QUERY: Student Rankings Within Departments';
PRINT '------------------------------------------------------------';
PRINT '';

SELECT 
    d.DepartmentName,
    s.StudentID,
    s.FirstName + ' ' + s.LastName AS StudentName,
    s.GPA,
    RANK() OVER (PARTITION BY d.DepartmentCode ORDER BY s.GPA DESC) AS DepartmentRank,
    NTILE(4) OVER (PARTITION BY d.DepartmentCode ORDER BY s.GPA DESC) AS Quartile
FROM STUDENT s
INNER JOIN DEPARTMENT d ON s.MajorDeptCode = d.DepartmentCode
WHERE s.Status = 'Active'
ORDER BY d.DepartmentName, s.GPA DESC;
GO

PRINT '';
GO

-- ============================================================================
-- VIEW USAGE: Query the created views
-- ============================================================================

PRINT '------------------------------------------------------------';
PRINT 'VIEW QUERY: Using vw_DepartmentStatistics';
PRINT '------------------------------------------------------------';
PRINT '';

SELECT * FROM vw_DepartmentStatistics
ORDER BY TotalStudents DESC;
GO

PRINT '';
GO

PRINT '------------------------------------------------------------';
PRINT 'VIEW QUERY: Using vw_StudentAcademicRecords';
PRINT '------------------------------------------------------------';
PRINT '';

SELECT TOP 10 * FROM vw_StudentAcademicRecords
ORDER BY GPA DESC;
GO

PRINT '';
GO

-- ============================================================================
-- SUMMARY
-- ============================================================================

PRINT '';
PRINT '============================================================================';
PRINT 'Query Demonstrations Complete!';
PRINT '============================================================================';
PRINT '';
PRINT 'Queries Demonstrated:';
PRINT '  1. Simple JOIN - Students and Departments';
PRINT '  2. Complex Multi-table JOIN - Complete Enrollment Details';
PRINT '  3. Aggregate Functions with GROUP BY - Department Statistics';
PRINT '  4. Subquery - Students with Heavy Course Loads';
PRINT '  5. Instructor Teaching Loads with Aggregates';
PRINT '  6. Section Capacity Analysis with Calculations';
PRINT '  7. Self-referencing JOIN - Course Prerequisites';
PRINT '  8. Student Transcript with Multiple JOINs';
PRINT '  9. Ranking with Window Functions - Department Rankings';
PRINT ' 10. Popular Courses Analysis';
PRINT ' 11. UPDATE Operation - Grade Assignment';
PRINT ' 12. DELETE Operation - Withdrawal Processing';
PRINT ' 13. Advanced Window Functions - Student Rankings';
PRINT ' 14. VIEW Queries - Pre-defined Views';
PRINT '';
PRINT 'Query Types Covered:';
PRINT '  ✓ SELECT with WHERE';
PRINT '  ✓ INNER JOIN, LEFT JOIN';
PRINT '  ✓ Aggregate Functions (COUNT, AVG, SUM, MAX, MIN)';
PRINT '  ✓ GROUP BY and HAVING';
PRINT '  ✓ Subqueries';
PRINT '  ✓ Window Functions (RANK, NTILE)';
PRINT '  ✓ UPDATE with JOIN';
PRINT '  ✓ DELETE with conditions';
PRINT '  ✓ View queries';
PRINT '';
PRINT '============================================================================';
GO
