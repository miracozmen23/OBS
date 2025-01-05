CREATE TRIGGER trg_Student_Delete
ON Students
AFTER DELETE
AS
BEGIN
    -- Silinen öğrenciyi log tablosuna kaydet
    INSERT INTO Logs (UserType, UserID, Action, Description, Timestamp)
    SELECT 
        'Student' AS UserType, -- Kullanıcı türü
        ID AS UserID,          -- Silinen öğrenci ID'si
        'DELETE' AS Action,    -- İşlem türü
        CONCAT('Öğrenci silindi: ', Name, ' ', Surname) AS Description, -- Açıklama
        GETDATE() AS Timestamp -- İşlem zamanı
    FROM 
        DELETED;
END;
