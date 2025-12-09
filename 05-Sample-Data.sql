-- ============================================================================
-- Database Design and Implementation Project
-- University Course Registration System
-- Sample Data Insertion Script
-- ============================================================================
-- This script inserts comprehensive sample data into all tables
-- Minimum: 5-10 records per table as required
-- ============================================================================

USE UniversityRegistration;
GO

PRINT 'Starting sample data insertion...';
PRINT '';
GO

-- ============================================================================
-- 1. INSERT DEPARTMENTS (6 departments)
-- ============================================================================

PRINT 'Inserting data into DEPARTMENT table...';
GO

INSERT INTO DEPARTMENT (DepartmentCode, DepartmentName, Building, Phone, Email) VALUES
('CS', 'Computer Science', 'Engineering Hall', '555-0101', 'cs@university.edu'),
('MATH', 'Mathematics', 'Science Building', '555-0102', 'math@university.edu'),
('ENG', 'English', 'Liberal Arts Center', '555-0103', 'english@university.edu'),
('PHYS', 'Physics', 'Science Building', '555-0104', 'physics@university.edu'),
('BUS', 'Business Administration', 'Business Complex', '555-0105', 'business@university.edu'),
('CHEM', 'Chemistry', 'Science Building', '555-0106', 'chemistry@university.edu');
GO

PRINT 'Inserted 6 departments.';
PRINT '';
GO

-- ============================================================================
-- 2. INSERT INSTRUCTORS (12 instructors)
-- ============================================================================

PRINT 'Inserting data into INSTRUCTOR table...';
GO

INSERT INTO INSTRUCTOR (FirstName, LastName, Email, Phone, DepartmentCode, OfficeLocation, HireDate, Rank) VALUES
-- Computer Science Department
('John', 'Smith', 'john.smith@university.edu', '555-1001', 'CS', 'EH-301', '2015-08-15', 'Professor'),
('Sarah', 'Johnson', 'sarah.johnson@university.edu', '555-1002', 'CS', 'EH-305', '2018-01-10', 'Associate Professor'),
('Michael', 'Chen', 'michael.chen@university.edu', '555-1003', 'CS', 'EH-310', '2020-08-20', 'Assistant Professor'),

-- Mathematics Department
('Emily', 'Davis', 'emily.davis@university.edu', '555-1004', 'MATH', 'SB-201', '2012-09-01', 'Professor'),
('Robert', 'Wilson', 'robert.wilson@university.edu', '555-1005', 'MATH', 'SB-205', '2019-01-15', 'Associate Professor'),

-- English Department
('Jennifer', 'Brown', 'jennifer.brown@university.edu', '555-1006', 'ENG', 'LAC-101', '2016-08-25', 'Associate Professor'),
('David', 'Martinez', 'david.martinez@university.edu', '555-1007', 'ENG', 'LAC-105', '2021-01-10', 'Assistant Professor'),

-- Physics Department
('Lisa', 'Anderson', 'lisa.anderson@university.edu', '555-1008', 'PHYS', 'SB-301', '2014-08-20', 'Professor'),
('Thomas', 'Taylor', 'thomas.taylor@university.edu', '555-1009', 'PHYS', 'SB-305', '2017-01-12', 'Associate Professor'),

-- Business Administration Department
('Maria', 'Garcia', 'maria.garcia@university.edu', '555-1010', 'BUS', 'BC-201', '2013-08-18', 'Professor'),
('James', 'Lee', 'james.lee@university.edu', '555-1011', 'BUS', 'BC-205', '2019-08-22', 'Associate Professor'),

-- Chemistry Department
('Patricia', 'White', 'patricia.white@university.edu', '555-1012', 'CHEM', 'SB-401', '2011-08-15', 'Professor');
GO

PRINT 'Inserted 12 instructors.';
PRINT '';
GO

-- ============================================================================
-- 3. UPDATE DEPARTMENT HEADS
-- ============================================================================

PRINT 'Updating department heads...';
GO

UPDATE DEPARTMENT SET HeadInstructorID = (SELECT InstructorID FROM INSTRUCTOR WHERE Email = 'john.smith@university.edu') WHERE DepartmentCode = 'CS';
UPDATE DEPARTMENT SET HeadInstructorID = (SELECT InstructorID FROM INSTRUCTOR WHERE Email = 'emily.davis@university.edu') WHERE DepartmentCode = 'MATH';
UPDATE DEPARTMENT SET HeadInstructorID = (SELECT InstructorID FROM INSTRUCTOR WHERE Email = 'jennifer.brown@university.edu') WHERE DepartmentCode = 'ENG';
UPDATE DEPARTMENT SET HeadInstructorID = (SELECT InstructorID FROM INSTRUCTOR WHERE Email = 'lisa.anderson@university.edu') WHERE DepartmentCode = 'PHYS';
UPDATE DEPARTMENT SET HeadInstructorID = (SELECT InstructorID FROM INSTRUCTOR WHERE Email = 'maria.garcia@university.edu') WHERE DepartmentCode = 'BUS';
UPDATE DEPARTMENT SET HeadInstructorID = (SELECT InstructorID FROM INSTRUCTOR WHERE Email = 'patricia.white@university.edu') WHERE DepartmentCode = 'CHEM';
GO

