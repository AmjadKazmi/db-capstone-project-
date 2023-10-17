Select * from Bookings;

DELIMITER //
CREATE DEFINER=`capStoneUser`@`localhost` PROCEDURE `AddBooking`(IN bookingId INT, IN customerId INT, IN tableNo INT, IN staffId INT, IN bookingDate Date)
BEGIN
INSERT into Bookings (BookingID, TableNo, BookingSlot, StaffID,CustomerID) VALUE (bookingId,tableNo,bookingDate,staffId,customerId);
Select "New booking added" as Confirmation;
END//
DELIMITER ;
call AddBooking(10,2,2,4,'2023-12-30')

DELIMITER //
CREATE PROCEDURE UpdateBooking (IN bookingId INT, IN bookingDate DATE)
BEGIN
Update Bookings set BookingSlot=bookingDate where BookingID=bookingId;
Select concat("Booking ",bookingId," updated");
END

DELIMITER ;

call UpdateBooking(9,'2023-11-13');

DELIMITER //
CREATE PROCEDURE CancelBooking (IN bookingID INT)
BEGIN
Delete from Bookings where BookingID =bookingID;
Select concat("Booking ",bookingID," cancelled");
END
DELIMITER ;

call CancelBooking(34);


