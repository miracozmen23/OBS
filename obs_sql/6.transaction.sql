BEGIN TRANSACTION;

BEGIN TRY
    -- 1. Yeni bir ders ekle
    INSERT INTO Courses (CourseName, GradeLevel)
    VALUES ('Matematik 2', 3); -- Örnek ders

    -- Eklenen dersin ID'sini al
    DECLARE @NewCourseID INT;
    SET @NewCourseID = SCOPE_IDENTITY();

    -- 2. Bu dersin bir bölümle ilişkisini kur
    INSERT INTO CourseDepartments (CourseID, DepartmentID)
    VALUES (@NewCourseID, 1); -- Örnek olarak DepartmentID = 1

    -- 3. Bu dersin bir öğretmenle ilişkisini kur
    INSERT INTO CourseTeachers (CourseID, TeacherID)
    VALUES (@NewCourseID, 1); -- Örnek olarak TeacherID = 1

    -- 4. Derse ait bir sınav ekle
    INSERT INTO Exams (CourseID, Date, ExamType)
    VALUES (@NewCourseID, '2025-01-15', 'Midterm');

    -- Eklenen sınavın ID'sini al
    DECLARE @NewExamID INT;
    SET @NewExamID = SCOPE_IDENTITY();

    -- 5. Öğrenci notu eklemeden önce notun geçerli olup olmadığını kontrol et
    DECLARE @Score FLOAT;
    SET @Score = 105; -- Örnek: Geçersiz bir not (0-100 dışı)

    IF @Score < 0 OR @Score > 100
    BEGIN
        -- Hata mesajını konsola yazdır
        RAISERROR('Sınav notu 0 ile 100 arasında olmalıdır.', 16, 1);

        -- Hata fırlat
        THROW 50000, 'Sınav notu 0 ile 100 arasında olmalıdır.', 1;
    END

    -- Geçerli bir notsa, sınav notunu ekle
    INSERT INTO Grades (Score, StudentID, ExamID)
    VALUES (@Score, 1, @NewExamID); -- Örnek olarak StudentID = 1

    -- İşlemler başarılıysa transaction'ı onayla
    COMMIT TRANSACTION;

    PRINT 'İşlem başarıyla tamamlandı.';
END TRY

BEGIN CATCH
    -- Hata durumunda transaction'ı geri al
    ROLLBACK TRANSACTION;

    -- Hata detaylarını yakala ve mesaj göster
    DECLARE @ErrorMessage NVARCHAR(4000);
    DECLARE @ErrorSeverity INT;
    DECLARE @ErrorState INT;

    SELECT 
        @ErrorMessage = ERROR_MESSAGE(),
        @ErrorSeverity = ERROR_SEVERITY(),
        @ErrorState = ERROR_STATE();

    -- Hata mesajını kullanıcıya göster
    PRINT 'Tüm işlemler geri alındı.(ROLLBACK)';
    RAISERROR ('Hata: %s', @ErrorSeverity, @ErrorState, @ErrorMessage);
END CATCH;
