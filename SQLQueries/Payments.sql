select * from Payments;
select * from Orders

select * from vieworders

--Late payments
create or alter view ViewLatePayments as
Select ViewOrders.*
from ViewOrders
where ShippingDate + 30 < GETDATE() and 
(ViewOrders.LeftToPay > 0.49 or ViewOrders.LeftToPay is null) 
--om 49 öre avrundar vi det nedåt till 0 och skickar ingen påminnelse/straffavgift