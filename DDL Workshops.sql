-- DDL Manipulation

-- 1
create table MemberCategories
(
MemberCategory nvarchar(2),
MemberCatDescription nvarchar(200),
Primary Key (MemberCategory)
);

--2
insert into MemberCategories
(MemberCategory, MemberCatDescription)
values ('A', 'Class A Members'),
values ('B', 'Class B Members'),
values ('C', 'Class C Members');

--3
create table GoodCustomers
(
CustomerName nvarchar(50),
Address nvarchar(65),
PhoneNumber nvarchar(9),
MemberCategory nvarchar(2),
Primary Key (CustomerName, PhoneNumber),
Foreign Key MemberCategory references MemberCategories(MemberCategory)
);

--4
INSERT INTO GoodCustomers
CustomerName, PhoneNumber, MemberCategory)
SELECT CustomerName, PhoneNumber, MemberCategory
FROM Customers 
WHERE MemberCategory IN ('A', 'B');

--5
INSERT INTO GoodCustomers
VALUES ('Tracy Tan', NULL, '736572', 'B');

--6
INSERT INTO GoodCustomers
VALUES ('Grace Leong', '15 Bukit Purnei Road, Singapore 0904'
, '278865', 'A');

--7
INSERT INTO GoodCustomers
VALUES ('TGrace Leong', '15 Bukit Purnei Road, Singapore 0904'
, '278865', 'P');
---!!!!!!!ERRORR!!!!!!!!!!

--8
UPDATE GoodCustomers
SET Address = '22 Bukit Purmei Road, Singapore 0904'
WHERE CustomerName = 'Grace Leong';

--9
UPDATE GoodCustomers
SET MemberCategory = 'B'
WHERE CustomerName
IN
(
SELECT CustomerName 
FROM Customers
WHERE CustomerID = 5108
);

--10
DELETE FROM GoodCustomers
WHERE CustomerName = 'Grace Leong';

--11
DELETE FROM GoodCustomers
WHERE MemberCategory = 'B';

--12
ALTER TABLE GoodCustomers
ADD COLUMN FaxNumber NVARCHAR(80);

--13
ALTER Table GoodCustomers
ALTER COLUMN Address nvarchar(80);

--14
ALTER TABLE GoodCustomers
ADD COLUMN ICNumber nvarchar(10);

--15
CREATE UNIQUE INDEX ICIndex ON GoodCustomers
(ICNumber);

--16
CREATE INDEX faxindex ON GoodCustomers (FaxNumber);

--17
DROP INDEX faxindex;

--18
ALTER TABLE GoodCustomers
DROP COLUMN FaxNumber;

--19
DELETE FROM GoodCustomers;

--20
DROP TABLE GoodCustomer;











