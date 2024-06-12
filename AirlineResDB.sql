--SQL DDL

create table AIRPORT(
	Airport_code VARCHAR(3) primary key,
	Name varchar(40),
	City varchar(30),
	State varchar(3)
);

create table FLIGHT(
	Flight_number VARCHAR(6) primary key,
	Airlines varchar(10),
	Weekdays varchar(3)
);

create table FLIGHT_LEG(
	Flight_number VARCHAR(6) FOREIGN KEY REFERENCES FLIGHT(Flight_number),
	Leg_number INT check(Leg_number<=4),
	Departure_airport_code VARCHAR(3) FOREIGN KEY REFERENCES AIRPORT(Airport_code),
	Scheduled_departure_time time(4),
	Arrival_airport_code varchar(3) FOREIGN KEY REFERENCES AIRPORT(Airport_code),
	Scheduled_arrival_time time(4),
	primary key(Leg_number,Flight_number)
);

create table LEG_INSTANCE(
	Flight_number varchar(6),
	Leg_number int,
	_Date VARCHAR(10), 
	Number_of_available_seats numeric(3) check(Number_of_available_seats<=600), 
	Airplane_id numeric(3),
	Departure_airport_code varchar(3) FOREIGN KEY REFERENCES AIRPORT(Airport_code),
	Departure_time time(4), 
	Arrival_airport_code varchar(3) FOREIGN KEY REFERENCES AIRPORT(Airport_code),
	Arrival_time time(4),
	FOREIGN KEY (Leg_number,Flight_number) REFERENCES FLIGHT_LEG(Leg_number,Flight_number),
	primary key(_Date,Leg_number,Flight_number)
);

create table FARE(
	Flight_number VARCHAR(6) FOREIGN KEY REFERENCES FLIGHT(Flight_number),
	Fare_code char,
	Amount numeric(4) check(Amount>=0 AND Amount<=1000),
	Restrictions varchar(3),
	primary key(Fare_code,Flight_number)
);

create table AIRPLANE_TYPE(
	Airplane_type_name varchar(7) primary key,
	Max_seats numeric(3) check(Max_seats<=600),
	Company varchar(20)
);

create table CAN_LAND(
	Airplane_type_name varchar(7) FOREIGN KEY REFERENCES AIRPLANE_TYPE(Airplane_type_name),
	Airport_code varchar(3) FOREIGN KEY REFERENCES AIRPORT(Airport_code),
);

create table AIRPLANE(
	Airplane_id int primary key,
	Total_number_of_seats numeric(3) check(Total_number_of_seats<=600),
	Airplane_type varchar(7) FOREIGN KEY REFERENCES AIRPLANE_TYPE(Airplane_type_name)
);

create table SEAT_RESERVATION(
	Flight_number VARCHAR(6), 
	Leg_number INT, 
	_Date VARCHAR(10), 
	Seat_number varchar(3),
	Customer_name varchar(15),
	Customer_phone varchar(15),
	FOREIGN KEY (_Date,Leg_number,Flight_number) REFERENCES LEG_INSTANCE(_Date,Leg_number,Flight_number),
	primary key(_Date,Leg_number,Flight_number, Seat_number)
);

/*drop table SEAT_RESERVATION
drop table AIRPLANE
drop table CAN_LAND
drop table AIRPLANE_TYPE
drop table FARE
drop table LEG_INSTANCE
drop table FLIGHT_LEG
drop table AIRPORT
drop table FLIGHT

SELECT * FROM FLIGHT
SELECT * FROM AIRPORT
SELECT * FROM FLIGHT_LEG
SELECT * FROM LEG_INSTANCE
SELECT * FROM FARE
SELECT * FROM AIRPLANE_TYPE
SELECT * FROM CAN_LAND
SELECT * FROM AIRPLANE
SELECT * FROM SEAT_RESERVATION*/