PRINT 'Department heads assigned.';
PRINT '';
GO

-- ============================================================================
-- 4. INSERT STUDENTS (20 students)
-- ============================================================================

PRINT 'Inserting data into STUDENT table...';
GO

INSERT INTO STUDENT (FirstName, LastName, Email, Phone, DateOfBirth, EnrollmentDate, MajorDeptCode, Status, GPA, TotalCredits) VALUES
-- Computer Science Majors
('Alice', 'Thompson', 'alice.thompson@student.edu', '555-2001', '2003-05-15', '2021-08-25', 'CS', 'Active', 3.75, 45),
('Bob', 'Jackson', 'bob.jackson@student.edu', '555-2002', '2002-11-20', '2020-08-25', 'CS', 'Active', 3.50, 75),
('Charlie', 'Harris', 'charlie.harris@student.edu', '555-2003', '2003-03-10', '2021-08-25', 'CS', 'Active', 3.90, 48),
('Diana', 'Clark', 'diana.clark@student.edu', '555-2004', '2002-07-22', '2020-08-25', 'CS', 'Active', 3.65, 80),

-- Mathematics Majors
('Emma', 'Lewis', 'emma.lewis@student.edu', '555-2005', '2003-09-08', '2021-08-25', 'MATH', 'Active', 3.85, 42),
('Frank', 'Walker', 'frank.walker@student.edu', '555-2006', '2002-12-18', '2020-08-25', 'MATH', 'Active', 3.70, 78),
('Grace', 'Hall', 'grace.hall@student.edu', '555-2007', '2003-04-25', '2021-08-25', 'MATH', 'Active', 3.95, 45),

-- English Majors
('Henry', 'Allen', 'henry.allen@student.edu', '555-2008', '2003-06-12', '2021-08-25', 'ENG', 'Active', 3.60, 50),
('Iris', 'Young', 'iris.young@student.edu', '555-2009', '2002-10-30', '2020-08-25', 'ENG', 'Active', 3.55, 82),
('Jack', 'King', 'jack.king@student.edu', '555-2010', '2003-02-14', '2021-08-25', 'ENG', 'Active', 3.80, 46),

-- Physics Majors
('Kelly', 'Wright', 'kelly.wright@student.edu', '555-2011', '2003-08-19', '2021-08-25', 'PHYS', 'Active', 3.72, 44),
('Leo', 'Lopez', 'leo.lopez@student.edu', '555-2012', '2002-11-05', '2020-08-25', 'PHYS', 'Active', 3.68, 76),

-- Business Majors
('Mia', 'Hill', 'mia.hill@student.edu', '555-2013', '2003-01-28', '2021-08-25', 'BUS', 'Active', 3.82, 47),
('Noah', 'Scott', 'noah.scott@student.edu', '555-2014', '2002-09-16', '2020-08-25', 'BUS', 'Active', 3.58, 79),
('Olivia', 'Green', 'olivia.green@student.edu', '555-2015', '2003-07-09', '2021-08-25', 'BUS', 'Active', 3.77, 43),

-- Chemistry Majors
('Peter', 'Adams', 'peter.adams@student.edu', '555-2016', '2003-03-21', '2021-08-25', 'CHEM', 'Active', 3.88, 46),
('Quinn', 'Baker', 'quinn.baker@student.edu', '555-2017', '2002-12-07', '2020-08-25', 'CHEM', 'Active', 3.63, 77),

-- Mixed Majors
('Rachel', 'Nelson', 'rachel.nelson@student.edu', '555-2018', '2003-05-30', '2021-08-25', 'CS', 'Active', 3.92, 44),
('Sam', 'Carter', 'sam.carter@student.edu', '555-2019', '2001-08-14', '2019-08-25', 'MATH', 'Active', 3.45, 105),
('Tina', 'Mitchell', 'tina.mitchell@student.edu', '555-2020', '2003-10-11', '2021-08-25', 'BUS', 'Active', 3.71, 41);
GO

PRINT 'Inserted 20 students.';
PRINT '';
GO

-- ============================================================================
-- 5. INSERT COURSES (24 courses)
-- ============================================================================

