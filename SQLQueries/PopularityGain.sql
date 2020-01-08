--Gain 1p when URL selected in HTML
Create or alter procedure GainPopWhenSelected @product int as
insert into ProductPopularityLogs(Product, Popularity, LogDate)
values(@product, 1, GETDATE());

exec GainPopWhenSelected