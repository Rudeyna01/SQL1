#SQL1
--1--
  
### 1. Giriş ve Temel Kavramlar
#### 1.1 Veri ve Veritabanı Nedir?
```sql
--Veri Nedir?
/*
    Bilgiyi ifade eder. İşlenmeye hazır ya da işlenmiş bilgi bütünüdür. 
    Metin, sayı, resim vb. araçlara veri denir.
*/

--Veritabanı Nedir?
/*
    Yapılandırılmış bir şekilde bilgiyi saklama, sorgulama, erişme sistemine denir.
*/

--Veritabanı Çeşitleri Nelerdir?
/*
    1. İlişkisel veritabanları: 
       Verilerin tablolar halinde ilişkilendirildiği veritabanı türüdür.
       Örnek: MySQL, MsSQL (Microsoft Server), Oracle, PostgreSQL

    2. Belge Tabanlı Veritabanları: 
       Verilerin belge halinde sunucuda (server) tutma ve erişme.
       Örnek: XML, JSON

    3. Anahtar-Değer (Key-Value) Veritabanları: 
       Basit veri yapılarıyla anahtar-değer (key-value) çiftleri ile veri saklama ve erişme.
       Örnek: Redis, Memcached

    4. Sütun Tabanlı Veritabanları: 
       Verileri sütunlarda saklayan ve genellikle veri analizi, veri işleme, grafik vb. konularda kullanılan veritabanlarıdır.
       Örnek: Excel, PowerBI

    5. Graf Veritabanları: 
       Verileri graf (node, edge) şeklinde ilişkilendirilen ve bu ilişkilerin modellenmesinde kullanılan veritabanı türüdür.
       Örnek: ArangoDB, Neo4j
*/
```

### 2. Veritabanı Oluşturma ve Yönetimi
#### 2.1 Veritabanı Oluşturma
```sql
--Kod ile Database Oluşturma (New Query)
Create database DenemeDb

--Adımları Takip Ederek Database Oluşturma
/*
    "Object Explorer" panelinde "Databases" sekmesine sağ tıklayıp "New Database" seçeneğini seçiyoruz.
    Açılan panelden "Database Name" kısmına veritabanı adını yazıp "OK" butona basıp veritabanı oluşturulur.
*/
```

#### 2.2 Veritabanı Seçimi
```sql
use VeriBilimiDb -- veri tabanı seçimi
go -- işleme devam et
```

#### 2.3 Veritabanı Silme
```sql
--Veritabanı silme
drop database DenemeDb

/*
    Adım adım veri tabanı silme:
    "Object Explorer" panelinden "Databases" sekmesi açılıp silinecek olan 
    veritabanına sağ tıklanır. "Delete" seçeneğine tıklayarak açılan panelden
    ilk önce "Close Existing Connections" seçeneğini tıklanır 
    ve "OK" butonuna basarak veritabanı silinir.
*/
```

### 3. Tablolarla Çalışma
#### 3.1 Tablo Oluşturma
```sql
--Tablo Oluşturma İşlemi
create table Product(
    Id int Primary Key Identity(1,1) not null,
    [Name] nvarchar(50),
    Information ntext,
    Price float,
    Stock int,
    IsStatus bit default 1
)
```

#### 3.2 Tabloya Kolon Ekleme
```sql
--Alter komutu - Yapısal Düzenleme Komutu
--Var olan tabloya kolon ekleme
alter table Product add Category nvarchar(50) 

--Var olan tabloya default değerli kolon ekleme
alter table Product add IsDelete bit default 0 --bit olarak 0 False değerine denk gelir
```

### 4. Veri Manipülasyonu (DML - Data Manipulation Language)
#### 4.1 Veri Ekleme (Insert)
```sql
--Tabloya veri ekleme - Insert
insert into Product([Name], Information, Price, Stock, Category)
values('MSI Oyun Bilgisayar', 'Tam bir oyun canavarı', 76500, 3, 'Bilgisayar')

insert into Product([Name], Information, Price, Stock, Category)
values('Iphone 15 Pro Max', 'Apple Iphone', 98000, 24, 'Telefon')
```

