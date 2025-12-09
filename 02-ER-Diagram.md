# Entity-Relationship (ER) Diagram
## University Course Registration System

### ER Diagram Description

Below is the Entity-Relationship model for the University Course Registration System. The diagram shows six main entities with their attributes, primary keys, and relationships.

### Entities and Attributes

#### 1. STUDENT
- **StudentID** (PK) - Unique identifier for each student
- FirstName - Student's first name
- LastName - Student's last name
- Email - Student's email address
- Phone - Student's contact number
- DateOfBirth - Student's date of birth
- EnrollmentDate - Date when student enrolled
- MajorDeptCode (FK) - Foreign key to DEPARTMENT
- Status - Academic status (Active, Graduated, On Leave, Withdrawn)
- GPA - Current grade point average
- TotalCredits - Total credits earned

#### 2. DEPARTMENT
- **DepartmentCode** (PK) - Unique code for department (e.g., CS, MATH, ENG)
- DepartmentName - Full name of the department
- Building - Building where department is located
- HeadInstructorID (FK) - Foreign key to INSTRUCTOR (nullable)
- Phone - Department contact number
- Email - Department email address

#### 3. COURSE
- **CourseCode** (PK) - Unique course code (e.g., CS101, MATH201)
- CourseTitle - Title of the course
- Description - Course description
- CreditHours - Number of credit hours (1-6)
- DepartmentCode (FK) - Foreign key to DEPARTMENT
- Level - Course level (Undergraduate, Graduate)
- PrerequisiteCourseCode (FK) - Self-referencing FK for prerequisites (nullable)

#### 4. INSTRUCTOR
- **InstructorID** (PK) - Unique identifier for instructor
- FirstName - Instructor's first name
- LastName - Instructor's last name
- Email - Instructor's email address
- Phone - Instructor's contact number
- DepartmentCode (FK) - Foreign key to DEPARTMENT
- OfficeLocation - Office room number
- HireDate - Date when instructor was hired
- Rank - Academic rank (Assistant Professor, Associate Professor, Professor, Lecturer)

#### 5. SECTION
- **SectionID** (PK) - Unique identifier for course section
- CourseCode (FK) - Foreign key to COURSE
- SectionNumber - Section number (e.g., 001, 002)
- Semester - Semester offered (Fall, Spring, Summer)
- Year - Academic year
- Schedule - Days and times (e.g., MWF 10:00-10:50)
- RoomLocation - Classroom location
- MaxEnrollment - Maximum number of students
- InstructorID (FK) - Foreign key to INSTRUCTOR

#### 6. ENROLLMENT
- **EnrollmentID** (PK) - Unique identifier for enrollment record
- StudentID (FK) - Foreign key to STUDENT
- SectionID (FK) - Foreign key to SECTION
- EnrollmentDate - Date when student enrolled
- Grade - Final grade (A, A-, B+, B, etc.) - nullable until course completion
- Status - Enrollment status (Enrolled, Completed, Dropped, Withdrawn)

### Relationships

#### 1. STUDENT enrolls in DEPARTMENT (Many-to-One)
- **Relationship Name**: majors_in
- **Cardinality**: Many students : One department
- **Participation**: Total (every student must have a major)
- **Description**: Each student declares a major in exactly one department. A department can have many students as majors.

#### 2. COURSE belongs to DEPARTMENT (Many-to-One)
- **Relationship Name**: offers
- **Cardinality**: Many courses : One department
- **Participation**: Total (every course must belong to a department)
- **Description**: Each course is offered by exactly one department. A department can offer many courses.

#### 3. INSTRUCTOR works in DEPARTMENT (Many-to-One)
- **Relationship Name**: employed_by
- **Cardinality**: Many instructors : One department
- **Participation**: Total (every instructor must be affiliated with a department)
- **Description**: Each instructor is affiliated with exactly one primary department. A department can employ many instructors.

#### 4. DEPARTMENT has head INSTRUCTOR (One-to-One)
- **Relationship Name**: headed_by
- **Cardinality**: One department : One instructor
- **Participation**: Partial (department may not have a head assigned)
- **Description**: Each department can have one instructor serving as department head. An instructor can head at most one department.

#### 5. SECTION is instance of COURSE (Many-to-One)
- **Relationship Name**: instance_of
- **Cardinality**: Many sections : One course
- **Participation**: Total (every section must be of a course)
- **Description**: Each section is a specific offering of exactly one course. A course can have many sections across different semesters.

#### 6. SECTION is taught by INSTRUCTOR (Many-to-One)
- **Relationship Name**: teaches
- **Cardinality**: Many sections : One instructor
- **Participation**: Total (every section must have an instructor)
- **Description**: Each section is taught by exactly one instructor. An instructor can teach many sections.

#### 7. STUDENT enrolls in SECTION through ENROLLMENT (Many-to-Many)
- **Relationship Name**: registers_for
- **Cardinality**: Many students : Many sections
- **Participation**: Partial on both sides
- **Description**: Students can enroll in multiple sections, and each section can have multiple students. The ENROLLMENT entity serves as an associative entity capturing enrollment details.

