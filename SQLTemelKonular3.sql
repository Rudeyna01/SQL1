#SQL3
--3--

Tabii, anlaşıldı. Özür dilerim, önceki mesajın İngilizce olması dışında bir yanlışlık oldu mu?

```sql
USE VBKutuphaneDb
GO

/*
    PnrNo ve Piece kolonlarına ilişkin veri eklenir
    insert into ReturnBook(PnrNo,Piece)
    values('VBK780055F',1)
*/
ALTER TRIGGER ReturnBookTrigger
ON ReturnBook
AFTER INSERT
AS
BEGIN
    DECLARE @PnrNo NVARCHAR(50)
    DECLARE @Piece INT
    DECLARE @BookId INT
    DECLARE @GiveBookPiece INT
    DECLARE @MemberId INT

    DECLARE @GiveDate DATE
    DECLARE @DeliveryDate DATE
    DECLARE @ReturnDate DATE
    DECLARE @Day INT
    DECLARE @ReturnDay INT
    DECLARE @PenaltyPrice FLOAT
    DECLARE @Balance FLOAT

    SELECT @PnrNo = PnrNo, @Piece = Piece, @ReturnDate = ReturnDate FROM inserted

    SELECT 
        @BookId = BookId, 
        @MemberId = MemberId, 
        @GiveBookPiece = Piece, 
        @GiveDate = GiveDate,
        @DeliveryDate = DeliveryDate
    FROM GiveBook 
    WHERE PnrNo = @PnrNo

    SET @Day = DATEDIFF(DAY, @GiveDate, @DeliveryDate)
    SET @ReturnDay = DATEDIFF(DAY, @GiveDate, @ReturnDate)

    IF (@Piece <= @GiveBookPiece)
    BEGIN
        UPDATE ReturnBook SET BookId = @BookId, MemberId = @MemberId WHERE PnrNo = @PnrNo

        -- Stok güncelleme
        UPDATE Stock SET Piece = Piece + @Piece WHERE BookId = @BookId

        -- GiveBook adet güncelleme
        UPDATE GiveBook SET Piece = Piece - @Piece WHERE PnrNo = @PnrNo
        
        -- Eğer kitap teslim tarihi geçildiyse
        IF (@Day < @ReturnDay)
        BEGIN
            SET @PenaltyPrice = (@ReturnDay - @Day) * 2 * @Piece
            SELECT @Balance = Balance FROM Members WHERE Id = @MemberId
            
            -- Bakiye kontrolü
            IF (@PenaltyPrice <= @Balance)
            BEGIN
                UPDATE Members SET Balance = Balance - @PenaltyPrice WHERE Id = @MemberId
                PRINT 'Kitaplar Geç Teslim Edildiği için ' + CAST(@PenaltyPrice AS NVARCHAR) + ' TL Para Ceza Kesildi.'
            END
            ELSE
            BEGIN
                PRINT 'Yetersiz Bakiye'
                PRINT 'Ceza Tutarı ' + CAST(@PenaltyPrice AS NVARCHAR) + ' TL dir. Bakiyeniz ' + CAST(@Balance AS NVARCHAR) + ' TL dir.'
                PRINT 'Lütfen Bakiye Yüklemesi Yapınız.'

                ROLLBACK TRANSACTION -- Bütün işlemleri geri al
            END
        END
        ELSE
        BEGIN 
            PRINT 'Kitap Zamanında Teslim Edildi'
            PRINT 'Kitap Başarılı Bir Şekilde Teslim Edildi'
        END

        -- Eğer elindeki bütün kitaplar teslim edilirse
        IF ((@GiveBookPiece - @Piece) = 0)
        BEGIN
            -- Kitap verildi olarak IsGive güncelleme
            UPDATE GiveBook SET IsGive = 1 WHERE PnrNo = @PnrNo
        END

    END
    ELSE
    BEGIN
        PRINT 'Teslim Edilen Kitap Adeti Ödünç Verilen Kitap Adetinden Fazla Olamaz.'
        ROLLBACK TRANSACTION -- Bütün işlemleri geri al
    END
END
```
