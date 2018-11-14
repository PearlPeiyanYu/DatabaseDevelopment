--City

CREATE TABLE Study4U_City (
ctyId VARCHAR(20) NOT NULL,
ctyName VARCHAR(100) ,
st VARCHAR(20), 
avgHTem numeric(10,2),
avgLTem numeric(10,2),
avgCostOfLiving numeric(10,2),
avgRent numeric(10,2),
avgMonthlyPass numeric(10,2),
avgOneWayFee numeric(10,2),
CONSTRAINT pk_Study4U_City_ctyId PRIMARY KEY (ctyId)
);

	

--School

CREATE TABLE Study4U_School (
 sclId VARCHAR(20) NOT NULL,
 sclName VARCHAR(100),
 sclTp VARCHAR(20),
 ctyId VARCHAR(20),
 clgName VARCHAR(100),
 clgSize VARCHAR(20),
 CONSTRAINT pk_Study4U_School_sclId PRIMARY KEY(sclId),
 CONSTRAINT fk_Study4U_School_ctyId  FOREIGN KEY (ctyId)
 REFERENCES Study4U_City (ctyId)
 ON DELETE SET NULL ON UPDATE CASCADE
);


--Program

Create Table [Study4U_Program] (
	prgId VARCHAR (20) NOT NULL,
	prgName VARCHAR (500) ,
	prgType VARCHAR (100) ,
	sclId VARCHAR (20) ,
	inStaTui INTEGER,	
	outStaTui INTEGER,
	prgLength INTEGER,
	optLength INTEGER,
CONSTRAINT pk_Program_prgId PRIMARY KEY (prgId),
CONSTRAINT fk_School_sclId FOREIGN KEY (sclId)
	REFERENCES [Study4U_School] (sclId)
	ON DELETE CASCADE ON UPDATE CASCADE 
	);


--sclrank

create table [Study4U_sclrank](
	cate VARCHAR(20) NOT NULL,
	yr date NOT NULL,
	sclRank INTEGER,
	sclId VARCHAR(20) NOT NULL,
	CONSTRAINT pk_sclrank_cate_yr_sclId PRIMARY KEY (cate,yr,sclId),
	CONSTRAINT fk_sclrank_schId FOREIGN KEY (sclId)
		REFERENCES [Study4U_School] (sclId)
		ON DELETE NO ACTION ON UPDATE NO ACTION
);



--prgrank

create table [Study4U_prgrank](
	cate VARCHAR(20) NOT NULL,
	yr date NOT NULL,
	prgRank INTEGER,
	prgId VARCHAR(20) NOT NULL,
	CONSTRAINT pk_prgrank_cate_yr_prgId PRIMARY KEY (cate,yr,prgId),
	CONSTRAINT fk_prgrank_prgId FOREIGN KEY (prgId)
		REFERENCES [Study4U_Program] (prgId)
		ON DELETE NO ACTION ON UPDATE NO ACTION
);
