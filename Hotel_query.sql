/*MySQL*/
USE Hotel;

/*A
List all Bristol hotels with public rating higher than 8.5 and with free parking.
*/
SELECT 
Hotels.hotelName AS `Hotel Name`,
Hotels.hotelAddress AS `address`,
Hotels.hotelFacilites AS `facilities`
FROM Hotels
WHERE publicRating > 8.5
AND Hotels.hotelFacilites LIKE '%Free parking%'
AND Hotels.hotelAddress LIKE '%Bristol%';

/*B
List all available double rooms in all Bristol hotels on
26/12/2018, ordered by the price without breakfasts,
offering basic room information and hotel information
(Note: the price must be the price after discount, if any).
*/
SELECT Room.roomID,Room.hotelID, (SELECT IF ((DATEDIFF("20181226",CURDATE()) >= Hotels.gracePeriod), (Roomtype.roomPrice * (100 - Roomtype.discount) / 100), Roomtype.roomPrice))
                                                                AS DiscountsApplied,
                                                                Hotels.hotelName, Roomtype.roomPrice AS BasePrice, Hotels.gracePeriod, Room.roomType, Roomtype.discount
FROM Room, Roomtype, Hotels
WHERE Room.hotelID = Hotels.hotelID
AND Roomtype.hotelID = Hotels.hotelID
AND Roomtype.roomType = Room.roomType
AND Room.roomType LIKE '%Double%'
AND Hotels.hotelAddress LIKE '%Bristol%';

/*C
Display Ian Cooper’s booking information, and how
much he has paid (suppose he has paid online right after
booking).
*/
SELECT Reservation.bookingReference,Reservation.hotelID,Reservation.bookingDate,Reservation.arrivalDate,Reservation.leavingDate,Reservation.totalAmount, Hotels.hotelName
FROM Reservation, Hotels
WHERE Reservation.hotelID = Hotels.hotelID;

/*D
Find all the hotels whose double bedroom prices are
higher than the average double bedroom price on
26/12/2018. (Note: the price must be the price after
discount, if any). 
*/
SELECT Roomtype.hotelID,Hotels.hotelName
FROM Roomtype, Hotels
WHERE Roomtype.roomType = 'Double'
AND Hotels.hotelID = Roomtype.hotelID
AND Roomtype.roomPrice > (SELECT AVG((SELECT IF (Roomtype.discount != NULL 
																		AND DATEDIFF("20181226", CURDATE()) >= Hotels.gracePeriod, Roomtype.roomPrice * (100 - Roomtype.discount) / 100, Roomtype.roomPrice)
																		)) AS PriceOnDate
												FROM Roomtype
												WHERE Roomtype.roomType = 'Double');

/*E
Produce a booking status report on all the rooms in the
Finzels Reach Hotel on 26/12/2018.
*/
SELECT Hotels.hotelName, Room.roomID, (SELECT IF ( COUNT((SELECT '' FROM Reservation WHERE reservedRoom.bookingReference = Reservation.bookingReference AND Room.roomID = reservedRoom.roomID
										AND "20181226" BETWEEN reservedRoom.arrivalDate AND reservedRoom.leavingDate)) > 0,
				"Booked",
                "Available")
		) Status
FROM Hotels, ReservedRoom, Room
WHERE Hotels.hotelName = "Finzels Reach" AND Room.hotelID = Hotels.hotelID 
GROUP BY Room.roomID;


/*F
List how many rooms there are in the Finzels Reach Hotel
for each room type (i.e., family, double, twin, single).
*/
SELECT COUNT(Room.roomID) Count,Room.roomType
FROM Room, Hotels
WHERE Room.hotelID = Hotels.hotelID AND Hotels.hotelName = "Finzels Reach"
GROUP BY Room.roomType;

/*G
Count how many adult guests will be staying in the
Finzels Reach Hotel on 26/12/2018.
*/
SELECT SUM(ReservedRoom.numberOfAdults) NumberOfAdults, Hotels.hotelName
FROM ReservedRoom, Hotels
WHERE ReservedRoom.hotelID = Hotels.hotelID AND Hotels.hotelName = "Finzels Reach"
GROUP BY ReservedRoom.hotelID;

/*H
Unfortunately we didnt work out how to do this question
*/

/*I
List how many breakfasts have been ordered in the
Finzels Reach hotel on 26/12/2018.
*/
SELECT SUM(ReservedRoom.breakfast/DATEDIFF(ReservedRoom.leavingDate,ReservedRoom.arrivalDate)) AS TotalBreakfasts, Hotels.hotelName
FROM ReservedRoom, Hotels
WHERE ReservedRoom.hotelID = Hotels.hotelID AND Hotels.hotelName = "Finzels Reach" AND  "20181226" BETWEEN ReservedRoom.arrivalDate AND ReservedRoom.leavingDate
GROUP BY Hotels.hotelName;












