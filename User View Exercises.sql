--use Northwind;
--• Exercise Userview 1
--• Create a View Customer1998 containing Customer IDs
--and names, Product IDs and names for customers who
--have made orders on the year 1998.

create view Customer1998
as
select c.CustomerID, c.CompanyName, od.ProductID, p.ProductName
from Customers c, Orders o, [Order Details] od, Products p
where c.CustomerID = o.CustomerID
and o.OrderID = od.OrderID
and p.ProductID = od.ProductID
and year(OrderDate) = 1998;


select * from Customer1998

--• Exercise Userview 2
--• Using the View Customer1998, retrieve the Customer
--name, Product name and supplier names for the
--Customers who have made orders on the year 1998
--according to Customer Name.
select c.CompanyName, p.ProductName, s.CompanyName as SupplierName
from Products p, Customer1998 c, Suppliers s
where p.ProductID = c.ProductID
and p.SupplierID = s.SupplierID
order by c.CompanyName;

--• Exercise Userview 3
--• Retrieve the Customer name and the number of
--products ordered by them in the year 1998.
select CompanyName, Count(*) as NumberofProductsOrdered
from Customer1998
group by CompanyName;

--• Exercise Userview 4
--a) Create an Userview to represent total business made by
--each customer. The userview includes two columns:
--– The sum of product’s unit price multiplied by quantity ordered by
--the customer
--– Customer id
create view CustomerTotalBusiness
as
select c.CustomerID, sum(od.UnitPrice * od.Quantity) as TotalBusiness
from Customers c, Orders o, [Order Details] od
where o.CustomerID = c.CustomerID
and o.OrderID = od.OrderID
group by c.CustomerID;


--b) Using the userview created, retrieve the Average
--Amount of business that a northwind customer provides.
--The Average Business is total amount for each customer
--divided by the number of customer.
select avg(TotalBusiness) as AverageAmountofBusiness
from CustomerTotalBusiness;