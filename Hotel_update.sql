/*MySQL*/
USE Hotel;
/*A. Update the public rating of the Finzels Reach Hotel to be
8.0.*/
UPDATE Hotels AS H 
SET H.publicRating = 8 
WHERE H.hotelID = 1;

/*B. Joe Smiths booked a double bed in the Finzels Reach
Hotel today, the check-in date is 26/12/2018, the checkout
date is 29/12/2018, 1 adult and 1 child, with breakfast.
He chose to ‘pay on arrival’.*/
INSERT INTO Customer (`customerID`, `fName`,`lName`,`phoneNo`,`address`,`postcode`,`creditCardNo`,`creditCardExpiration`,`email`) VALUES
(3,'Joe','Smiths',07474902781, '13 Park Lane, Bristol','BS409RT',9173849174231234,'11-2020','joesmiths@gmail.com');
INSERT INTO Reservation (`bookingReference`,`hotelID`,`bookingDate`,`arrivalDate`,`leavingDate`,`totalAmount`,`paymentOption`,`cardOrCash`,`customerID`,`specialInstruction`) VALUES
(3,1,current_date(),'2018-12-26','2018-12-29',150,'pay on arrival','Card',3,'');
INSERT INTO ReservedRoom (`hotelID`,`roomID`,`bookingReference`,`numberOfAdults`,`numberOfChildren`,`breakfast`,`arrivalDate`,`leavingDate`) VALUES
(1,2,3,1,1,6,'2018-12-26','2018-12-29');

/*C. Mr. Ian Cooper had a booking which has been paid online.
Today he would like to cancel his booking by offering the
booking ID.*/
INSERT INTO cancellation(`cancelReservationID`,`reason`,`currentDate`)VALUES
(1,'No Reason Given',current_date());
DELETE FROM ReservedRoom WHERE bookingReference = 1;

/*D. Today, the Finzels Reach Hotel would like to decrease the
discount of all family rooms to 5%, keeping the same
grace period as before.*/
UPDATE roomType AS RT
SET RT.discount = 5 
WHERE RT.hotelID = 1;
/*E. Because of refurbishment, all the rooms’ state on the first
floor (starting with digit 1) in the Finzels Reach Hotel are
changed to ‘unavailable’ from 01/6/2019 to 10/6/2019.*/
INSERT INTO Customer (`customerID`, `fName`,`lName`,`phoneNo`,`address`,`postcode`,`creditCardNo`,`creditCardExpiration`,`email`) VALUES
(4,'REFURBISHMENT','NA',0000000000,'NA','NA',0000000000000000,'11-1111','REFURBISHMENT');
INSERT INTO Reservation (`bookingReference`,`hotelID`,`bookingDate`,`arrivalDate`,`leavingDate`,`totalAmount`,`paymentOption`,`cardOrCash`,`customerID`,`specialInstruction`) VALUES
(4,1,current_date(),'2019-06-01','2019-06-10',0,'NA','NA',4,'REFURBISHMENT');
INSERT INTO ReservedRoom (`hotelID`,`roomID`,`bookingReference`,`numberOfAdults`,`numberOfChildren`,`breakfast`,`arrivalDate`,`leavingDate`) VALUES
(1,1,4,0,0,0,'2019-06-01','2019-06-10');
