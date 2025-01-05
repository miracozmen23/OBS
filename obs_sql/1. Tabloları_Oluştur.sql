-- 1. Departments Tablosu
CREATE TABLE Departments (
    ID INT PRIMARY KEY IDENTITY(1,1),
    DepartmentName NVARCHAR(255) NOT NULL
);

-- 2. Roles Tablosu
CREATE TABLE Roles (
    ID INT PRIMARY KEY IDENTITY(1,1),
    Role NVARCHAR(255) NOT NULL
);

-- 3. Teachers Tablosu
CREATE TABLE Teachers (
    ID INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(255) NOT NULL,
    Surname NVARCHAR(255) NOT NULL,
    DepartmentID INT NOT NULL,
    RoleID INT NOT NULL,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(ID),
    FOREIGN KEY (RoleID) REFERENCES Roles(ID)
);


-- 4. Students Tablosu
CREATE TABLE Students (
    ID INT PRIMARY KEY IDENTITY(1,1),
    StudentNo NVARCHAR(50) NOT NULL UNIQUE,
    Name NVARCHAR(255) NOT NULL,
    Surname NVARCHAR(255) NOT NULL,
    DepartmentID INT NOT NULL,
    AdvisorID INT,
    RoleID INT NOT NULL,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(ID),
    FOREIGN KEY (AdvisorID) REFERENCES Teachers(ID),
    FOREIGN KEY (RoleID) REFERENCES Roles(ID)
);

-- 5. Admins Tablosu
CREATE TABLE Admins (
    ID INT PRIMARY KEY IDENTITY(1,1),
    RoleID INT NOT NULL,
    name NVARCHAR(255) NOT NULL,
    surname NVARCHAR(255) NOT NULL,
    FOREIGN KEY (RoleID) REFERENCES Roles(ID)
);


-- 6. RolePermissions Tablosu 
CREATE TABLE RolePermissions (
    ID INT PRIMARY KEY IDENTITY(1,1),
    RoleID INT NOT NULL,
    TableName NVARCHAR(255) NOT NULL,
    CanRead BIT DEFAULT 0,
    CanWrite BIT DEFAULT 0,
    CanUpdate BIT DEFAULT 0,
    CanDelete BIT DEFAULT 0,
    FOREIGN KEY (RoleID) REFERENCES Roles(ID)
);

-- 7. Courses Tablosu
CREATE TABLE Courses (
    ID INT PRIMARY KEY IDENTITY(1,1),
    CourseName NVARCHAR(255) NOT NULL,
	GradeLevel INT
);

-- 8. Classes Tablosu
CREATE TABLE Classes (
    ID INT PRIMARY KEY IDENTITY(1,1),
    ClassName NVARCHAR(255)
);

-- 9. Days Tablosu
CREATE TABLE Days (
    ID INT PRIMARY KEY IDENTITY(1,1),
    DayNames NVARCHAR(255)
);

-- 10. Timetables Tablosu
CREATE TABLE Timetables (
    ID INT PRIMARY KEY IDENTITY(1,1),
    CourseID INT NOT NULL,
    ClassID INT NOT NULL,
    DayID INT NOT NULL,
    StartTime DATETIME NOT NULL,
    EndTime DATETIME NOT NULL,
    FOREIGN KEY (CourseID) REFERENCES Courses(ID),
    FOREIGN KEY (ClassID) REFERENCES Classes(ID),
    FOREIGN KEY (DayID) REFERENCES Days(ID)
);

-- 11. Attendances Tablosu
CREATE TABLE Attendances (
    ID INT PRIMARY KEY IDENTITY(1,1),
    Date DATE NOT NULL,
    Status NVARCHAR(50) NOT NULL
);

-- 12. Exams Tablosu
CREATE TABLE Exams (
    ID INT PRIMARY KEY IDENTITY(1,1),
	CourseID INT NOT NULL,
    Date DATE NOT NULL,
    ExamType NVARCHAR(50) NOT NULL,
	FOREIGN KEY (CourseID) REFERENCES Courses(ID)
);

-- 13. Grades Tablosu
CREATE TABLE Grades (
    ID INT PRIMARY KEY IDENTITY(1,1),
    Score FLOAT NOT NULL,
	StudentID INT NOT NULL,
	ExamID INT NOT NULL,
	FOREIGN KEY (StudentID) REFERENCES Students(ID),
	FOREIGN KEY (ExamID) REFERENCES Exams(ID)
);

-- 14. Logs Tablosu
CREATE TABLE Logs (
    ID INT PRIMARY KEY IDENTITY(1,1),
    UserType NVARCHAR(50), -- Kullanıcı türü (Öğrenci, Öğretmen, Yönetici)
    UserID INT, -- İlgili kullanıcı ID'si
    Action NVARCHAR(50) NOT NULL,
    Description NVARCHAR(255),
    Timestamp DATETIME DEFAULT GETDATE()
);


-- 15. İlişki Tabloları
CREATE TABLE StudentAttendances (
    StudentID INT NOT NULL,
    AttendanceID INT NOT NULL,
    PRIMARY KEY (StudentID, AttendanceID),
    FOREIGN KEY (StudentID) REFERENCES Students(ID),
    FOREIGN KEY (AttendanceID) REFERENCES Attendances(ID)
);

CREATE TABLE CourseDepartments (
    CourseID INT NOT NULL,
    DepartmentID INT NOT NULL,
    PRIMARY KEY (CourseID, DepartmentID),
    FOREIGN KEY (CourseID) REFERENCES Courses(ID),
    FOREIGN KEY (DepartmentID) REFERENCES Departments(ID)
);

CREATE TABLE CourseTeachers (
    CourseID INT NOT NULL,
    TeacherID INT NOT NULL,
    PRIMARY KEY (CourseID, TeacherID),
    FOREIGN KEY (CourseID) REFERENCES Courses(ID),
    FOREIGN KEY (TeacherID) REFERENCES Teachers(ID)
);



