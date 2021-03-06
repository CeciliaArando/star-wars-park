BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "tipo_de_promocion" (
	"tipo"	TEXT NOT NULL,
	PRIMARY KEY("tipo")
);
CREATE TABLE IF NOT EXISTS "atraccion" (
	"id"	INTEGER NOT NULL,
	"nombre"	TEXT,
	"fk_tipo"	TEXT,
	"costo"	REAL,
	"duracion"	REAL,
	"cupo"	INTEGER,
	FOREIGN KEY("fk_tipo") REFERENCES "tipo_de_atraccion"("tipo"),
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "promocion" (
	"id"	INTEGER NOT NULL,
	"fk_tipo_promo"	TEXT NOT NULL,
	"fk_tipo_atraccion"	TEXT NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("fk_tipo_promo") REFERENCES "tipo_de_promocion"("tipo"),
	FOREIGN KEY("fk_tipo_atraccion") REFERENCES "tipo_de_atraccion"("tipo")
);
CREATE TABLE IF NOT EXISTS "promocion_atraccion" (
	"fk_id_promocion"	INTEGER NOT NULL,
	"fk_id_atraccion"	INTEGER NOT NULL,
	FOREIGN KEY("fk_id_promocion") REFERENCES "promocion"("id"),
	PRIMARY KEY("fk_id_promocion","fk_id_atraccion"),
	FOREIGN KEY("fk_id_atraccion") REFERENCES "atraccion"("id")
);
CREATE TABLE IF NOT EXISTS "promocion_descuento" (
	"fk_id_promocion"	INTEGER,
	"descuento"	REAL,
	FOREIGN KEY("fk_id_promocion") REFERENCES "promocion"("id"),
	PRIMARY KEY("fk_id_promocion")
);
CREATE TABLE IF NOT EXISTS "promocion_atraccion_gratis" (
	"fk_id_promocion"	INTEGER,
	"fk_id_atraccion"	INTEGER,
	FOREIGN KEY("fk_id_atraccion") REFERENCES "atraccion"("id"),
	FOREIGN KEY("fk_id_promocion") REFERENCES "promocion"("id"),
	PRIMARY KEY("fk_id_promocion","fk_id_atraccion")
);
CREATE TABLE IF NOT EXISTS "itinerario" (
	"fk_id_visitante"	INTEGER NOT NULL,
	FOREIGN KEY("fk_id_visitante") REFERENCES "visitante"("id"),
	PRIMARY KEY("fk_id_visitante")
);
CREATE TABLE IF NOT EXISTS "itinerario_promocion" (
	"fk_id_itinerario"	INTEGER NOT NULL,
	"fk_id_promocion"	INTEGER NOT NULL,
	FOREIGN KEY("fk_id_itinerario") REFERENCES "itinerario"("fk_id_visitante"),
	PRIMARY KEY("fk_id_itinerario","fk_id_promocion"),
	FOREIGN KEY("fk_id_promocion") REFERENCES "promocion"("id")
);
CREATE TABLE IF NOT EXISTS "itinerario_atraccion" (
	"fk_id_itinerario"	INTEGER NOT NULL,
	"fk_id_atraccion"	INTEGER NOT NULL,
	PRIMARY KEY("fk_id_itinerario","fk_id_atraccion"),
	FOREIGN KEY("fk_id_atraccion") REFERENCES "atraccion"("id"),
	FOREIGN KEY("fk_id_itinerario") REFERENCES "itinerario"("fk_id_visitante")
);
CREATE TABLE IF NOT EXISTS "visitante" (
	"id"	INTEGER NOT NULL,
	"nombre"	TEXT,
	"fk_preferencia"	TEXT NOT NULL,
	"presupuesto"	REAL,
	"tiempo"	REAL,
	"usuario"	TEXT NOT NULL UNIQUE,
	"clave"	TEXT NOT NULL,
	"activo"	INTEGER NOT NULL,
	"admin"	INTEGER NOT NULL,
	FOREIGN KEY("fk_preferencia") REFERENCES "tipo_de_atraccion"("tipo"),
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "tipo_de_atraccion" (
	"tipo"	TEXT NOT NULL,
	"activo"	INTEGER NOT NULL DEFAULT 1,
	PRIMARY KEY("tipo")
);
INSERT INTO "tipo_de_promocion" ("tipo") VALUES ('ABSOLUTA');
INSERT INTO "tipo_de_promocion" ("tipo") VALUES ('PORCENTUAL');
INSERT INTO "tipo_de_promocion" ("tipo") VALUES ('AXB');
INSERT INTO "atraccion" ("id","nombre","fk_tipo","costo","duracion","cupo") VALUES (1,'Hoth','AVENTURA',10.0,2.0,6);
INSERT INTO "atraccion" ("id","nombre","fk_tipo","costo","duracion","cupo") VALUES (2,'Tatooine','PAISAJE',5.0,2.5,25);
INSERT INTO "atraccion" ("id","nombre","fk_tipo","costo","duracion","cupo") VALUES (3,'Coruscant','DEGUSTACION',3.0,6.5,150);
INSERT INTO "atraccion" ("id","nombre","fk_tipo","costo","duracion","cupo") VALUES (4,'Estrella de la Muerte','AVENTURA',25.0,3.0,4);
INSERT INTO "atraccion" ("id","nombre","fk_tipo","costo","duracion","cupo") VALUES (5,'Kashyyk','PAISAJE',5.0,2.0,15);
INSERT INTO "atraccion" ("id","nombre","fk_tipo","costo","duracion","cupo") VALUES (6,'Geonosis','DEGUSTACION',35.0,1.0,30);
INSERT INTO "atraccion" ("id","nombre","fk_tipo","costo","duracion","cupo") VALUES (7,'Naboo','PAISAJE',12.0,3.0,32);
INSERT INTO "atraccion" ("id","nombre","fk_tipo","costo","duracion","cupo") VALUES (8,'Kamino','AVENTURA',3.0,4.0,12);
INSERT INTO "promocion" ("id","fk_tipo_promo","fk_tipo_atraccion") VALUES (1,'PORCENTUAL','AVENTURA');
INSERT INTO "promocion" ("id","fk_tipo_promo","fk_tipo_atraccion") VALUES (2,'ABSOLUTA','DEGUSTACION');
INSERT INTO "promocion" ("id","fk_tipo_promo","fk_tipo_atraccion") VALUES (3,'AXB','PAISAJE');
INSERT INTO "promocion_atraccion" ("fk_id_promocion","fk_id_atraccion") VALUES (1,1);
INSERT INTO "promocion_atraccion" ("fk_id_promocion","fk_id_atraccion") VALUES (1,4);
INSERT INTO "promocion_atraccion" ("fk_id_promocion","fk_id_atraccion") VALUES (2,3);
INSERT INTO "promocion_atraccion" ("fk_id_promocion","fk_id_atraccion") VALUES (2,6);
INSERT INTO "promocion_atraccion" ("fk_id_promocion","fk_id_atraccion") VALUES (3,5);
INSERT INTO "promocion_atraccion" ("fk_id_promocion","fk_id_atraccion") VALUES (3,2);
INSERT INTO "promocion_descuento" ("fk_id_promocion","descuento") VALUES (1,0.2);
INSERT INTO "promocion_descuento" ("fk_id_promocion","descuento") VALUES (2,3.0);
INSERT INTO "promocion_atraccion_gratis" ("fk_id_promocion","fk_id_atraccion") VALUES (3,7);
INSERT INTO "visitante" ("id","nombre","fk_preferencia","presupuesto","tiempo","usuario","clave","activo","admin") VALUES (1,'Administrador','AVENTURA',100.0,8.0,'admin','admin',1,1);
INSERT INTO "visitante" ("id","nombre","fk_preferencia","presupuesto","tiempo","usuario","clave","activo","admin") VALUES (2,'Luke Skywalker','AVENTURA',100.0,8.0,'luke','luke',1,0);
INSERT INTO "visitante" ("id","nombre","fk_preferencia","presupuesto","tiempo","usuario","clave","activo","admin") VALUES (3,'Leia Organa','PAISAJE',100.0,8.0,'leia','leia',1,0);
INSERT INTO "visitante" ("id","nombre","fk_preferencia","presupuesto","tiempo","usuario","clave","activo","admin") VALUES (4,'Han Solo','DEGUSTACION',36.0,8.0,'han','han',1,0);
INSERT INTO "visitante" ("id","nombre","fk_preferencia","presupuesto","tiempo","usuario","clave","activo","admin") VALUES (5,'Chewbacca','PAISAJE',120.0,2.0,'chewbacca','chewbacca',1,0);
INSERT INTO "tipo_de_atraccion" ("tipo","activo") VALUES ('AVENTURA',1);
INSERT INTO "tipo_de_atraccion" ("tipo","activo") VALUES ('DEGUSTACION',0);
INSERT INTO "tipo_de_atraccion" ("tipo","activo") VALUES ('PAISAJE',1);
INSERT INTO "tipo_de_atraccion" ("tipo","activo") VALUES ('prueba',0);
COMMIT;
