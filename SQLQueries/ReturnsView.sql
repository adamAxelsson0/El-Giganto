create or alter view ViewReturns as
select r.ID, r.OrderItem, r.Reason, r.ReturnDate, s.Status
from Returns as r
inner join ReturnStatuses as s
on r.Status = s.ID

select * from viewreturns