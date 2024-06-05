#SQL2
--2--
  
```sql
--Depo Yönetim Sistemi
/*
Tablolar:

    +Category
    +Product
    +Shelf
    +ProductShelf - iki tablonun birleştiği ortak tablo
    +Stock
    +Buy
    +Sell
*/

-- Veritabanı oluşturma
create database WareHouseManagementDb
go

-- Veritabanı seçimi
use WareHouseManagementDb
go

-- Category Tablosu
create table Category(
    Id int Primary Key Identity(1,1) not null,
    [Name] nvarchar(50)
)

-- Product Tablosu
create table Product(
    Id int Primary Key Identity(1,1) not null,
    [Name] nvarchar(50),
    Price float,
    CategoryId int,
    IsStatus bit default 1
)

-- Shelf Tablosu
create table Shelf(
    Id int Primary Key Identity(1,1) not null,
    [Name] nvarchar(50)
)

-- ProductShelf Tablosu
create table ProductShelf(
    Id int Primary Key Identity(1,1) not null,
    ShelfId int,
    ProductId int
)

-- Stock Tablosu
create table Stock(
    Id int Primary Key Identity(1,1) not null,
    ProductId int,
    Piece int    
)

-- Buy Tablosu
create table Buy(
    Id int Primary Key Identity(1,1) not null,
    ProductId int,
    Quantity int    
)

-- Sell Tablosu
create table Sell(
    Id int Primary Key Identity(1,1) not null,
    ProductId int,
    Quantity int    
)

-- Category Verileri
insert into Category([Name]) values('Telefon')        --1
insert into Category([Name]) values('Bilgisayar')    --2
insert into Category([Name]) values('Tv')            --3
insert into Category([Name]) values('Tablet')        --4
insert into Category([Name]) values('Beyaz Eşya')    --5

-- Product Verileri
insert into Product([Name],Price,CategoryId) values('Iphone 15 Pro Max',78000,1)
insert into Product([Name],Price,CategoryId) values('Xiaomi K70 Gaming',27000,1)
insert into Product([Name],Price,CategoryId) values('Samsung S22',45000,1)
insert into Product([Name],Price,CategoryId) values('Asus Rog Gaming Phone',62000,1)
insert into Product([Name],Price,CategoryId) values('Monster Abra A7',65750,2)
insert into Product([Name],Price,CategoryId) values('MSI Gaming Laptop',71250,2)
insert into Product([Name],Price,CategoryId) values('Asus Tuf Laptop',110000,2)
insert into Product([Name],Price,CategoryId) values('Apple Macbook Pro',58400,2)
insert into Product([Name],Price,CategoryId) values('Samsung Curved Tv',78000,3)
insert into Product([Name],Price,CategoryId) values('Vestel Oled Tv',7500,3)
insert into Product([Name],Price,CategoryId) values('Premier Tv',3250,3)
insert into Product([Name],Price,CategoryId) values('Samsung Tab10',18500,4)
insert into Product([Name],Price,CategoryId) values('Apple Ipad 3',5280,4)
insert into Product([Name],Price,CategoryId) values('Asus Gaming Tab',28500,4)
insert into Product([Name],Price,CategoryId) values('Samsung Nofrost Buzdolabı',25000,5)
insert into Product([Name],Price,CategoryId) values('Arçelik Bulaşık Makinesi',12500,5)
insert into Product([Name],Price,CategoryId) values('Vestel Kurutma Makinesi',18750,5)

-- Shelf Verileri
insert into Shelf([Name]) values('Kırmızı Raf')
insert into Shelf([Name]) values('Mavi Raf')
insert into Shelf([Name]) values('Yeşil Raf')
insert into Shelf([Name]) values('Siyah Raf')

-- ProductShelf Verileri
insert into ProductShelf(ProductId,ShelfId) values(1,1)
insert into ProductShelf(ProductId,ShelfId) values(2,1)
insert into ProductShelf(ProductId,ShelfId) values(3,2)
insert into ProductShelf(ProductId,ShelfId) values(4,2)
insert into ProductShelf(ProductId,ShelfId) values(5,1)
insert into ProductShelf(ProductId,ShelfId) values(6,3)
insert into ProductShelf(ProductId,ShelfId) values(7,3)
insert into ProductShelf(ProductId,ShelfId) values(8,2)
insert into ProductShelf(ProductId,ShelfId) values(9,1)
insert into ProductShelf(ProductId,ShelfId) values(10,1)
insert into ProductShelf(ProductId,ShelfId) values(11,2)
insert into ProductShelf(ProductId,ShelfId) values(12,4)
insert into ProductShelf(ProductId,ShelfId) values(13,4)
insert into ProductShelf(ProductId,ShelfId) values(14,3)
insert into ProductShelf(ProductId,ShelfId) values(15,4)
insert into ProductShelf(ProductId,ShelfId) values(16,2)
insert into ProductShelf(ProductId,ShelfId) values(17,1)

-- Stock Verileri
insert into Stock(ProductId,Piece) values(1,11)
insert into Stock(ProductId,Piece) values(2,5)
insert into Stock(ProductId,Piece) values(3,2)
insert into Stock(ProductId,Piece) values(4,8)
insert into Stock(ProductId,Piece) values(5,25)
insert into Stock(ProductId,Piece) values(6,34)
insert into Stock(ProductId,Piece) values(7,13)
insert into Stock(ProductId,Piece) values(8,7)
insert into Stock(ProductId,Piece) values(9,4)
insert into Stock(ProductId,Piece) values(10,19)
insert into Stock(ProductId,Piece) values(11,38)
insert into Stock(ProductId,Piece) values(12,11)
insert into Stock(ProductId,Piece) values(13,1)
insert into Stock(ProductId,Piece) values(14,22)
insert into Stock(ProductId,Piece) values(15,14)
insert into Stock(ProductId,Piece) values(16,35)
insert into Stock(ProductId,Piece) values(17,18)

-- Join - Tablo birleştirmeler
/*
    Birden fazla tablonun ortak noktasından birleştime işlemine denir.

    1. inner join    - tam eşleşme birleşimi
    2. left join    - sol tablo öncelikli birleşme
    3. right join   - sağ tablo öncelikli birleşme
    4. full join    - bütün birleştirme ve veriler getirme 
*/

-- inner join
select * from Product inner join Category on(Product.CategoryId=Category.Id)

-- inner join sınırlı veri çağırma
select Product.Id, Product.Name, Product.Price, Category.Name as CategoryName 
from Product 
inner join Category 
on(Product.CategoryId=Category.Id)

-- left join
select * from Product left join Stock on(Product.Id=Stock.ProductId)
/*
    soldaki tablonun bütün verilerini getirir.
    sağdaki tabloda karşılığı yoksa karşısına NULL yazar
*/

-- right join
select * from Product right join Category on(Product.CategoryId=Category.Id)
/*
    sağdaki tablonun bütün verilerini getirir.
    soldaki tabloda karşılığı yoksa karşısına NULL yazar
*/

-- full join
select * 
from Product as p
full join Category as c
on(p.CategoryId=c.Id)
full join Stock as s
on(p.Id=s.ProductId)

-- Örnek
select c.Name, COUNT(p.Id) as ProductCount, sum(p.Price*s.Piece) as TotalStockValue
from Product as p
full join Category as c
on(p.CategoryId=c.Id)
full join Stock as s
on(p.Id=s.ProductId)
Group by c.Name

-- Group by - Veri gruplama
select CategoryId, COUNT(*) as 'Ürün Adeti', SUM(Price) as 'Toplam Tutar' 
from Product 
group by CategoryId

-- Replace - Veri yer değiştirme
-- Id'si 3 Olan Tv Kategorisini Id'si 5 Olan Beyaz Eşya Kategorisine aktarma
update Product set CategoryId=REPLACE(CategoryId,3,5)
update Product set CategoryId=5 where CategoryId=3

-- Yuvarlama Round-Ceiling-Floor
select [Name], Price, ROUND(Price,0) from Product
select [Name], Price, CEILING(Price) from Product
select [Name], Price, FLOOR(Price) from Product

-- Order by - Sıralama işlemleri
select * from Product Order by [Name] asc
select * from Product Order by Price asc
select * from Product Order by Price desc
select top(1) * from Product Order by Price desc
select * from Product where Price=(select MAX(Price) from Product)

-- Küçüktür - Büyüktür - Eşittir - Küçük Eşittir - Büyük Eşittir Operatörleri
select * from Product where Price

<25000
select * from Product where Price>25000
select * from Product where Price=25000
select * from Product where Price<=25000
select * from Product where Price>=25000

-- In - Not in
select * from Product where CategoryId in(1,2,3,4)
select * from Product where CategoryId not in(1,2,3,4)
select * from Product where CategoryId not in(2,3)
```