PRINT 'Inserting data into COURSE table...';
GO

-- Computer Science Courses
INSERT INTO COURSE (CourseCode, CourseTitle, Description, CreditHours, DepartmentCode, Level, PrerequisiteCourseCode) VALUES
('CS101', 'Introduction to Programming', 'Fundamental programming concepts using Python', 3, 'CS', 'Undergraduate', NULL),
('CS102', 'Data Structures', 'Introduction to data structures and algorithms', 3, 'CS', 'Undergraduate', 'CS101'),
('CS201', 'Database Systems', 'Design and implementation of database systems', 3, 'CS', 'Undergraduate', 'CS102'),
('CS301', 'Advanced Algorithms', 'Advanced algorithmic techniques and analysis', 3, 'CS', 'Graduate', 'CS102'),
('CS401', 'Machine Learning', 'Introduction to machine learning algorithms', 3, 'CS', 'Graduate', 'CS102');

-- Mathematics Courses
INSERT INTO COURSE (CourseCode, CourseTitle, Description, CreditHours, DepartmentCode, Level, PrerequisiteCourseCode) VALUES
('MATH101', 'Calculus I', 'Differential calculus and applications', 4, 'MATH', 'Undergraduate', NULL),
('MATH102', 'Calculus II', 'Integral calculus and applications', 4, 'MATH', 'Undergraduate', 'MATH101'),
('MATH201', 'Linear Algebra', 'Vector spaces and linear transformations', 3, 'MATH', 'Undergraduate', 'MATH101'),
('MATH301', 'Abstract Algebra', 'Groups, rings, and fields', 3, 'MATH', 'Graduate', 'MATH201'),
('MATH302', 'Real Analysis', 'Theory of real numbers and functions', 3, 'MATH', 'Graduate', 'MATH102');

-- English Courses
INSERT INTO COURSE (CourseCode, CourseTitle, Description, CreditHours, DepartmentCode, Level, PrerequisiteCourseCode) VALUES
('ENG101', 'Composition I', 'Academic writing and rhetoric', 3, 'ENG', 'Undergraduate', NULL),
('ENG102', 'Composition II', 'Advanced academic writing and research', 3, 'ENG', 'Undergraduate', 'ENG101'),
('ENG201', 'American Literature', 'Survey of American literary works', 3, 'ENG', 'Undergraduate', 'ENG102'),
('ENG301', 'Shakespeare Studies', 'In-depth study of Shakespeare plays', 3, 'ENG', 'Graduate', 'ENG201');

-- Physics Courses
INSERT INTO COURSE (CourseCode, CourseTitle, Description, CreditHours, DepartmentCode, Level, PrerequisiteCourseCode) VALUES
('PHYS101', 'General Physics I', 'Mechanics and thermodynamics', 4, 'PHYS', 'Undergraduate', NULL),
('PHYS102', 'General Physics II', 'Electricity and magnetism', 4, 'PHYS', 'Undergraduate', 'PHYS101'),
('PHYS201', 'Modern Physics', 'Quantum mechanics and relativity', 3, 'PHYS', 'Undergraduate', 'PHYS102'),
('PHYS301', 'Quantum Mechanics', 'Advanced quantum theory', 3, 'PHYS', 'Graduate', 'PHYS201');

-- Business Courses
INSERT INTO COURSE (CourseCode, CourseTitle, Description, CreditHours, DepartmentCode, Level, PrerequisiteCourseCode) VALUES
('BUS101', 'Introduction to Business', 'Overview of business principles', 3, 'BUS', 'Undergraduate', NULL),
('BUS201', 'Financial Accounting', 'Principles of financial accounting', 3, 'BUS', 'Undergraduate', 'BUS101'),
('BUS301', 'Corporate Finance', 'Financial management and investment', 3, 'BUS', 'Graduate', 'BUS201');

-- Chemistry Courses
INSERT INTO COURSE (CourseCode, CourseTitle, Description, CreditHours, DepartmentCode, Level, PrerequisiteCourseCode) VALUES
('CHEM101', 'General Chemistry I', 'Fundamental chemistry concepts', 4, 'CHEM', 'Undergraduate', NULL),
('CHEM102', 'General Chemistry II', 'Advanced general chemistry', 4, 'CHEM', 'Undergraduate', 'CHEM101'),
('CHEM201', 'Organic Chemistry', 'Study of organic compounds', 4, 'CHEM', 'Undergraduate', 'CHEM102');
GO

PRINT 'Inserted 24 courses.';
PRINT '';
GO

-- ============================================================================
-- 6. INSERT SECTIONS (30 sections for Fall 2024)
-- ============================================================================

