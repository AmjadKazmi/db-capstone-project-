insert into Bookings (BookingID,TableNo, BookingSlot, StaffID, CustomerID) VALUES 
(6,6,'2023-10-10',3,1),
(7,3,'2023-11-12',3,3),
(8,2,'2023-10-11',2,2),
(9,2,'2023-10-13',2,1);

Select * from Bookings;

DELIMITER //
CREATE  PROCEDURE CheckBooking (IN dateInput Date, IN tableInput INT)
BEGIN
Select BookingStatus as 'Booking Status' from (Select BookingID, case when BookingID is not null then concat("table ",tableNo," is already booked")
When BookingID is NULL then concat("table ",tableNo,"is not booked") END as BookingStatus
from Bookings where BookingSlot=dateInput and TableNo=tableInput) as s;
END



CREATE PROCEDURE CheckTableBooking (booking_date DATE, table_number INT)
BEGIN
DECLARE bookedTable INT DEFAULT 0;
 SELECT COUNT(*)
    INTO bookedTable
    FROM Bookings WHERE BookingSlot = booking_date and TableNo = table_number;
    IF bookedTable > 0 THEN
      SELECT CONCAT( "Table ", table_number, " is already booked") AS "Booking status";
      ELSE 
      SELECT CONCAT( "Table ", table_number, " is not booked") AS "Booking status";
    END IF;
END

DELIMITER ;

call CheckBooking('2023-11-12',3);
call CheckTableBooking('2023-11-12',3);

DELIMITER //
CREATE  PROCEDURE AddValidBooking (IN Booking_Date Date, IN Table_No INT,IN Staff_ID INT, IN Customer_ID INT)
BEGIN
DECLARE BookingCount INT DEFAULT 0;
Select count(*) into BookingCount from Bookings where BookingSlot =Booking_Date and TableNo=Table_No;
START TRANSACTION;
IF BookingCount >0 THEN
   Select concat("Table ",Table_No," is already booked - booking cancelled") as 'Booking Status';
   rollback; 
ELSE
   Insert into Bookings (TableNo,BookingSlot,StaffID,CustomerID) VALUES (Table_No,Booking_Date,Staff_ID,Customer_ID);
   Select concat("Table ",Table_No," is booked") as 'Booking Status';
END IF ;  
   commit;  
END //

DELIMITER ;
call AddValidBooking('2023-10-18',3,3,3);


