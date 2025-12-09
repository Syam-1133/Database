# Relational Schema Design
## University Course Registration System

### Overview
This document presents the logical database design translated from the ER diagram. The schema is normalized to Third Normal Form (3NF) to ensure data integrity, minimize redundancy, and optimize for efficient querying.

---

## Relational Schema

### 1. DEPARTMENT
```
DEPARTMENT(DepartmentCode, DepartmentName, Building, HeadInstructorID, Phone, Email)
    PK: DepartmentCode
    FK: HeadInstructorID REFERENCES INSTRUCTOR(InstructorID)
```

**Attributes:**
- `DepartmentCode` (VARCHAR(10), PK) - Unique department identifier
- `DepartmentName` (VARCHAR(100), NOT NULL) - Full department name
- `Building` (VARCHAR(50)) - Building location
- `HeadInstructorID` (INT, FK, NULLABLE) - Department head reference
- `Phone` (VARCHAR(15)) - Department phone number
- `Email` (VARCHAR(100)) - Department email address

**Constraints:**
- DepartmentCode is unique and cannot be NULL
- DepartmentName must be unique
- HeadInstructorID must exist in INSTRUCTOR table or be NULL

---

### 2. INSTRUCTOR
```
INSTRUCTOR(InstructorID, FirstName, LastName, Email, Phone, DepartmentCode, OfficeLocation, HireDate, Rank)
    PK: InstructorID
    FK: DepartmentCode REFERENCES DEPARTMENT(DepartmentCode)
```

**Attributes:**
- `InstructorID` (INT, PK, IDENTITY) - Auto-incrementing unique identifier
- `FirstName` (VARCHAR(50), NOT NULL) - Instructor's first name
- `LastName` (VARCHAR(50), NOT NULL) - Instructor's last name
- `Email` (VARCHAR(100), UNIQUE, NOT NULL) - Instructor's email
- `Phone` (VARCHAR(15)) - Contact number
- `DepartmentCode` (VARCHAR(10), FK, NOT NULL) - Department affiliation
- `OfficeLocation` (VARCHAR(50)) - Office room number
- `HireDate` (DATE, NOT NULL) - Date of hire
- `Rank` (VARCHAR(30), NOT NULL) - Academic rank

**Constraints:**
- InstructorID is auto-generated
- Email must be unique
- DepartmentCode must exist in DEPARTMENT
- Rank must be in ('Assistant Professor', 'Associate Professor', 'Professor', 'Lecturer', 'Adjunct')

---

### 3. STUDENT
```
STUDENT(StudentID, FirstName, LastName, Email, Phone, DateOfBirth, EnrollmentDate, MajorDeptCode, Status, GPA, TotalCredits)
    PK: StudentID
    FK: MajorDeptCode REFERENCES DEPARTMENT(DepartmentCode)
```

**Attributes:**
- `StudentID` (INT, PK, IDENTITY) - Auto-incrementing unique identifier
- `FirstName` (VARCHAR(50), NOT NULL) - Student's first name
- `LastName` (VARCHAR(50), NOT NULL) - Student's last name
- `Email` (VARCHAR(100), UNIQUE, NOT NULL) - Student's email
- `Phone` (VARCHAR(15)) - Contact number
- `DateOfBirth` (DATE) - Student's birth date
- `EnrollmentDate` (DATE, NOT NULL) - Date of university enrollment
- `MajorDeptCode` (VARCHAR(10), FK, NOT NULL) - Major department
- `Status` (VARCHAR(20), NOT NULL) - Academic status
- `GPA` (DECIMAL(3,2), DEFAULT 0.00) - Grade point average (0.00-4.00)
- `TotalCredits` (INT, DEFAULT 0) - Total credits earned

**Constraints:**
- StudentID is auto-generated
- Email must be unique
- MajorDeptCode must exist in DEPARTMENT
- Status must be in ('Active', 'Graduated', 'On Leave', 'Withdrawn')
- GPA must be between 0.00 and 4.00
- TotalCredits must be >= 0

---

### 4. COURSE
```
COURSE(CourseCode, CourseTitle, Description, CreditHours, DepartmentCode, Level, PrerequisiteCourseCode)
    PK: CourseCode
    FK: DepartmentCode REFERENCES DEPARTMENT(DepartmentCode)
    FK: PrerequisiteCourseCode REFERENCES COURSE(CourseCode)
```

**Attributes:**
- `CourseCode` (VARCHAR(10), PK) - Unique course identifier (e.g., CS101)
- `CourseTitle` (VARCHAR(200), NOT NULL) - Course title
- `Description` (TEXT) - Course description
- `CreditHours` (INT, NOT NULL) - Number of credit hours
- `DepartmentCode` (VARCHAR(10), FK, NOT NULL) - Offering department
- `Level` (VARCHAR(20), NOT NULL) - Course level
- `PrerequisiteCourseCode` (VARCHAR(10), FK, NULLABLE) - Prerequisite course