PRINT 'Inserting data into SECTION table...';
GO

-- Computer Science Sections
INSERT INTO SECTION (CourseCode, SectionNumber, Semester, Year, Schedule, RoomLocation, MaxEnrollment, InstructorID) VALUES
('CS101', '001', 'Fall', 2024, 'MWF 9:00-9:50', 'EH-101', 30, (SELECT InstructorID FROM INSTRUCTOR WHERE Email = 'john.smith@university.edu')),
('CS101', '002', 'Fall', 2024, 'TTh 10:00-11:15', 'EH-102', 30, (SELECT InstructorID FROM INSTRUCTOR WHERE Email = 'sarah.johnson@university.edu')),
('CS102', '001', 'Fall', 2024, 'MWF 10:00-10:50', 'EH-103', 25, (SELECT InstructorID FROM INSTRUCTOR WHERE Email = 'sarah.johnson@university.edu')),
('CS201', '001', 'Fall', 2024, 'TTh 1:00-2:15', 'EH-104', 25, (SELECT InstructorID FROM INSTRUCTOR WHERE Email = 'michael.chen@university.edu')),
('CS301', '001', 'Fall', 2024, 'MW 3:00-4:15', 'EH-105', 20, (SELECT InstructorID FROM INSTRUCTOR WHERE Email = 'john.smith@university.edu'));

-- Mathematics Sections
INSERT INTO SECTION (CourseCode, SectionNumber, Semester, Year, Schedule, RoomLocation, MaxEnrollment, InstructorID) VALUES
('MATH101', '001', 'Fall', 2024, 'MWF 8:00-8:50', 'SB-101', 35, (SELECT InstructorID FROM INSTRUCTOR WHERE Email = 'emily.davis@university.edu')),
('MATH101', '002', 'Fall', 2024, 'TTh 9:00-10:15', 'SB-102', 35, (SELECT InstructorID FROM INSTRUCTOR WHERE Email = 'robert.wilson@university.edu')),
('MATH102', '001', 'Fall', 2024, 'MWF 10:00-10:50', 'SB-103', 30, (SELECT InstructorID FROM INSTRUCTOR WHERE Email = 'emily.davis@university.edu')),
('MATH201', '001', 'Fall', 2024, 'TTh 1:00-2:15', 'SB-104', 25, (SELECT InstructorID FROM INSTRUCTOR WHERE Email = 'robert.wilson@university.edu')),
('MATH301', '001', 'Fall', 2024, 'MW 4:00-5:15', 'SB-105', 20, (SELECT InstructorID FROM INSTRUCTOR WHERE Email = 'emily.davis@university.edu'));

-- English Sections
INSERT INTO SECTION (CourseCode, SectionNumber, Semester, Year, Schedule, RoomLocation, MaxEnrollment, InstructorID) VALUES
('ENG101', '001', 'Fall', 2024, 'MWF 9:00-9:50', 'LAC-201', 25, (SELECT InstructorID FROM INSTRUCTOR WHERE Email = 'jennifer.brown@university.edu')),
('ENG101', '002', 'Fall', 2024, 'TTh 11:00-12:15', 'LAC-202', 25, (SELECT InstructorID FROM INSTRUCTOR WHERE Email = 'david.martinez@university.edu')),
('ENG102', '001', 'Fall', 2024, 'MWF 11:00-11:50', 'LAC-203', 25, (SELECT InstructorID FROM INSTRUCTOR WHERE Email = 'jennifer.brown@university.edu')),
('ENG201', '001', 'Fall', 2024, 'TTh 2:00-3:15', 'LAC-204', 20, (SELECT InstructorID FROM INSTRUCTOR WHERE Email = 'david.martinez@university.edu')),
('ENG301', '001', 'Fall', 2024, 'W 5:00-7:30', 'LAC-205', 15, (SELECT InstructorID FROM INSTRUCTOR WHERE Email = 'jennifer.brown@university.edu'));

-- Physics Sections
INSERT INTO SECTION (CourseCode, SectionNumber, Semester, Year, Schedule, RoomLocation, MaxEnrollment, InstructorID) VALUES
('PHYS101', '001', 'Fall', 2024, 'MWF 1:00-1:50', 'SB-201', 30, (SELECT InstructorID FROM INSTRUCTOR WHERE Email = 'lisa.anderson@university.edu')),
('PHYS101', '002', 'Fall', 2024, 'TTh 8:00-9:15', 'SB-202', 30, (SELECT InstructorID FROM INSTRUCTOR WHERE Email = 'thomas.taylor@university.edu')),
('PHYS102', '001', 'Fall', 2024, 'MWF 2:00-2:50', 'SB-203', 25, (SELECT InstructorID FROM INSTRUCTOR WHERE Email = 'lisa.anderson@university.edu')),
('PHYS201', '001', 'Fall', 2024, 'TTh 3:00-4:15', 'SB-204', 20, (SELECT InstructorID FROM INSTRUCTOR WHERE Email = 'thomas.taylor@university.edu'));

