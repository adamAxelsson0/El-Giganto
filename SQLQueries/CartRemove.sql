--Remove old Carts (14 days)
Create or Alter Procedure RemoveOldCarts as
begin
delete from carts where WhenLastUpdated < GetDate() -14;
--Need to remove cartitems where cart was removed.
delete from cartitems where cart = null
end

exec removeoldcarts