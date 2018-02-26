-- Workshop 1 a.
use Northwind;

select * from Shippers;

-- 1 b.
select * from Shippers order by CompanyName asc;

-- 2 a.
select FirstName, LastName, Title, BirthDate, Country from Employees;

-- 2 b.
select distinct Title from Employees

-- 3
select * from Orders where OrderDate = '1997-05-19';

-- 4
select * from Customers where City = 'London' OR City = 'Madrid';

--5
select CustomerID, CompanyName from Customers where Country = 'UK' order by CompanyName;

-- 6 
select OrderID, OrderDate from Orders where CustomerID = 'Hanar'; 

-- 7
select (TitleOfCourtesy + ' ' + FirstName + ' ' + LastName) from Employees;
	
-- 8
select o.OrderID, o.OrderDate
from Customers c Inner Join Orders o
on c.CustomerID = o.CustomerID
where c.CompanyName = 'Maison Dewey'

-- 9
select *
from Products
where ProductName like '%lager%';

--10
select c.CustomerID, c.CompanyName
from Customers c inner join Orders o
on c.CustomerID != o.CustomerID;

select c.CustomerID, c.CompanyName
from Customers c
where c.CustomerID NOT IN (select o.CustomerID from Orders o)

--11
select avg(UnitPrice) as AverageProductPrice
from Products;

--12
select distinct City
from Customers;

--13
select count(distinct CustomerID) as CustomerCount
from Orders

--14
select CompanyName, Phone
from Customers
where Fax is NULL

-- 15
select SUM(UnitPrice * Quantity) as TotalSales
from [Order Details];

--16
select o.OrderID
from Customers c INNER JOIN Orders o
on c.CustomerID = o.CustomerID
where c.CompanyName = 'Alan Out' OR CompanyName = 'Blone Coy';

--17
select c.CustomerID, COUNT(o.OrderID) as OrderCount
from Customers c INNER JOIN Orders o
on c.CustomerID = o.CustomerID
group by c.CustomerID;

--18
select c.CompanyName, o.OrderID
from Orders o INNER JOIN Customers c
on o.CustomerID = c.CustomerID
and o.CustomerID = 'BONAP';

--19 a.
select c.CustomerID, c.CompanyName, count(o.CustomerID) as OrderCount
from Customers c inner join Orders o
on o.CustomerID = c.CustomerID
group by c.CompanyName, c.CustomerID
having count(o.CustomerID) > 10
order by count(o.CustomerID) desc;

-- 19 b.
select c.CustomerID, c.CompanyName, COUNT(o.OrderID) as OrderCount
from Orders o inner join Customers c
on o.CustomerID = c.CustomerID
where c.CustomerID = 'BONAP'
Group by c.CustomerID, c.CompanyName;

--19 c.
select c.CustomerID, c.CompanyName, COUNT(o.OrderID) as OrderCount
from Orders o inner join Customers c
on o.CustomerID = c.CustomerID
group by c.CustomerID, c.CompanyName
having COUNT(o.OrderID) >
(select COUNT(oo.OrderID)
from Customers cc inner join Orders oo 
on cc.CustomerID = oo.CustomerID 
where cc.CustomerID = 'BONAP'
group by cc.CustomerID
);

-- 20 a
select *
from Products
where CategoryID in (1, 2)
order by ProductID, ProductName;

-- 20 b

-- join
select *
from Products p inner join Categories c
on p.CategoryID = c.CategoryID
where c.CategoryName = 'Beverages'
or c.CategoryName = 'Condiments';

-- sub query
select *
from Products p
where p.CategoryID in
(select c.CategoryID
from Categories c
where c.CategoryName ='Beverages'
or c.CategoryName = 'Condiments');

--21 a
select count(EmployeeID) as EmployeesCount
from Employees;

-- 21 b
select count(EmployeeID) as EmployeesNumberinUSA
from Employees
where Country = 'USA';

--22
select o.*
from Orders o inner join Employees e
on o.EmployeeID = e.EmployeeID
where e.Title = 'Sales Representative'
and o.ShipCountry = 'USA';

-- 23
select e1.*,
(select e2.FirstName + ' ' + e2.LastName 
from Employees e2 
where e2.EmployeeID = e1.ReportsTo) 
as Manager
from Employees e1;

--24
select *
from Products 
where Products.ProductID in
(
select top 5 (od.ProductID)
from [Order Details] od
order by Discount desc
);

--25
select c.CompanyName
from Customers c
where c.City
not in
(select distinct s.City 
from Suppliers s);

--26
select distinct c.City
from Customers c
where c.City
in
(select s.city from Suppliers s);

--27 a
select CompanyName, Address, Phone
from Customers
UNION
select CompanyName, Address, Phone
from Suppliers; 

--27 b
select CompanyName, Address, Phone
from Customers
UNION
select CompanyName, Address, Phone
from Suppliers
UNION
select CompanyName, NULL, Phone
from Shippers;

--28
select 
(select ee.FirstName from Employees ee where ee.EmployeeID = e.ReportsTo) as FirstName
from Employees e inner join Orders o
on e.EmployeeID = o.EmployeeID
where o.OrderID = 10248;

--29
select ProductID, ProductName, UnitPrice
from Products
where UnitPrice >
(select avg(UnitPrice)
from Products);

--30
select OrderID, sum(UnitPrice * Quantity) as Amount
from [Order Details]
group by OrderID
having sum(UnitPrice * Quantity) > 10000;

--31
select OrderID, CustomerID
from Orders
where OrderID in
(select OrderID
from [Order Details]
group by OrderID
having sum(UnitPrice * Quantity) > 10000);

--32
select o.OrderID, c.CustomerID, c.CompanyName
from Orders o, Customers c
where c.CustomerID = o.CustomerID
and o.OrderID in
(select OrderID
from [Order Details]
group by OrderID
having sum(UnitPrice * Quantity) > 10000);

--33
select o.CustomerID, sum(od.UnitPrice * od.Quantity) as Amount
from Orders o, [Order Details] od
where o.OrderID = od.OrderID
group by o.CustomerID;

--34
select AVG(R.Amount) as AverageAmount
from
(select o.CustomerID, sum(od.UnitPrice * od.Quantity) as Amount
from Orders o, [Order Details] od
where o.OrderID = od.OrderID
group by o.CustomerID) as R;

select sum(od.UnitPrice * od.Quantity) / count (distinct o.CustomerID) as AverageAmount
from Orders o, [Order Details] od
where o.OrderID = od.OrderID;

--35
select c.CustomerID, c.CompanyName
from Customers c, Orders o, [Order Details] od
where c.CustomerID = o.CustomerID
and o.OrderID = od.OrderID
group by c.CustomerID, c.CompanyName
having sum(od.UnitPrice * od.Quantity)
>
(select AVG(R.Amount) as AverageAmount
from
(select o.CustomerID, sum(od.UnitPrice * od.Quantity) as Amount
from Orders o, [Order Details] od
where o.OrderID = od.OrderID
group by o.CustomerID) as R);

--36
select o.CustomerID, sum(od.UnitPrice * od.Quantity) as Amount
from Orders o, [Order Details] od
where o.OrderID = od.OrderID
and year(o.OrderDate) = 1997
group by o.CustomerID;



 
