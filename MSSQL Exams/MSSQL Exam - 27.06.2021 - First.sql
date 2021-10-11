CREATE DATABASE WMS

USE WMS 

CREATE TABLE Clients(
	ClientId INT PRIMARY KEY IDENTITY,
	FirstName VARCHAR(50) NOT NULL,
	LastName VARCHAR(50) NOT NULL,
	Phone VARCHAR(12) CHECK(LEN(Phone) = 12)  NOT NULL
)

CREATE TABLE Mechanics(
	MechanicId INT PRIMARY KEY IDENTITY,
	FirstName VARCHAR(50) NOT NULL,
	LastName VARCHAR(50) NOT NULL,
	[Address]  VARCHAR(255) NOT NULL
)

CREATE TABLE Models(
	ModelId	INT PRIMARY KEY IDENTITY  NOT NULL,
	[Name]	VARCHAR(50) UNIQUE  NOT NULL
)

CREATE TABLE Jobs(
	JobId INT PRIMARY KEY IDENTITY  NOT NULL,
	ModelId INT REFERENCES Models(ModelId) NOT NULL,
	[Status] VARCHAR(11) 
	CHECK([Status] = 'Pending' OR [Status] = 'In Progress' OR [Status] = 'Finished') DEFAULT 'Pending' NOT NULL,
	ClientId INT REFERENCES Clients(ClientId) NOT NULL,
	MechanicId INT REFERENCES Mechanics(MechanicId),
	IssueDate DATETIME2 NOT NULL,
	FinishDate DATETIME2
)

CREATE TABLE Orders(
	OrderId INT PRIMARY KEY IDENTITY NOT NULL,
	JobId INT REFERENCES Jobs(Jobid) NOT NULL,
	IssueDate DATETIME2,
	Delivered BIT DEFAULT 0
)

CREATE TABLE Vendors(
	VendorId INT PRIMARY KEY IDENTITY NOT NULL,
	[Name] VARCHAR(50) UNIQUE NOT NULL
)

CREATE TABLE Parts(
	PartId INT PRIMARY KEY IDENTITY NOT NULL,
	SerialNumber VARCHAR(50) UNIQUE NOT NULL,
	[Description] VARCHAR(255),
	Price DECIMAL(16,2) CHECK(Price > 0) NOT NULL,
	VendorId INT REFERENCES Vendors(VendorId) NOT NULL,
	StockQty INT CHECK(StockQty >= 0) DEFAULT 0 NOT NULL
)

CREATE TABLE OrderParts(
	OrderId	INT REFERENCES Orders(OrderId) NOT NULL,
	PartId INT REFERENCES Parts(PartId) NOT NULL,
	Quantity INT CHECK(Quantity >= 0) DEFAULT 1 NOT NULL

	CONSTRAINT PK_Order_Part PRIMARY KEY (OrderId, PartId)
)

CREATE TABLE PartsNeeded(
	JobId	INT REFERENCES Jobs(JobId) NOT NULL,
	PartId INT REFERENCES Parts(PartId) NOT NULL,
	Quantity INT CHECK(Quantity >= 0) DEFAULT 1  NOT NULL
	
	CONSTRAINT PK_Job_Part PRIMARY KEY (JobId, PartId)
)

--02. Insert
INSERT INTO Clients(FirstName,LastName,Phone) VALUES
('Teri', 'Ennaco', '570-889-5187'),
('Merlyn', 'Lawler', '201-588-7810'),
('Georgene', 'Montezuma', '925-615-5185'),
('Jettie', 'Mconnell', '908-802-3564'),
('Lemuel', 'Latzke', '631-748-6479'),
('Melodie', 'Knipp', '805-690-1682'),
('Candida', 'Corbley', '908-275-8357')

INSERT INTO Parts(SerialNumber, [Description], Price, VendorId) VALUES
('WP8182119', 'Door Boot Seal',	117.86,	2),
('W10780048', 'Suspension Rod',	42.81,	1),
('W10841140', 'Silicone Adhesive ',	6.77,	4),
('WPY055980', 'High Temperature Adhesive',	13.94,	3)

--03. Update ID = 3
SELECT * FROM Jobs
	WHERE [Status] = 'Pending'

UPDATE Jobs
SET [Status] = 'In Progress', MechanicId = 3
WHERE [Status] = 'Pending'

--04. Delete
SELECT * FROM OrderParts
	WHERE OrderId = 19

DELETE OrderParts
	WHERE OrderId = 19

DELETE Orders
	WHERE OrderId = 19