#### 4.2 Veri Güncelleme (Update)
```sql
--Veri güncelleme - Update
--Tüm verileri değiştirme
Update Product set Name='Monster Abra A7' 

--Belirli bir veriyi güncelleme
Update Product set Name='Monster Abra A7' where Id=7

--Birden fazla kolonu güncelleme
Update Product set Name='Monster Abra A8', Price=58750 where Id=7

--Tüm fiyatlara %20 zam yapma
update Product set Price=Price*1.2

--75000 TL üzeri ürünlere %10 indirim yapma
update Product set Price=Price*0.9 where Price>75000
```

#### 4.3 Veri Silme (Delete)
```sql
--Tablodan veri silme - Delete
Delete from Product -- Tablodaki bütün veriler silinir

Delete from Product where Id=1 -- where şartına göre istenilen veriyi silme
```

#### 4.4 Tüm Veriyi Sıfırlama (Truncate)
```sql
--Truncate Table - Tabloyu temizleme - sıfırlama
--Truncate tablodaki id değerini de 1 başlatacak şekilde sıfırlar
truncate table Product
```

### 5. Veri Sorgulama (Select)
#### 5.1 Basit Seçim İşlemleri
```sql
--Select işlemleri
--Bütün veriyi getirme
select * from Product

--Bir veri getirme
select * from Product where Id=5

--Verinin sadece bir kısmını getirme
select [Name], Price from Product
```

#### 5.2 Kolon İsimlendirme (Alias)
```sql
--Kolon isimlendirme (as)
select [Name] as UrunAdi, Price as Fiyat from Product

select [Name] as 'Ürün Adı', Price as 'Ürün Fiyatı' from Product
```

#### 5.3 Matematiksel İşlemler
```sql
--Kolonda matematiksel işlemler yapma
select [Name] as 'Ürün Adı', Price*1.18+120 as '%18 KDV Dahil Fiyat' from Product

select [Name] as 'Ürün Adı', Price*0.8+120 as '%20 İndirimli Fiyat' from Product

select [Name] as 'Ürün Adı', Price as 'Ürün Fiyatı', Price*1.18 as '%18 KDV Dahil Fiyat' from Product
```

#### 5.4 Veriyi Sıralama ve Filtreleme
```sql
--İlk 4 ürünü getirme - top kullanımı
select top(4) * from Product
```

### 6. Veri Manipülasyon Dili (DML) ve Veri Tanımlama Dili (DDL) Kavramları
```sql
--DML ve DDL Nedir?
/*
    DML - Data Manipulation Language - Veri Manipülasyon Dili

    select    -    seçim
    insert    -    ekleme
    delete    -    silme
    update    -    güncelleme

    Order by
    where
    like
    and - or
    Matematik fonksiyonları

    Tablolarda yapılan değişiklik, ekleme, silme ve sorgulama işlemlerine DML denir.
    Veri üzerinde yapılan değişiklikler.

    DDL - Data Definition Language - Yapılandırılmış Sorgu Dili

    create      - Oluşturma - Veritabanı ya da tablo oluşturma
    drop        - Kaldırma  - Veritabanı ya da tabloyu kaldırma-silme
    alter       - Düzenleme - Veritabanı ya da tabloda düzenlemeler
    truncate    - Sıfırlama - Veritabanı ve tablodaki verileri sıfırlama

    DDL, veritabanında yapılan düzenlemeleri oluşturma ve silme işlemlerini kapsar
*/

/*
    DML vs DDL
    - DML veri üzerinde çalışır.
    - DDL veritabanı ve tablolar üzerinde çalışır.
*/
```

### 7. Ek Bilgiler ve Veri Türleri
```sql
--Veri Türleri
/*
    nchar(10)
    telefon numaraları        nchar(11)
    posta kodu                nchar(5)
    tc kimlik no              nchar(11)
    seri numaraları
    pasaport numaraları
    
    nvarchar(10)
    (erhan)

    bit 
    1-0 > True-False > On-Off > High-Low > Evet-Hayır

    float
    kesirli-ondalıklı sayı

    int - bigint - smallint - tinyint
   

 tam sayı

    ntext
    unlimited - sınırsız string veri

    money
    para formatında değer alır
*/
```
