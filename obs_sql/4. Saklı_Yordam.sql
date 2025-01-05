CREATE PROCEDURE RegisterStudent
    @StudentNo NVARCHAR(50),
    @Name NVARCHAR(255),
    @Surname NVARCHAR(255),
    @DepartmentID INT,
    @AdvisorID INT
AS
BEGIN
    -- Geçerli bir department ID'sinin olup olmadığını kontrol et
    IF NOT EXISTS (
        SELECT 1 
        FROM Departments 
        WHERE ID = @DepartmentID
    )
    BEGIN
        PRINT 'Geçersiz departman ID. Öğrenci kaydı gerçekleştirilemiyor.';
        RETURN;
    END

    -- AdvisorID'nin geçerli bir öğretmen ID'si olup olmadığını kontrol et
    IF NOT EXISTS (
        SELECT 1 
        FROM Teachers 
        WHERE ID = @AdvisorID
    )
    BEGIN
        PRINT 'Geçersiz danışman ID. Öğrenci kaydı gerçekleştirilemiyor.';
        RETURN;
    END

    -- Öğrencinin benzersiz olup olmadığını kontrol et
    IF EXISTS (
        SELECT 1 
        FROM Students 
        WHERE StudentNo = @StudentNo
    )
    BEGIN
        PRINT 'Bu öğrenci numarası zaten kayıtlı.';
        RETURN;
    END

    -- Yeni öğrenci kaydı yap, RoleID her zaman 3 olacak
    INSERT INTO Students (StudentNo, Name, Surname, DepartmentID, AdvisorID, RoleID)
    VALUES (@StudentNo, @Name, @Surname, @DepartmentID, @AdvisorID, 3);

    PRINT 'Öğrenci başarıyla kaydedildi.';
END;
