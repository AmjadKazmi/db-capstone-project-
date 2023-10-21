
-- --Creating a Order View 
CREATE VIEW `OrderView` as select OrderID, Quantity,BillAmount from little_lemon.Orders where Ouantity>2;

select * from OrderView;
 
-- -- Join query
select Customers.CustomerID, concat(Customers.FirstName,' ',Customers.LastName) as FullName, Orders.OrderID, 
Orders.BillAmount as Cost ,Menus.MenuName, MenuItems.CourseName from Orders inner join 
Customers on Orders.CustomerID=Customers.CustomerID inner join Menus on Orders.MenuID=Menus.MenuID
inner join MenuItems on Menus.ItemID=MenuItems.ItemID
where Orders.BillAmount  > 150.00 order by Orders.BillAmount desc;

-- -- Menu Name where quantity is more than 
select MenuName from Menus where MenuID = any(select MenuID from Orders where Quantity >2);


-- -- Maximum Quanity from order procedure
delimiter //

Create Procedure GetMaxQuantity() 
BEGIN Select Max(Quantity) as 'Max Quantity in Order'  from Orders; 
END //

call GetMaxQuantity();

-- -- Prepare statement for getting order details using Customer ID
Prepare GetOrderDetail from 'Select OrderID, Quantity, BillAmount as Cost from Orders where CustomerID=?'
Set @id=1;
Execute GetOrderDetail using @id;


-- -- Procedure for Deleting the order record
Create Procedure CancelOrder (IN ID INT) 
BEGIN 
Delete from Orders where OrderID =ID; 
END
