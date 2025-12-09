# Requirements Analysis
## University Course Registration System

### 1. Project Goal
The University Course Registration System is designed to manage and streamline the process of course enrollment, tracking student registrations, managing course offerings, and maintaining instructor assignments. The system will facilitate efficient data management for academic administration, enable students to register for courses, and provide comprehensive reporting capabilities.

### 2. Main Purpose
- Manage student enrollment and academic records
- Track course offerings and schedules
- Assign instructors to courses
- Monitor department resources and course catalog
- Generate enrollment reports and grade management
- Enforce business rules and data integrity constraints

### 3. Target Users
1. **Students**: Register for courses, view schedules, check grades
2. **Instructors**: View assigned courses, manage class rosters, submit grades
3. **Academic Advisors**: Monitor student progress, assist with registration
4. **Registrar Office Staff**: Manage course offerings, process enrollments
5. **Department Administrators**: Oversee departmental courses and instructor assignments
6. **System Administrators**: Maintain database integrity and security

### 4. Data to be Stored

#### 4.1 Student Information
- Student ID, name, email, phone number
- Date of birth, enrollment date
- Major department
- Current academic status (Active, Graduated, On Leave)
- GPA and total credits earned

#### 4.2 Course Information
- Course code, title, description
- Credit hours
- Department offering the course
- Prerequisites
- Course level (Undergraduate, Graduate)

#### 4.3 Department Information
- Department code and name
- Department head
- Building location
- Contact information

#### 4.4 Instructor Information
- Instructor ID, name, email
- Department affiliation
- Office location
- Hire date
- Academic rank (Assistant Professor, Associate Professor, Professor)

#### 4.5 Course Section Information
- Section number
- Semester and year
- Schedule (days and time)
- Room location
- Maximum enrollment capacity
- Assigned instructor

#### 4.6 Enrollment Information
- Student enrollment in specific course sections
- Enrollment date
- Final grade
- Enrollment status (Enrolled, Completed, Dropped, Withdrawn)

### 5. Business Rules and Constraints

#### 5.1 Student Rules
1. Each student must be assigned to exactly one major department
2. Students can enroll in multiple course sections per semester
3. A student cannot enroll in the same course section more than once
4. Students must meet prerequisites before enrolling in advanced courses
5. Maximum credit hour limit per semester (typically 18 credits)

#### 5.2 Course Rules
1. Each course belongs to exactly one department
2. A course can have multiple sections offered in different semesters
3. Course codes must be unique across the university
4. Credit hours must be between 1 and 6

#### 5.3 Department Rules
1. Each department must have a unique department code
2. A department can offer multiple courses
3. A department can employ multiple instructors
4. One instructor serves as department head

#### 5.4 Instructor Rules
1. Each instructor is affiliated with one primary department
2. An instructor can teach multiple course sections
3. An instructor cannot teach more than 4 sections per semester
4. Only active faculty can be assigned to teach courses

#### 5.5 Course Section Rules
1. Each section must have exactly one assigned instructor
2. Section enrollment cannot exceed maximum capacity
3. Each section is offered in a specific semester and year
4. Room and time conflicts must be avoided

#### 5.6 Enrollment Rules
1. Students cannot enroll in sections that are full
2. Enrollment date must be within the registration period
3. Students cannot enroll in conflicting time slots
4. Final grades can only be entered after course completion
5. Once enrolled, status changes follow specific workflows (Enrolled → Completed/Dropped/Withdrawn)

### 6. Key Entities Identified
1. **STUDENT**: Students enrolled in the university
2. **COURSE**: Academic courses offered by the university
3. **DEPARTMENT**: Academic departments within the university
4. **INSTRUCTOR**: Faculty members who teach courses
5. **SECTION**: Specific offerings of courses in particular semesters
6. **ENROLLMENT**: Registration records linking students to sections

### 7. Key Relationships
- **Student → Department**: Each student has a major (Many-to-One)
- **Course → Department**: Each course is offered by a department (Many-to-One)
- **Instructor → Department**: Each instructor belongs to a department (Many-to-One)
- **Section → Course**: Each section is an instance of a course (Many-to-One)
- **Section → Instructor**: Each section is taught by an instructor (Many-to-One)
- **Enrollment → Student and Section**: Students enroll in sections (Many-to-Many through Enrollment)

### 8. Sample Use Cases

#### Use Case 1: Student Course Registration
1. Student logs into the system
2. Views available course sections for the current semester
3. Selects desired courses
4. System checks prerequisites and time conflicts
5. System confirms enrollment if all constraints are met

#### Use Case 2: Instructor Assignment
1. Department administrator selects a course section
2. Assigns an available instructor from the department
3. System verifies instructor teaching load
4. Creates the instructor-section assignment

#### Use Case 3: Grade Submission
1. Instructor accesses course roster
2. Enters final grades for all enrolled students
3. System validates grade values
4. Updates enrollment records with grades

### 9. Reporting Requirements
- Student transcripts showing all completed courses and grades
- Course rosters for instructors
- Enrollment statistics by department and semester
- Instructor teaching load reports
- Student GPA calculations
- Department course offerings summary

### 10. Data Integrity and Security
- Referential integrity must be maintained across all relationships
- Student academic records are confidential
- Grade changes require proper authorization
- Audit trail for enrollment changes
- Backup and recovery procedures