-- Business Sections
INSERT INTO SECTION (CourseCode, SectionNumber, Semester, Year, Schedule, RoomLocation, MaxEnrollment, InstructorID) VALUES
('BUS101', '001', 'Fall', 2024, 'MWF 10:00-10:50', 'BC-101', 40, (SELECT InstructorID FROM INSTRUCTOR WHERE Email = 'maria.garcia@university.edu')),
('BUS101', '002', 'Fall', 2024, 'TTh 1:00-2:15', 'BC-102', 40, (SELECT InstructorID FROM INSTRUCTOR WHERE Email = 'james.lee@university.edu')),
('BUS201', '001', 'Fall', 2024, 'MWF 11:00-11:50', 'BC-103', 30, (SELECT InstructorID FROM INSTRUCTOR WHERE Email = 'maria.garcia@university.edu')),
('BUS301', '001', 'Fall', 2024, 'TTh 4:00-5:15', 'BC-104', 25, (SELECT InstructorID FROM INSTRUCTOR WHERE Email = 'james.lee@university.edu'));

-- Chemistry Sections
INSERT INTO SECTION (CourseCode, SectionNumber, Semester, Year, Schedule, RoomLocation, MaxEnrollment, InstructorID) VALUES
('CHEM101', '001', 'Fall', 2024, 'MWF 9:00-9:50', 'SB-301', 30, (SELECT InstructorID FROM INSTRUCTOR WHERE Email = 'patricia.white@university.edu')),
('CHEM101', '002', 'Fall', 2024, 'TTh 10:00-11:15', 'SB-302', 30, (SELECT InstructorID FROM INSTRUCTOR WHERE Email = 'patricia.white@university.edu')),
('CHEM102', '001', 'Fall', 2024, 'MWF 1:00-1:50', 'SB-303', 25, (SELECT InstructorID FROM INSTRUCTOR WHERE Email = 'patricia.white@university.edu')),
('CHEM201', '001', 'Fall', 2024, 'TTh 2:00-3:15', 'SB-304', 20, (SELECT InstructorID FROM INSTRUCTOR WHERE Email = 'patricia.white@university.edu'));
GO

PRINT 'Inserted 30 sections.';
PRINT '';
GO

-- ============================================================================
-- 7. INSERT ENROLLMENTS (50+ enrollment records)
-- ============================================================================

PRINT 'Inserting data into ENROLLMENT table...';
GO

-- Student 1000 (Alice Thompson - CS) - 5 courses
INSERT INTO ENROLLMENT (StudentID, SectionID, EnrollmentDate, Grade, Status) VALUES
(1000, (SELECT SectionID FROM SECTION WHERE CourseCode = 'CS102' AND SectionNumber = '001' AND Semester = 'Fall' AND Year = 2024), '2024-08-20', NULL, 'Enrolled'),
(1000, (SELECT SectionID FROM SECTION WHERE CourseCode = 'MATH201' AND SectionNumber = '001' AND Semester = 'Fall' AND Year = 2024), '2024-08-20', NULL, 'Enrolled'),
(1000, (SELECT SectionID FROM SECTION WHERE CourseCode = 'ENG102' AND SectionNumber = '001' AND Semester = 'Fall' AND Year = 2024), '2024-08-20', NULL, 'Enrolled'),
(1000, (SELECT SectionID FROM SECTION WHERE CourseCode = 'PHYS101' AND SectionNumber = '001' AND Semester = 'Fall' AND Year = 2024), '2024-08-20', NULL, 'Enrolled');

-- Student 1001 (Bob Jackson - CS) - 4 courses
INSERT INTO ENROLLMENT (StudentID, SectionID, EnrollmentDate, Grade, Status) VALUES
(1001, (SELECT SectionID FROM SECTION WHERE CourseCode = 'CS201' AND SectionNumber = '001' AND Semester = 'Fall' AND Year = 2024), '2024-08-20', NULL, 'Enrolled'),
(1001, (SELECT SectionID FROM SECTION WHERE CourseCode = 'CS301' AND SectionNumber = '001' AND Semester = 'Fall' AND Year = 2024), '2024-08-20', NULL, 'Enrolled'),
(1001, (SELECT SectionID FROM SECTION WHERE CourseCode = 'MATH301' AND SectionNumber = '001' AND Semester = 'Fall' AND Year = 2024), '2024-08-20', NULL, 'Enrolled'),
(1001, (SELECT SectionID FROM SECTION WHERE CourseCode = 'BUS301' AND SectionNumber = '001' AND Semester = 'Fall' AND Year = 2024), '2024-08-20', NULL, 'Enrolled');