**Constraints:**
- CourseCode is unique
- CreditHours must be between 1 and 6
- DepartmentCode must exist in DEPARTMENT
- Level must be in ('Undergraduate', 'Graduate')
- PrerequisiteCourseCode must exist in COURSE if specified

---

### 5. SECTION
```
SECTION(SectionID, CourseCode, SectionNumber, Semester, Year, Schedule, RoomLocation, MaxEnrollment, InstructorID)
    PK: SectionID
    FK: CourseCode REFERENCES COURSE(CourseCode)
    FK: InstructorID REFERENCES INSTRUCTOR(InstructorID)
    UNIQUE: (CourseCode, SectionNumber, Semester, Year)
```

**Attributes:**
- `SectionID` (INT, PK, IDENTITY) - Auto-incrementing unique identifier
- `CourseCode` (VARCHAR(10), FK, NOT NULL) - Course being offered
- `SectionNumber` (VARCHAR(5), NOT NULL) - Section number (e.g., '001', '002')
- `Semester` (VARCHAR(10), NOT NULL) - Semester offered
- `Year` (INT, NOT NULL) - Academic year
- `Schedule` (VARCHAR(50)) - Meeting days and times
- `RoomLocation` (VARCHAR(50)) - Classroom location
- `MaxEnrollment` (INT, NOT NULL) - Maximum capacity
- `InstructorID` (INT, FK, NOT NULL) - Assigned instructor

**Constraints:**
- SectionID is auto-generated
- CourseCode must exist in COURSE
- InstructorID must exist in INSTRUCTOR
- Combination of (CourseCode, SectionNumber, Semester, Year) must be unique
- Semester must be in ('Fall', 'Spring', 'Summer')
- Year must be >= 2000
- MaxEnrollment must be > 0

---

### 6. ENROLLMENT
```
ENROLLMENT(EnrollmentID, StudentID, SectionID, EnrollmentDate, Grade, Status)
    PK: EnrollmentID
    FK: StudentID REFERENCES STUDENT(StudentID)
    FK: SectionID REFERENCES SECTION(SectionID)
    UNIQUE: (StudentID, SectionID)
```

**Attributes:**
- `EnrollmentID` (INT, PK, IDENTITY) - Auto-incrementing unique identifier
- `StudentID` (INT, FK, NOT NULL) - Enrolled student
- `SectionID` (INT, FK, NOT NULL) - Course section
- `EnrollmentDate` (DATE, NOT NULL) - Date of enrollment
- `Grade` (VARCHAR(3), NULLABLE) - Final grade (A, A-, B+, B, etc.)
- `Status` (VARCHAR(20), NOT NULL) - Enrollment status

**Constraints:**
- EnrollmentID is auto-generated
- StudentID must exist in STUDENT
- SectionID must exist in SECTION
- Combination of (StudentID, SectionID) must be unique (no duplicate enrollments)
- Status must be in ('Enrolled', 'Completed', 'Dropped', 'Withdrawn')
- Grade can be NULL if Status is 'Enrolled'

---

## Normalization Analysis

### First Normal Form (1NF)
✅ **All tables are in 1NF:**
- All attributes contain atomic values (no multi-valued or composite attributes)
- Each column contains values of a single type
- Each column has a unique name
- Order of rows is not significant

**Example:** 
- Schedule stored as single VARCHAR (e.g., "MWF 10:00-10:50") rather than separate day/time attributes
- Name split into FirstName and LastName (atomic)

---

### Second Normal Form (2NF)
✅ **All tables are in 2NF:**
- All tables are in 1NF
- No partial dependencies exist (all non-key attributes are fully dependent on the entire primary key)

**Analysis by Table:**

1. **DEPARTMENT, INSTRUCTOR, STUDENT, COURSE**: Single-attribute primary keys, so 2NF is automatically satisfied

2. **SECTION**: 
   - Primary key: SectionID (single attribute)
   - All attributes depend on the complete key
   - Alternative candidate key (CourseCode, SectionNumber, Semester, Year) is captured by UNIQUE constraint

3. **ENROLLMENT**: 
   - Primary key: EnrollmentID (single attribute)
   - All attributes (EnrollmentDate, Grade, Status) depend on the complete EnrollmentID
   - No partial dependencies

---