#### 8. COURSE has prerequisite COURSE (Recursive Many-to-One)
- **Relationship Name**: requires
- **Cardinality**: Many courses : One prerequisite course
- **Participation**: Partial (not all courses have prerequisites)
- **Description**: Some courses require completion of other courses as prerequisites. A course can have one direct prerequisite, but can be a prerequisite for many courses.

### Cardinality Summary Table

| Relationship | Entity 1 | Cardinality | Entity 2 | Type |
|--------------|----------|-------------|----------|------|
| majors_in | STUDENT | N:1 | DEPARTMENT | Many-to-One |
| offers | COURSE | N:1 | DEPARTMENT | Many-to-One |
| employed_by | INSTRUCTOR | N:1 | DEPARTMENT | Many-to-One |
| headed_by | DEPARTMENT | 1:1 | INSTRUCTOR | One-to-One |
| instance_of | SECTION | N:1 | COURSE | Many-to-One |
| teaches | SECTION | N:1 | INSTRUCTOR | Many-to-One |
| registers_for | STUDENT | M:N | SECTION | Many-to-Many |
| requires | COURSE | N:1 | COURSE | Recursive |

### ER Diagram (Textual Representation)

```
┌─────────────────────┐
│     DEPARTMENT      │
│  PK: DepartmentCode │◄────────┐
│     DepartmentName  │         │
│     Building        │         │ N
│  FK: HeadInstrID    │         │
│     Phone           │         │
│     Email           │         │
└─────────────────────┘         │
         △                       │
         │ 1                     │
         │                       │
         │ N                     │
    ┌────┴─────────┬─────────────┤
    │              │             │
    │              │             │
┌───┴──────────┐ ┌─┴──────────┐ ┌┴──────────────┐
│   STUDENT    │ │   COURSE   │ │  INSTRUCTOR   │
│ PK:StudentID │ │PK:CourseCode│ │PK:InstructorID│
│   FirstName  │ │ CourseTitle │ │   FirstName   │
│   LastName   │ │ Description │ │   LastName    │
│   Email      │ │ CreditHours │ │   Email       │
│   Phone      │ │FK:DeptCode  │ │   Phone       │
│ DateOfBirth  │ │   Level     │ │FK:DeptCode    │
│EnrollmentDate│ │FK:PrereqCode│ │OfficeLocation │
│FK:MajorDept  │ │             │ │   HireDate    │
│   Status     │ │      △      │ │    Rank       │
│   GPA        │ │      │      │ │               │
│TotalCredits  │ │      │ 1    │ └───────┬───────┘
└──────┬───────┘ │      │      │         │
       │         │      │ N    │         │ 1
       │ M       └──────┼──────┘         │
       │                │                │
       │                │                │ N
       │         ┌──────┴────────┐       │
       │         │    SECTION    │       │
       │         │  PK:SectionID │◄──────┘
       │         │FK:CourseCode  │
       │         │ SectionNumber │
       │         │   Semester    │
       │         │     Year      │
       │         │   Schedule    │
       │         │ RoomLocation  │
       │         │MaxEnrollment  │
       │         │FK:InstructorID│
       │         └───────┬───────┘
       │                 │
       │ M               │ N
       │                 │
       └────────┬────────┘
                │
         ┌──────┴──────────┐
         │   ENROLLMENT    │
         │PK:EnrollmentID  │
         │  FK:StudentID   │
         │  FK:SectionID   │
         │ EnrollmentDate  │
         │     Grade       │
         │    Status       │
         └─────────────────┘
```

### Key Design Decisions

1. **ENROLLMENT as Associative Entity**: The many-to-many relationship between STUDENT and SECTION is resolved using ENROLLMENT, which also stores enrollment-specific attributes like Grade and EnrollmentDate.

2. **Recursive Relationship**: COURSE has a self-referencing relationship for prerequisites, allowing courses to require other courses.

3. **Department Head**: Implemented as a foreign key in DEPARTMENT rather than a separate relationship table, assuming one-to-one cardinality.

4. **Section Independence**: SECTION is a separate entity rather than a weak entity, as sections need to exist independently and be referenced by enrollments.

5. **Status Attributes**: Both STUDENT and ENROLLMENT have status attributes to track different types of status (academic status vs. enrollment status).

### Constraints Represented in ER Model

1. **Primary Key Constraints**: Each entity has a unique identifier
2. **Foreign Key Constraints**: Relationships are enforced through foreign keys
3. **Participation Constraints**: 
   - Total: Student must have a major, Course must belong to department
   - Partial: Department head is optional
4. **Cardinality Constraints**: Defined for all relationships
5. **Domain Constraints**: Implicit in attribute types (e.g., Grade values, Status values)

### ER Diagram Tools Note

For submission, you should create this ER diagram using one of these tools:
- **Microsoft Visio**
- **Lucidchart** (online, free for students)
- **Draw.io / diagrams.net** (free, online)
- **MySQL Workbench** (free)
- **ERDPlus** (free, online)

The textual representation above should be converted to a proper visual ER diagram with standard notation:
- Rectangles for entities
- Ovals for attributes
- Diamonds for relationships
- Lines with cardinality notation (1, N, M)
- Underlined attributes for primary keys