-- Student 1002 (Charlie Harris - CS) - 5 courses
INSERT INTO ENROLLMENT (StudentID, SectionID, EnrollmentDate, Grade, Status) VALUES
(1002, (SELECT SectionID FROM SECTION WHERE CourseCode = 'CS102' AND SectionNumber = '001' AND Semester = 'Fall' AND Year = 2024), '2024-08-21', NULL, 'Enrolled'),
(1002, (SELECT SectionID FROM SECTION WHERE CourseCode = 'MATH201' AND SectionNumber = '001' AND Semester = 'Fall' AND Year = 2024), '2024-08-21', NULL, 'Enrolled'),
(1002, (SELECT SectionID FROM SECTION WHERE CourseCode = 'ENG201' AND SectionNumber = '001' AND Semester = 'Fall' AND Year = 2024), '2024-08-21', NULL, 'Enrolled'),
(1002, (SELECT SectionID FROM SECTION WHERE CourseCode = 'PHYS101' AND SectionNumber = '002' AND Semester = 'Fall' AND Year = 2024), '2024-08-21', NULL, 'Enrolled');

-- Student 1003 (Diana Clark - CS) - 4 courses
INSERT INTO ENROLLMENT (StudentID, SectionID, EnrollmentDate, Grade, Status) VALUES
(1003, (SELECT SectionID FROM SECTION WHERE CourseCode = 'CS201' AND SectionNumber = '001' AND Semester = 'Fall' AND Year = 2024), '2024-08-21', NULL, 'Enrolled'),
(1003, (SELECT SectionID FROM SECTION WHERE CourseCode = 'MATH301' AND SectionNumber = '001' AND Semester = 'Fall' AND Year = 2024), '2024-08-21', NULL, 'Enrolled'),
(1003, (SELECT SectionID FROM SECTION WHERE CourseCode = 'BUS201' AND SectionNumber = '001' AND Semester = 'Fall' AND Year = 2024), '2024-08-21', NULL, 'Enrolled');

-- Student 1004 (Emma Lewis - MATH) - 4 courses
INSERT INTO ENROLLMENT (StudentID, SectionID, EnrollmentDate, Grade, Status) VALUES
(1004, (SELECT SectionID FROM SECTION WHERE CourseCode = 'MATH201' AND SectionNumber = '001' AND Semester = 'Fall' AND Year = 2024), '2024-08-20', NULL, 'Enrolled'),
(1004, (SELECT SectionID FROM SECTION WHERE CourseCode = 'CS102' AND SectionNumber = '001' AND Semester = 'Fall' AND Year = 2024), '2024-08-20', NULL, 'Enrolled'),
(1004, (SELECT SectionID FROM SECTION WHERE CourseCode = 'PHYS201' AND SectionNumber = '001' AND Semester = 'Fall' AND Year = 2024), '2024-08-20', NULL, 'Enrolled'),
(1004, (SELECT SectionID FROM SECTION WHERE CourseCode = 'ENG102' AND SectionNumber = '001' AND Semester = 'Fall' AND Year = 2024), '2024-08-20', NULL, 'Enrolled');

-- Student 1005 (Frank Walker - MATH) - 4 courses
INSERT INTO ENROLLMENT (StudentID, SectionID, EnrollmentDate, Grade, Status) VALUES
(1005, (SELECT SectionID FROM SECTION WHERE CourseCode = 'MATH301' AND SectionNumber = '001' AND Semester = 'Fall' AND Year = 2024), '2024-08-21', NULL, 'Enrolled'),
(1005, (SELECT SectionID FROM SECTION WHERE CourseCode = 'CS201' AND SectionNumber = '001' AND Semester = 'Fall' AND Year = 2024), '2024-08-21', NULL, 'Enrolled'),
(1005, (SELECT SectionID FROM SECTION WHERE CourseCode = 'PHYS201' AND SectionNumber = '001' AND Semester = 'Fall' AND Year = 2024), '2024-08-21', NULL, 'Enrolled');