### Third Normal Form (3NF)
✅ **All tables are in 3NF:**
- All tables are in 2NF
- No transitive dependencies exist (non-key attributes don't depend on other non-key attributes)

**Analysis by Table:**

1. **DEPARTMENT**
   - No transitive dependencies
   - All non-key attributes depend directly on DepartmentCode
   - HeadInstructorID is a foreign key, not derived from other attributes

2. **INSTRUCTOR**
   - No transitive dependencies
   - Rank, OfficeLocation, HireDate all depend directly on InstructorID
   - DepartmentCode is a foreign key relationship, not a transitive dependency

3. **STUDENT**
   - GPA and TotalCredits are stored values, not derived
   - If these were calculated from ENROLLMENT, they would be removed
   - For performance, we keep them as materialized values with triggers to maintain them
   - All attributes depend directly on StudentID

4. **COURSE**
   - No transitive dependencies
   - CourseTitle, CreditHours, Level all depend directly on CourseCode
   - PrerequisiteCourseCode is a relationship, not a transitive dependency

5. **SECTION**
   - No transitive dependencies
   - Schedule, RoomLocation depend on SectionID, not on each other
   - Semester and Year are independent attributes

6. **ENROLLMENT**
   - Grade and Status are independent attributes
   - EnrollmentDate is a timestamp of the enrollment event
   - No transitive dependencies

---

## Functional Dependencies

### DEPARTMENT
```
DepartmentCode → DepartmentName, Building, HeadInstructorID, Phone, Email
```

### INSTRUCTOR
```
InstructorID → FirstName, LastName, Email, Phone, DepartmentCode, OfficeLocation, HireDate, Rank
Email → InstructorID (UNIQUE constraint)
```

### STUDENT
```
StudentID → FirstName, LastName, Email, Phone, DateOfBirth, EnrollmentDate, MajorDeptCode, Status, GPA, TotalCredits
Email → StudentID (UNIQUE constraint)
```

### COURSE
```
CourseCode → CourseTitle, Description, CreditHours, DepartmentCode, Level, PrerequisiteCourseCode
```

### SECTION
```
SectionID → CourseCode, SectionNumber, Semester, Year, Schedule, RoomLocation, MaxEnrollment, InstructorID
(CourseCode, SectionNumber, Semester, Year) → SectionID (UNIQUE constraint)
```

### ENROLLMENT
```
EnrollmentID → StudentID, SectionID, EnrollmentDate, Grade, Status
(StudentID, SectionID) → EnrollmentID (UNIQUE constraint)
```

---

## Referential Integrity Constraints

### Foreign Key Actions

1. **STUDENT.MajorDeptCode → DEPARTMENT.DepartmentCode**
   - ON DELETE: RESTRICT (cannot delete department with students)
   - ON UPDATE: CASCADE (update propagates to students)

2. **COURSE.DepartmentCode → DEPARTMENT.DepartmentCode**
   - ON DELETE: RESTRICT (cannot delete department with courses)
   - ON UPDATE: CASCADE

3. **COURSE.PrerequisiteCourseCode → COURSE.CourseCode**
   - ON DELETE: SET NULL (if prerequisite deleted, set to NULL)
   - ON UPDATE: CASCADE

4. **INSTRUCTOR.DepartmentCode → DEPARTMENT.DepartmentCode**
   - ON DELETE: RESTRICT (cannot delete department with instructors)
   - ON UPDATE: CASCADE

5. **DEPARTMENT.HeadInstructorID → INSTRUCTOR.InstructorID**
   - ON DELETE: SET NULL (if head leaves, set to NULL)
   - ON UPDATE: CASCADE

6. **SECTION.CourseCode → COURSE.CourseCode**
   - ON DELETE: RESTRICT (cannot delete course with sections)
   - ON UPDATE: CASCADE

7. **SECTION.InstructorID → INSTRUCTOR.InstructorID**
   - ON DELETE: RESTRICT (cannot delete instructor with assigned sections)
   - ON UPDATE: CASCADE

8. **ENROLLMENT.StudentID → STUDENT.StudentID**
   - ON DELETE: CASCADE (if student deleted, remove enrollments)
   - ON UPDATE: CASCADE

9. **ENROLLMENT.SectionID → SECTION.SectionID**
   - ON DELETE: RESTRICT (cannot delete section with enrollments)
   - ON UPDATE: CASCADE

---

## Additional Constraints and Business Rules

### Check Constraints

1. **STUDENT.GPA**: `CHECK (GPA >= 0.00 AND GPA <= 4.00)`
2. **STUDENT.TotalCredits**: `CHECK (TotalCredits >= 0)`
3. **COURSE.CreditHours**: `CHECK (CreditHours BETWEEN 1 AND 6)`
4. **SECTION.MaxEnrollment**: `CHECK (MaxEnrollment > 0)`
5. **SECTION.Year**: `CHECK (Year >= 2000)`

### Domain Constraints

1. **Status Values**:
   - STUDENT.Status: ('Active', 'Graduated', 'On Leave', 'Withdrawn')
   - ENROLLMENT.Status: ('Enrolled', 'Completed', 'Dropped', 'Withdrawn')

2. **Semester Values**: ('Fall', 'Spring', 'Summer')

3. **Level Values**: ('Undergraduate', 'Graduate')

4. **Rank Values**: ('Assistant Professor', 'Associate Professor', 'Professor', 'Lecturer', 'Adjunct')

### Complex Business Rules (to be enforced via triggers/procedures)

1. **Enrollment Capacity**: Current enrollment count cannot exceed SECTION.MaxEnrollment
2. **Instructor Load**: Instructor cannot teach more than 4 sections per semester
3. **Time Conflicts**: Student cannot enroll in sections with overlapping schedules
4. **Grade Assignment**: Grade can only be entered for Status = 'Completed'
5. **GPA Calculation**: Automatically update STUDENT.GPA when grades are entered

---

## Indexing Strategy

### Primary Indexes (Automatic)
- Clustered indexes on all primary keys

### Recommended Secondary Indexes

```sql
-- For student lookups by email
CREATE UNIQUE INDEX idx_student_email ON STUDENT(Email);

-- For instructor lookups by email
CREATE UNIQUE INDEX idx_instructor_email ON INSTRUCTOR(Email);

-- For finding students by department
CREATE INDEX idx_student_major ON STUDENT(MajorDeptCode);

-- For finding courses by department
CREATE INDEX idx_course_dept ON COURSE(DepartmentCode);

-- For finding instructors by department
CREATE INDEX idx_instructor_dept ON INSTRUCTOR(DepartmentCode);

-- For finding sections by course
CREATE INDEX idx_section_course ON SECTION(CourseCode);

-- For finding sections by instructor
CREATE INDEX idx_section_instructor ON SECTION(InstructorID);

-- For finding sections by semester/year
CREATE INDEX idx_section_semester ON SECTION(Semester, Year);

-- For finding enrollments by student
CREATE INDEX idx_enrollment_student ON ENROLLMENT(StudentID);

-- For finding enrollments by section
CREATE INDEX idx_enrollment_section ON ENROLLMENT(SectionID);

-- For ensuring unique section identifiers
CREATE UNIQUE INDEX idx_section_unique ON SECTION(CourseCode, SectionNumber, Semester, Year);

-- For ensuring unique enrollments
CREATE UNIQUE INDEX idx_enrollment_unique ON ENROLLMENT(StudentID, SectionID);
```

---

## Schema Diagram (Relational Model)

```
DEPARTMENT                    INSTRUCTOR
──────────────────           ──────────────────
PK DepartmentCode     ┌─────►PK InstructorID
   DepartmentName     │         FirstName
   Building           │         LastName
FK HeadInstructorID───┘         Email
   Phone                        Phone
   Email                     FK DepartmentCode───┐
                                OfficeLocation   │
                                HireDate         │
     ▲                          Rank             │
     │                                           │
     │                             ▲             │
     └─────────────────────────────┼─────────────┘
                                   │
        ┌──────────────────────────┴─────────────────────┐
        │                                                │
        │                                                │
STUDENT │                     COURSE                 SECTION
─────────────────            ──────────────────    ──────────────────
PK StudentID                 PK CourseCode         PK SectionID
   FirstName              ┌───► CourseTitle      ┌───FK CourseCode
   LastName               │     Description      │    SectionNumber
   Email                  │     CreditHours      │    Semester
   Phone                  │  FK DepartmentCode   │    Year
   DateOfBirth            │     Level            │    Schedule
   EnrollmentDate         │  FK PrerequisiteCode │    RoomLocation
FK MajorDeptCode──────────┤                      │    MaxEnrollment
   Status                 │                      └───FK InstructorID
   GPA                    │
   TotalCredits           │
                          │
     │                    │
     │                    │                             ▲
     │                    └─────────────────────────────┘
     │
     │                    ENROLLMENT
     │                    ──────────────────
     │                    PK EnrollmentID
     └───────────────────►FK StudentID
                          FK SectionID───────────────►
                             EnrollmentDate
                             Grade
                             Status
```

---

## Summary

This relational schema successfully:
1. ✅ Translates all entities and relationships from the ER diagram
2. ✅ Achieves Third Normal Form (3NF)
3. ✅ Eliminates data redundancy
4. ✅ Enforces referential integrity
5. ✅ Implements business rules through constraints
6. ✅ Provides efficient indexing strategy
7. ✅ Maintains data consistency and integrity

The schema is ready for implementation in Microsoft SQL Server.
