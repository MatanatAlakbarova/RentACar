CREATE DATABASE RentACar

USE RentACar

CREATE TABLE Customers(
	Id int primary key identity,
	Fullname nvarchar(100),
	DrivingCardNumber nvarchar(25),
	PhoneNumber nvarchar(25)
)

INSERT INTO Customers(Fullname, DrivingCardNumber,PhoneNumber)
VALUES	('Matanat Alakbarova','AA10AA','0606666666'),
		('Aysel Alakbarova','BB10AA','0606666665'),
		('Asya Alakbarova','CC10AA','0606466666'),
		('Efsane Alakbarova','DD10AA','0606666866'),
		('Shebnem Alakbarova','EE10AA','0606676666')


CREATE TABLE CarTypes(
	Id int primary key identity,
	Type nvarchar(30)
)

INSERT INTO CarTypes
VALUES  ('ECONOM CLASS'),
		('BUSINESS CLASS'),
		('CROSSOVER / SUV'),
		('BUS / MICROBUS')

CREATE TABLE Cars(
	Id int primary key identity,
	Marka nvarchar(50),
	Model nvarchar(50),
	Year int,
	Passengers int,
	CarTypeId int references CarTypes(Id)
)

INSERT INTO Cars(Marka,Model,Year,Passengers,CarTypeId)
VALUES  ('TOYOTA','COROLLA',2014,5,1),
		('KIA','K5',2022,5,2),
		('HYUNDAI','TUCSON',2019,5,3),
		('MERCEDES BENZ','G-CLASS',2015,5,3),
		('MERCEDES','VIANO',2017,7,4)

CREATE TABLE CarsStatus(
	Id int primary key identity,
	Status nvarchar(50)
)

INSERT INTO CarsStatus
VALUES  ('Rezerved'),
		('NonRezerved')

CREATE TABLE Rezervations(
	Id int primary key identity,
	PickUpLocation nvarchar(100),
	DropOffLocation	nvarchar(100),
	PickUpDate datetime,
	DropOffDate datetime,
	CarStatusId int references CarsStatus(Id),
	CarId int references Cars(Id),
	CustomerId int references Customers(Id)
)

INSERT INTO Rezervations(PickUpLocation,DropOffLocation,PickUpDate,
DropOffDate,CarStatusId,CarId,CustomerId)
VALUES  ('City Center','28 Mall','2022-01-29 02:40:00','2022-01-31 12:00:00',1,1,1),
		('City Center','RentACar Office','2022-01-29 12:40:00','2022-01-30 14:00:00',1,2,2),
		('City Center','28 Mall','2022-01-30 11:00:00','2022-01-31 13:00:00',1,3,3),
		('City Center','City Center','2022-01-29 11:40:00','2022-01-31 12:00:00',1,4,4)

CREATE TABLE UpdateRezervations(
	Id int primary key identity,
	PickUpLocation nvarchar(100),
	DropOffLocation	nvarchar(100),
	PickUpDate datetime,
	DropOffDate datetime,
	CarStatusId int references CarsStatus(Id),
	CarId int references Cars(Id),
	RezervationId int references Rezervations(Id)
)

CREATE TABLE ServiceExtras(
	Id int primary key identity,
	Extra nvarchar(50)
)
INSERT INTO ServiceExtras
VALUES  ('ADDITIONAL DRIVER'),
		('GPS NAVIGATOR'),
		('CHILD SEAT')

CREATE TABLE ServiceCharges(
	Id int primary key identity,
	Amount decimal(10,2),
	ServiceExtraId int references ServiceExtras(Id),
	RezervationId int references Rezervations(Id)
)

INSERT INTO ServiceCharges(Amount,ServiceExtraId,RezervationId)
VALUES  (15,1,1),
		(10,3,1),
		(15,1,2),
		(10,2,2),
		(15,1,3),
		(10,3,4)


CREATE TABLE PaymentTypes(
	Id int primary key identity,
	Type nvarchar(50)
)

INSERT INTO PaymentTypes
VALUES  ('Cash'),
		('Credit cards'),
		('Mobile payments'),
		('Electronic bank transfers')

CREATE TABLE Payments(
	Id int primary key identity,
	Amount decimal(10,2),
	RezervationId int references Rezervations(Id),
	PaymentTypeId int references PaymentTypes(Id)
)

INSERT INTO Payments(Amount,RezervationId,PaymentTypeId)
VALUES  (105,1,1),
		(200,2,4),
		(255,3,3),
		(320,4,2)


SELECT CS.Fullname 'Customer',C.Marka,C.Model,C.Year,CT.Type,R.PickUpLocation,
R.DropOffLocation ,R.PickUpDate,R.DropOffDate,P.Amount,PT.Type,
CarsStatus.Status FROM Cars C

JOIN CarTypes CT ON C.CarTypeId=CT.Id
JOIN Rezervations R ON R.CarId=C.Id
JOIN Customers CS ON R.CustomerId=CS.Id
JOIN Payments P ON P.RezervationId=R.Id
JOIN PaymentTypes PT ON P.PaymentTypeId=PT.Id
JOIN CarsStatus ON R.CarStatusId=CarsStatus.Id