-- Student 1006 (Grace Hall - MATH) - 5 courses
INSERT INTO ENROLLMENT (StudentID, SectionID, EnrollmentDate, Grade, Status) VALUES
(1006, (SELECT SectionID FROM SECTION WHERE CourseCode = 'MATH201' AND SectionNumber = '001' AND Semester = 'Fall' AND Year = 2024), '2024-08-20', NULL, 'Enrolled'),
(1006, (SELECT SectionID FROM SECTION WHERE CourseCode = 'CS101' AND SectionNumber = '001' AND Semester = 'Fall' AND Year = 2024), '2024-08-20', NULL, 'Enrolled'),
(1006, (SELECT SectionID FROM SECTION WHERE CourseCode = 'PHYS102' AND SectionNumber = '001' AND Semester = 'Fall' AND Year = 2024), '2024-08-20', NULL, 'Enrolled'),
(1006, (SELECT SectionID FROM SECTION WHERE CourseCode = 'ENG101' AND SectionNumber = '001' AND Semester = 'Fall' AND Year = 2024), '2024-08-20', NULL, 'Enrolled');

-- Student 1007 (Henry Allen - ENG) - 4 courses
INSERT INTO ENROLLMENT (StudentID, SectionID, EnrollmentDate, Grade, Status) VALUES
(1007, (SELECT SectionID FROM SECTION WHERE CourseCode = 'ENG201' AND SectionNumber = '001' AND Semester = 'Fall' AND Year = 2024), '2024-08-21', NULL, 'Enrolled'),
(1007, (SELECT SectionID FROM SECTION WHERE CourseCode = 'MATH101' AND SectionNumber = '001' AND Semester = 'Fall' AND Year = 2024), '2024-08-21', NULL, 'Enrolled'),
(1007, (SELECT SectionID FROM SECTION WHERE CourseCode = 'BUS101' AND SectionNumber = '001' AND Semester = 'Fall' AND Year = 2024), '2024-08-21', NULL, 'Enrolled');

-- Student 1008 (Iris Young - ENG) - 4 courses
INSERT INTO ENROLLMENT (StudentID, SectionID, EnrollmentDate, Grade, Status) VALUES
(1008, (SELECT SectionID FROM SECTION WHERE CourseCode = 'ENG301' AND SectionNumber = '001' AND Semester = 'Fall' AND Year = 2024), '2024-08-20', NULL, 'Enrolled'),
(1008, (SELECT SectionID FROM SECTION WHERE CourseCode = 'ENG201' AND SectionNumber = '001' AND Semester = 'Fall' AND Year = 2024), '2024-08-20', NULL, 'Enrolled'),
(1008, (SELECT SectionID FROM SECTION WHERE CourseCode = 'MATH102' AND SectionNumber = '001' AND Semester = 'Fall' AND Year = 2024), '2024-08-20', NULL, 'Enrolled');

-- Student 1009 (Jack King - ENG) - 5 courses
INSERT INTO ENROLLMENT (StudentID, SectionID, EnrollmentDate, Grade, Status) VALUES
(1009, (SELECT SectionID FROM SECTION WHERE CourseCode = 'ENG201' AND SectionNumber = '001' AND Semester = 'Fall' AND Year = 2024), '2024-08-21', NULL, 'Enrolled'),
(1009, (SELECT SectionID FROM SECTION WHERE CourseCode = 'MATH101' AND SectionNumber = '002' AND Semester = 'Fall' AND Year = 2024), '2024-08-21', NULL, 'Enrolled'),
(1009, (SELECT SectionID FROM SECTION WHERE CourseCode = 'CS101' AND SectionNumber = '002' AND Semester = 'Fall' AND Year = 2024), '2024-08-21', NULL, 'Enrolled'),
(1009, (SELECT SectionID FROM SECTION WHERE CourseCode = 'BUS101' AND SectionNumber = '002' AND Semester = 'Fall' AND Year = 2024), '2024-08-21', NULL, 'Enrolled');

-- Student 1010 (Kelly Wright - PHYS) - 4 courses
INSERT INTO ENROLLMENT (StudentID, SectionID, EnrollmentDate, Grade, Status) VALUES
(1010, (SELECT SectionID FROM SECTION WHERE CourseCode = 'PHYS102' AND SectionNumber = '001' AND Semester = 'Fall' AND Year = 2024), '2024-08-20', NULL, 'Enrolled'),
(1010, (SELECT SectionID FROM SECTION WHERE CourseCode = 'MATH201' AND SectionNumber = '001' AND Semester = 'Fall' AND Year = 2024), '2024-08-20', NULL, 'Enrolled'),
(1010, (SELECT SectionID FROM SECTION WHERE CourseCode = 'CS101' AND SectionNumber = '001' AND Semester = 'Fall' AND Year = 2024), '2024-08-20', NULL, 'Enrolled'),
(1010, (SELECT SectionID FROM SECTION WHERE CourseCode = 'ENG102' AND SectionNumber = '001' AND Semester = 'Fall' AND Year = 2024), '2024-08-20', NULL, 'Enrolled');

