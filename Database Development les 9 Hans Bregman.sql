drop table if exists product;
drop table if exists Users;
drop table if exists television;
drop table if exists remoteController;
drop table if exists ciModule;
drop table if exists wallBracket;

create table users (
username varchar(36),
password varchar(255),
adres varchar(255),
funtie varchar(36),
loonschaal int,
vakantiedagen int
);

insert into users (username,password,adres,funtie,loonschaal,vakantiedagen)
values
('WillieWartaal123','Wortel333','Isingstraat 179, 2522 JT Den Haag','Markting medewerker',7,15),
('Pieter.O.verwerkt33','AdemInAdemUit123','Nassaustraat 47, 7513 BV Enschede','Elders',10,-27);

create table product (
product_id serial primary key,
name varchar(100),
brand varchar(100),
price DOUBLE PRECISION,
currentStock int,
sold int,
dateSold date,
type varchar(55)
);

insert into product (name, brand, price,currentStock, sold, dateSold, type)
values 
('Remoter9001','TELLSELL',12.23, 90001, 2, '2025-01-01','RemoteController'),
('C0NT0LL3R','TELLSELL',14.44, 3301, 5, '2025-02-01','RemoteController'),
('Samsung QLED 43Q64D (2024)','SAMSUNG',699.99, 201, 5, '2025-02-01','Television'),
('Quantis CI+ 1.4 TV Module','Quantis',54.59, 40, 5, '2025-02-01','ciModule'),
('BlueBuilt Swivel Wall Mount','BlueBuilt',79.99, 20, 8, '2025-02-01','WallBracket');

create table television (
tv_id serial primary key,
heigth DOUBLE PRECISION,
width  DOUBLE PRECISION,
schermKwaliteit varchar(55),
schermType varchar(55),
wifi boolean,
smartTv boolean,
voiceControl boolean,
HDR boolean,
product_id int,
FOREIGN KEY (product_id) REFERENCES product(product_id)
);

insert into television (heigth, width, schermKwaliteit,
schermType, wifi, smartTv, voiceControl, HDR, product_id)
values (70.3, 144.2, 'Zeer goed','LED-LCD', true, true, false, true, 3);

create table remoteController (
remoteController_id serial primary key,
smart boolean,
batteryType varchar(36),
product_id int,
FOREIGN KEY (product_id) REFERENCES product(product_id),
tv_id int,
FOREIGN KEY (tv_id) REFERENCES television(tv_id)
);

insert into remoteController ( smart, batteryType, product_id,tv_id)
values (true,'AA', 1, 1),(false,'AAA',2, 1);

create table ciModule (
ciModule_id serial primary key,
provider varchar(55),
encoding varchar(55),
product_id int,
FOREIGN KEY (product_id) REFERENCES product(product_id),
tv_id int,
FOREIGN KEY (tv_id) REFERENCES television(tv_id)
);

insert into ciModule ( provider, encoding, product_id, tv_id)
values ('ZIGGO','FFE8829HG', 4, 1);

create table wallBracket (
adjustable boolean,
bevestigingsmethode varchar(55),
heigth DOUBLE PRECISION,
width  DOUBLE PRECISION,
product_id int,
FOREIGN KEY (product_id) REFERENCES product(product_id),
tv_id int,
FOREIGN KEY (tv_id) REFERENCES television(tv_id)
);

insert into wallBracket ( adjustable, bevestigingsmethode, heigth, width, product_id, tv_id)
values (true,'Draai- en kantelbaar', 105.2, 188.2, 5, 1);

-- select * from product;
-- select * from users;
-- select * from television;
-- select * from remoteController;
-- select * from ciModule;
-- select * from wallBracket;

SELECT 
    p.product_id AS Product_ID,
    p.name AS Product_Name,
    p.brand AS Brand,
    p.price AS Price,
    p.currentStock AS Current_Stock,
    p.sold AS Sold_Units,
    p.dateSold AS Date_Sold,
    p.type AS Product_Type,
    
    -- Television details
    t.tv_id AS Television_ID,
    t.heigth AS Television_Height,
    t.width AS Television_Width,
    t.schermKwaliteit AS Screen_Quality,
    t.schermType AS Screen_Type,
    t.wifi AS Wifi_Support,
    t.smartTv AS Smart_TV,
    t.voiceControl AS Voice_Control,
    t.HDR AS HDR_Support,
    
    -- Remote Controller details
    rc.remoteController_id AS RemoteController_ID,
    rc.smart AS Remote_Smart,
    rc.batteryType AS Remote_Battery_Type,
    rc.tv_id AS Linked_Television_ID,
    
    -- CI Module details
    cm.ciModule_id AS CIModule_ID,
    cm.provider AS CIModule_Provider,
    cm.encoding AS CIModule_Encoding,
    cm.tv_id AS Linked_Television_ID,
    
    -- Wall Bracket details
    wb.adjustable AS WallBracket_Adjustable,
    wb.bevestigingsmethode AS WallBracket_Method,
    wb.heigth AS WallBracket_Height,
    wb.width AS WallBracket_Width,
    wb.tv_id AS Linked_Television_ID
FROM 
    product p
LEFT JOIN television t ON p.product_id = t.product_id
LEFT JOIN remoteController rc ON p.product_id = rc.product_id
LEFT JOIN ciModule cm ON p.product_id = cm.product_id
LEFT JOIN wallBracket wb ON p.product_id = wb.product_id;
