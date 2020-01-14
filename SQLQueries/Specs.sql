create or alter PROCEDURE GetSpecsForProduct @product int as
select S.Name, SP.[Value]
from Specifications_Products as SP
inner join Specifications as S
on SP.Specification = S.ID
where SP.Product = @product

exec GetSpecsForProduct 2