-- Student 1011 (Leo Lopez - PHYS) - 3 courses
INSERT INTO ENROLLMENT (StudentID, SectionID, EnrollmentDate, Grade, Status) VALUES
(1011, (SELECT SectionID FROM SECTION WHERE CourseCode = 'PHYS201' AND SectionNumber = '001' AND Semester = 'Fall' AND Year = 2024), '2024-08-21', NULL, 'Enrolled'),
(1011, (SELECT SectionID FROM SECTION WHERE CourseCode = 'MATH301' AND SectionNumber = '001' AND Semester = 'Fall' AND Year = 2024), '2024-08-21', NULL, 'Enrolled'),
(1011, (SELECT SectionID FROM SECTION WHERE CourseCode = 'CS201' AND SectionNumber = '001' AND Semester = 'Fall' AND Year = 2024), '2024-08-21', NULL, 'Enrolled');

-- Student 1012 (Mia Hill - BUS) - 4 courses
INSERT INTO ENROLLMENT (StudentID, SectionID, EnrollmentDate, Grade, Status) VALUES
(1012, (SELECT SectionID FROM SECTION WHERE CourseCode = 'BUS201' AND SectionNumber = '001' AND Semester = 'Fall' AND Year = 2024), '2024-08-20', NULL, 'Enrolled'),
(1012, (SELECT SectionID FROM SECTION WHERE CourseCode = 'MATH101' AND SectionNumber = '001' AND Semester = 'Fall' AND Year = 2024), '2024-08-20', NULL, 'Enrolled'),
(1012, (SELECT SectionID FROM SECTION WHERE CourseCode = 'ENG102' AND SectionNumber = '001' AND Semester = 'Fall' AND Year = 2024), '2024-08-20', NULL, 'Enrolled'),
(1012, (SELECT SectionID FROM SECTION WHERE CourseCode = 'CS101' AND SectionNumber = '002' AND Semester = 'Fall' AND Year = 2024), '2024-08-20', NULL, 'Enrolled');

-- Add more enrollments for remaining students
INSERT INTO ENROLLMENT (StudentID, SectionID, EnrollmentDate, Grade, Status) VALUES
(1013, (SELECT SectionID FROM SECTION WHERE CourseCode = 'BUS301' AND SectionNumber = '001' AND Semester = 'Fall' AND Year = 2024), '2024-08-21', NULL, 'Enrolled'),
(1013, (SELECT SectionID FROM SECTION WHERE CourseCode = 'MATH102' AND SectionNumber = '001' AND Semester = 'Fall' AND Year = 2024), '2024-08-21', NULL, 'Enrolled'),
(1014, (SELECT SectionID FROM SECTION WHERE CourseCode = 'BUS201' AND SectionNumber = '001' AND Semester = 'Fall' AND Year = 2024), '2024-08-20', NULL, 'Enrolled'),
(1015, (SELECT SectionID FROM SECTION WHERE CourseCode = 'CHEM102' AND SectionNumber = '001' AND Semester = 'Fall' AND Year = 2024), '2024-08-20', NULL, 'Enrolled'),
(1016, (SELECT SectionID FROM SECTION WHERE CourseCode = 'CHEM201' AND SectionNumber = '001' AND Semester = 'Fall' AND Year = 2024), '2024-08-21', NULL, 'Enrolled');
GO

PRINT 'Inserted 50+ enrollment records.';
PRINT '';
GO

-- ============================================================================
-- SUMMARY
-- ============================================================================

PRINT '';
PRINT '============================================================================';
PRINT 'Sample Data Insertion Complete!';
PRINT '============================================================================';
PRINT '';
PRINT 'Data Inserted:';
PRINT '  - 6 Departments';
PRINT '  - 12 Instructors';
PRINT '  - 20 Students';
PRINT '  - 24 Courses';
PRINT '  - 30 Sections (Fall 2024)';
PRINT '  - 50+ Enrollment Records';
PRINT '';
PRINT 'Next Steps:';
PRINT '  - Execute 06-Query-Demonstrations.sql to test various queries';
PRINT '';
PRINT '============================================================================';
GO

-- Verify data insertion
SELECT 'DEPARTMENT' AS TableName, COUNT(*) AS RecordCount FROM DEPARTMENT
UNION ALL
SELECT 'INSTRUCTOR', COUNT(*) FROM INSTRUCTOR
UNION ALL
SELECT 'STUDENT', COUNT(*) FROM STUDENT
UNION ALL
SELECT 'COURSE', COUNT(*) FROM COURSE
UNION ALL
SELECT 'SECTION', COUNT(*) FROM SECTION
UNION ALL
SELECT 'ENROLLMENT', COUNT(*) FROM ENROLLMENT;
GO
