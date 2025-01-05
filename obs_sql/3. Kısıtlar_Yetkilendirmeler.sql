-- 1. Rolleri oluştur.
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = 'StudentRole')
    CREATE ROLE StudentRole;

IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = 'TeacherRole')
    CREATE ROLE TeacherRole;

IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = 'AdminRole')
    CREATE ROLE AdminRole;

-- 2. Kullanıcılar için login'ler oluştur (SQL Server oturumları)
CREATE LOGIN student1 WITH PASSWORD = 'student';
CREATE LOGIN teacher1 WITH PASSWORD = 'teacher';
CREATE LOGIN admin1 WITH PASSWORD = 'admin';

USE OBS; 

-- 4. Veritabanında kullanıcıları oluştur
CREATE USER student1 FOR LOGIN student1;
CREATE USER teacher1 FOR LOGIN teacher1;
CREATE USER admin1 FOR LOGIN admin1;

-- 5. Kullanıcıları rollere ekle
ALTER ROLE StudentRole ADD MEMBER student1;
ALTER ROLE TeacherRole ADD MEMBER teacher1;
ALTER ROLE AdminRole ADD MEMBER admin1;

-- 6. Öğrenci Rolü: Öğrencilerin erişebileceği izinler
GRANT SELECT ON Students TO StudentRole;
GRANT SELECT ON Timetables TO StudentRole;
GRANT SELECT ON Exams TO StudentRole;
GRANT SELECT ON Attendances TO StudentRole;
GRANT SELECT ON Grades TO StudentRole;
GRANT SELECT ON RolePermissions TO StudentRole;


-- 7. Öğretmen Rolü: Öğretmenlerin erişebileceği izinler
GRANT SELECT, INSERT, UPDATE ON Courses TO TeacherRole;
GRANT SELECT, INSERT, UPDATE ON Attendances TO TeacherRole;
GRANT SELECT, INSERT, UPDATE ON Grades TO TeacherRole;
GRANT SELECT ON RolePermissions TO TeacherRole;
GRANT SELECT ON Students TO TeacherRole;  

-- 8. Yönetici Rolü: Yöneticilerin tüm tablolarda tam yetkiye sahip olması
GRANT SELECT, INSERT, UPDATE, DELETE, ALTER ON Departments TO AdminRole;
GRANT SELECT, INSERT, UPDATE, DELETE, ALTER ON Roles TO AdminRole;
GRANT SELECT, INSERT, UPDATE, DELETE, ALTER ON Teachers TO AdminRole;
GRANT SELECT, INSERT, UPDATE, DELETE, ALTER ON Students TO AdminRole;
GRANT SELECT, INSERT, UPDATE, DELETE, ALTER ON Admins TO AdminRole;
GRANT SELECT, INSERT, UPDATE, DELETE, ALTER ON RolePermissions TO AdminRole;
GRANT SELECT, INSERT, UPDATE, DELETE, ALTER ON Courses TO AdminRole;
GRANT SELECT, INSERT, UPDATE, DELETE, ALTER ON Classes TO AdminRole;
GRANT SELECT, INSERT, UPDATE, DELETE, ALTER ON Days TO AdminRole;
GRANT SELECT, INSERT, UPDATE, DELETE, ALTER ON Timetables TO AdminRole;
GRANT SELECT, INSERT, UPDATE, DELETE, ALTER ON Attendances TO AdminRole;
GRANT SELECT, INSERT, UPDATE, DELETE, ALTER ON Exams TO AdminRole;
GRANT SELECT, INSERT, UPDATE, DELETE, ALTER ON Grades TO AdminRole;
GRANT SELECT, INSERT, UPDATE, DELETE, ALTER ON Logs TO AdminRole;
GRANT SELECT, INSERT, UPDATE, DELETE, ALTER ON StudentAttendances TO AdminRole;
GRANT SELECT, INSERT, UPDATE, DELETE, ALTER ON CourseDepartments TO AdminRole;
GRANT SELECT, INSERT, UPDATE, DELETE, ALTER ON CourseTeachers TO AdminRole;
