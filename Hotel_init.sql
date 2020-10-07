/*MySQL*/
DROP DATABASE IF EXISTS Hotel;
CREATE DATABASE Hotel;
USE Hotel;

CREATE TABLE Hotels(
`hotelID` int NOT NULL,
`hotelName` varchar(255) NOT NULL,
`hotelAddress` varchar(255) NOT NULL,
`hotelPostCode` varchar(255) NOT NULL,
`hotelFacilites` varchar(255) NOT NULL,
`phoneNo` varchar(15) NOT NULL,
`publicRating` decimal(3,2) NOT NULL,
`breakfastPrice` int NOT NULL,
`singlePrice` int NOT NULL,
`doublePrice` int NOT NULL,
`familyPrice` int NOT NULL,
`gracePeriod` int NOT NULL,
PRIMARY KEY (`hotelID`)
);


CREATE TABLE Customer(
`customerID` int NOT NULL AUTO_INCREMENT,
`fName` varchar(255) NOT NULL,
`lName` varchar(255) NOT NULL,
`phoneNo` varchar(15) NOT NULL,
`address` varchar(255) NOT NULL,
`postcode` varchar(255) NOT NULL,
`creditCardNo` varchar(19) NOT NULL,
`creditCardExpiration` varchar(19) NOT NULL,
`email` varchar(255) NOT NULL,

PRIMARY KEY (`customerID`)
);


CREATE TABLE Roomtype(
`roomType` varchar(255) NOT NULL,
`hotelID` int NOT NULL,
`roomPrice` int NOT NULL,
`discount` int NOT NULL,
PRIMARY KEY (`hotelID`,`roomType`),
FOREIGN KEY (`hotelID`) REFERENCES Hotels(`hotelID`)
);

CREATE TABLE Room(
`roomID` int NOT NULL,
`roomType` varchar(255) NOT NULL,
`hotelID` int NOT NULL,

PRIMARY KEY (`hotelID`, `roomID`),
FOREIGN KEY (`hotelID`) REFERENCES Hotels(`hotelID`)
);

CREATE TABLE Reservation(
`bookingReference` int NOT NULL AUTO_INCREMENT,
`hotelID` int NOT NULL, 
`bookingDate` date NOT NULL,
`arrivalDate` date NOT NULL,
`leavingDate` date NOT NULL,
`totalAmount` decimal(9,2) NOT NULL,
`paymentOption` varchar(255) NOT NULL,
`cardOrCash` varchar(255) NOT NULL,
`customerID` int NOT NULL,
`specialInstruction` varchar(255) NOT NULL,


PRIMARY KEY (`bookingReference`),
FOREIGN KEY (`hotelID`) REFERENCES Room(`hotelID`),
FOREIGN KEY (`customerID`) REFERENCES Customer(CustomerID)
);

CREATE TABLE ReservedRoom(
`hotelID` int NOT NULL,
`roomID` int NOT NULL, 
`bookingReference` int NOT NULL,
`numberOfAdults` int NOT NULL,
`numberOfChildren` int NOT NULL,
`breakfast` int NOT NULL,
`arrivalDate` date NOT NULL,
`leavingDate` date NOT NULL,
PRIMARY KEY (`roomID`,`bookingReference`),
FOREIGN KEY (`hotelID`,`roomID`) REFERENCES Room(`hotelID`,`roomID`),
FOREIGN KEY (`bookingReference`) REFERENCES Reservation(`bookingReference`)
);

CREATE TABLE Cancellation(
`cancelReservationID` int NOT NULL AUTO_INCREMENT,
`reason` varchar(255) NOT NULL,
`currentDate` date NOT NULL,
FOREIGN KEY (`cancelReservationID`) REFERENCES Reservation (`bookingReference`)
);

/* INSERTS */
USE Hotel;
INSERT INTO Hotels (`hotelID`, `hotelName`,`hotelAddress`,`hotelPostCode` ,`hotelFacilites`, `phoneNo`,`publicRating`,`breakfastPrice`,`singlePrice`,`doublePrice`,`familyPrice`,`gracePeriod`) VALUES
(1,'Finzels Reach','Finzels Reach, Bristol','BS1 6BX','Free parking, free Wi-Fi, air conditioned, lift access, breakfast-only restaurant, ', '0871 622 2428',9,12,100,150,175,14),
(2,'HayMarket','The Haymarket, Bristol','BS1 3LP','Chargeable parking,free Wi-Fi, air conditioned,restaurant ', '0871 527 8156',7.5,12,100,150,175,14),
(3,'King Street','Llandoger Trow, King Street, Bristol','BS1 4ER','Free parking,Free Wi-Fi, airconditioned, lift access, restaurant,', '0871 527 8158',9.5,8,75,120,150,7);

INSERT INTO Roomtype (`hotelID`,`roomType`,`roomPrice`, `discount`) VALUES
(1,'Single','100', 20),
(2,'Single','100', 20),
(3,'Single','75',40),
(1,'Double','150',30),
(2,'Double','150',30),
(3,'Double','120',40),
(1,'Family','175',35),
(2,'Family','175',35),
(3,'Family','150',45);

INSERT INTO Room(`roomID`,`roomType`, `hotelID`) VALUES
(1,'Single',1),
(2,'Double',1),
(3,'Family',1),
(4,'Single',2),
(5,'Double',2),
(6,'Family',2),
(7,'Single',3),
(8,'Double',3),
(9,'Family',3);

INSERT INTO Customer (`customerID`, `fName`,`lName`,`phoneNo`,`address`,`postcode`,`creditCardNo`,`creditCardExpiration`,`email`) VALUES
(1,'Ian','Cooper','07454245098','8 Grove Road, Exeter', 'EX4 6PN', '4546098711112340','10-2020','i.cooper@gmail,com'),
(2,'John','Smith','07385885324','7 Pinhoe Road, Exeter', 'EX1 2PL','4658098721234567','12-2021','johnsmith@smith.co.uk');

INSERT INTO Reservation (`bookingReference`,`hotelID`,`bookingDate`,`arrivalDate`,`leavingDate`,`totalAmount`,`paymentOption`,`cardOrCash`,`customerID`,`specialInstruction`) VALUES
(1,1, '2018-11-12','2018-12-26','2018-12-28',340,'Pay on arrival','Card',1,'No special instructions');

INSERT INTO ReservedRoom (`hotelID`,`roomID`,`bookingReference`,`numberOfAdults`,`numberOfChildren`,`breakfast`,`arrivalDate`,`leavingDate`) VALUES
(1,2,1,2,0,4,'2018-12-26','2018-12-28'),
(1,1,1,1,0,2,'2018-12-26','2018-12-28');
