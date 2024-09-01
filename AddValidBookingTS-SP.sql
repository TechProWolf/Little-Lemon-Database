CREATE DEFINER=`metauser`@`%` PROCEDURE `AddValidBooking`(p_BookingDate DATE, p_TableNumber int)
BEGIN

DECLARE v_tablestatus INT;

    START TRANSACTION;

    SELECT COUNT(*)
    INTO v_tablestatus
    FROM Bookings
    WHERE Date = DATE(p_BookingDate) AND TableNumber = p_TableNumber;

    IF v_tablestatus = 0 THEN
        INSERT INTO Bookings (Date, TableNumber)
        VALUES (p_BookingDate, p_TableNumber);

        COMMIT;
        SELECT CONCAT('Table ',p_TableNumber,' - Booking added successfully for ',p_BookingDate) AS 'Booking Status';
    ELSE
        ROLLBACK;
        SELECT CONCAT('Table ',p_TableNumber, ' is already booked - booking cancelled') AS 'Booking Status';
    END IF;

END