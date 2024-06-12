--SQL QUERIES

--A) 
SELECT Flight_number as 'Flight Number', (SELECT Name FROM AIRPORT WHERE Airport_code = Departure_airport_code) as 'Airport Name'
FROM FLIGHT_LEG;

--B) 

select F.Flight_number, F.Weekdays 
from FLIGHT F join LEG_INSTANCE LI
on F.Flight_number=LI.Flight_number
where Departure_airport_code='ont' and Arrival_airport_code='lax'

--C)

select distinct FL.Flight_number, FL.Departure_airport_code, FL.Scheduled_departure_time, FL.Arrival_airport_code, FL.Scheduled_arrival_time, F.Weekdays
from FLIGHT F 
join FLIGHT_LEG FL 
on FL.Flight_number=F.Flight_number
join AIRPORT A
on FL.Departure_airport_code = (
	select Airport_code
	from AIRPORT A
	where A.City='Ontario') AND FL.Arrival_airport_code = (
									select Airport_code
									from AIRPORT A
									where A.City='Los Angeles')

--D) 

Select * 
from FARE
where Flight_number='UA560'

--E) 

Select Number_of_available_seats as 'Available Seats'
from LEG_INSTANCE
where Flight_number='DL1149' AND _Date='_Date'

--F) 

select TA.Airplane_type_name
from AIRPLANE_TYPE TA
join CAN_LAND CL
on TA.Airplane_type_name=CL.Airplane_type_name
where Airport_code=(
	select Airport_code 
	from AIRPORT
	where Name='Washington-Dulles-International' )


--G)

select Flight_number, Departure_airport_code, Arrival_airport_code, Departure_time, Arrival_time
from LEG_INSTANCE
where	
		Leg_number=1 AND Number_of_available_seats>2 AND _Date='2018-02-09'
AND 
		Departure_airport_code=(
		select Airport_code
		from AIRPORT A
		where A.Name='Chicago-OHare-International' ) 
AND 
		Arrival_airport_code=(
		select Airport_code
		from AIRPORT A
		where A.Name='San-Diego-International')



--H) 

Select Flight_number
From LEG_INSTANCE
where Departure_airport_code='MDW' AND Arrival_airport_code ='IAD' AND _Date='2018-08-05' AND Leg_number=1

--I) 

Select Avg(F.Amount) as 'Average Price'
FROM FARE F 
JOIN LEG_INSTANCE LI
ON LI.Flight_number=F.Flight_number

--J) 

select A.City, count( LI.Flight_number ) AS 'No. of Flights'
from LEG_INSTANCE LI JOIN AIRPORT A
on LI.Departure_airport_code=A.Airport_code
group by A.City 

--K)

SELECT Customer_name, Count(Seat_number) AS Tickets 
FROM SEAT_RESERVATION
GROUP BY Customer_name 
HAVING Count(Customer_name) >= all( SELECT COUNT(Customer_name)
FROM SEAT_RESERVATION
GROUP BY Customer_name)

--L)
Select distinct SR.Customer_name, SR.Customer_phone, SR.Flight_Number, Departure_time,Arrival_time,
		DATEADD(hour,1,LI.Departure_time) as 'Delayed Dep Time',
		DATEADD(hour,1, LI.Arrival_time) as 'Delayed Arr Time'
From SEAT_RESERVATION SR JOIN LEG_INSTANCE LI
on SR.Flight_Number=LI.Flight_Number 
where Departure_airport_code='SFO' AND LI.Arrival_airport_code='ORD'AND SR._Date='2018-08-05';


--M)
SELECT LI.Flight_Number, 
(Select City From Airport where Airport_code = LI.Departure_airport_code) As 'Departure Airport', 
(Select City From Airport where Airport_code = LI.Arrival_airport_code) As 'Arrival Airport', 
F.Amount 
From LEG_INSTANCE LI JOIN FARE F ON LI.Flight_Number = F.Flight_Number 
WHERE MONTH(_Date) = 1;

--N) 
SELECT Flight_Number, Departure_time, Arrival_time,
(Select City From Airport where Airport_code = Departure_airport_code) As 'Departure Airport', 
(Select City From Airport where Airport_code = Arrival_airport_code) As 'Arrival Airport',
DATEDIFF(minute, Departure_time, Arrival_time) As 'Duration'  
From LEG_INSTANCE
WHERE ABS(DATEDIFF(minute, Departure_time, Arrival_time)) <= 70;

--O)
select Customer_name, Max(Customer_phone), COUNT(*) As 'No Of Bookings' 
from SEAT_RESERVATION  
group by Customer_name
having count(Customer_name) in (select max(most.highest) 
from 
(select count(Customer_name) as Highest from SEAT_RESERVATION group by Customer_name) as Most);