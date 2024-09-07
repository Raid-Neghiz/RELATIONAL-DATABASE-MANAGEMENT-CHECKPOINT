CREATE TABLE Wine(
    NumW INT PRIMARY KEY , 
    Category VARCHAR(25) NOT NULL ,
    Year INT NOT NULL ,
    Degree FLOAT NOT NULL 
) ;


CREATE TABLE Producer(
    NumP INT PRIMARY KEY ,
    FirstName VARCHAR(25) NOT NULL ,
    LastName VARCHAR(25) NOT NULL , 
    Region VARCHAR(25) NOT NULL 
) ;


CREATE TABLE Harvest(
    PRIMARY KEY (NumW , NumP ) ,
    NumW INT FOREIGN KEY REFERENCES Wine (NumW) ,
    NumP INT FOREIGN KEY REFERENCES Producer (NumP) ,
    Quantity INT NOT NULL 
) ; 


-- INSERTING DATA INTO THE TABLES : 

INSERT INTO Wine VALUES (1,'Red',2019 ,13.5) , (2,'White',2020,12.0) , (3, 'Rose', 2018, 11.5) ,(4, 'Red', 2021, 14.0) , (5, 'Sparkling', 2017, 10.5) ,(6, 'White', 2019, 12.5) ,(7, 'Red', 2022, 13.0) ,(8, 'Rose', 2020, 11.0) ,(9, 'Red', 2018, 12.0) ,(10, 'Sparkling', 2019, 10.0) ,(11, 'White', 2021, 11.5) ,(12, 'Red', 2022, 15.0) ;

INSERT INTO Producer VALUES (1, 'John', 'Smith', 'Sousse') ,(2, 'Emma', 'Johnson', 'Tunis') ,(3, 'Michael', 'Williams', 'Sfax') ,(4, 'Emily', 'Brown', 'Sousse') ,(5, 'James', 'Jones', 'Sousse') ,(6, 'Sarah', 'Davis', 'Tunis') ,(7, 'David', 'Miller', 'Sfax') ,(8, 'Olivia', 'Wilson', 'Monastir') , (9, 'Daniel', 'Moore', 'Sousse') ,(10, 'Sophia', 'Taylor', 'Tunis') ,(11, 'Matthew', 'Anderson', 'Sfax') ,(12, 'Amelia', 'Thomas', 'Sousse') ;

INSERT INTO Harvest (NumW, NumP, Quantity) VALUES (1, 1, 1000);
INSERT INTO Harvest (NumW, NumP, Quantity) VALUES (2, 2, 1500);
INSERT INTO Harvest (NumW, NumP, Quantity) VALUES (3, 3, 1200);
INSERT INTO Harvest (NumW, NumP, Quantity) VALUES (4, 4, 1300);
INSERT INTO Harvest (NumW, NumP, Quantity) VALUES (5, 5, 900);
INSERT INTO Harvest (NumW, NumP, Quantity) VALUES (6, 6, 1100);
INSERT INTO Harvest (NumW, NumP, Quantity) VALUES (7, 7, 1400);
INSERT INTO Harvest (NumW, NumP, Quantity) VALUES (8, 8, 1000);
INSERT INTO Harvest (NumW, NumP, Quantity) VALUES (9, 9, 1050);
INSERT INTO Harvest (NumW, NumP, Quantity) VALUES (10, 10, 980);
INSERT INTO Harvest (NumW, NumP, Quantity) VALUES (11, 11, 1130);
INSERT INTO Harvest (NumW, NumP, Quantity) VALUES (12, 12, 1270);
INSERT INTO Harvest (NumW, NumP, Quantity) VALUES (1, 2, 950);
INSERT INTO Harvest (NumW, NumP, Quantity) VALUES (3, 4, 1010);
INSERT INTO Harvest (NumW, NumP, Quantity) VALUES (6, 5, 1500);
INSERT INTO Harvest (NumW, NumP, Quantity) VALUES (7, 1, 1360);


SELECT * FROM Producer ;

SELECT * FROM Producer
ORDER BY FirstName ;

-- THE list of producers from Sousse :
SELECT *  
FROM Producer 
WHERE Region = 'Sousse' ;

--Calculate the total quantity of wine produced with the wine number 12 : 
SELECT NumW , SUM(Quantity) AS the_total_quantity_of_wine
FROM Harvest
GROUP BY NumW 
HAVING NumW = 12 ; 

--Calculate the quantity of wine produced for each category :
SELECT  W.Category , SUM(H.Quantity) AS the_quantity_of_wine_produced
FROM Harvest H
JOIN Wine W 
ON H.NumW = W.NumW
GROUP BY W.Category ;

--Find producers in the Sousse region who have harvested at least one wine in quantities greater than 300 liters :

SELECT H.NumP , P.FirstName , P.LastName , H.Quantity
FROM Producer P
JOIN Harvest H
ON P.NumP = H.NumP
WHERE P.Region = 'Sousse' AND H.Quantity > 300 
ORDER BY P.FirstName ASC ;


--List the wine numbers with a degree greater than 12, produced by producer number 24 : 

SELECT W.NumW ,W.Degree ,P.FirstName , P.LastName 
FROM Wine W 
JOIN Harvest H 
ON W.NumW = H.NumW 
JOIN Producer P 
ON H.NumP = P.NumP 
WHERE W.Degree > 12 AND P.NumP = 24 ;


--Find the producer who has produced the highest quantity of wine : 
SELECT Producer.NumP ,Producer.FirstName,Producer.LastName ,Harvest.Quantity 
FROM Producer
JOIN Harvest
ON Producer.NumP = Harvest.NumP 
WHERE Harvest.Quantity = (SELECT MAX(Harvest.Quantity)
                          FROM Harvest ) ;


--FIND THE AVERAGE DEGREE OF WINE PRODUCED : 
SELECT AVG(W.Degree) AS The_Average_Degree_Of_Wine_Produced
FROM Wine W
JOIN Harvest H
ON W.NumW = H.NumW
WHERE W.NumW IN (SELECT NumW
                 FROM Harvest)  ;    


--Find the oldest wine in the database : 
SELECT Wine.NumW , YEAR 
FROM Wine
WHERE Year = (SELECT MIN(YEAR )
              FROM Wine ) ;



--Retrieve a list of producers along with the total quantity of wine they have produced :

SELECT P.NumP  , SUM(H.Quantity) AS the_total_quantity_of_wine
FROM Producer P
JOIN Harvest H 
ON P.NumP = H.NumP 
GROUP BY P.NumP  ; 


--Retrieve a list of wines along with their producer details : 
SELECT W.NumW , P.*
FROM Producer P 
JOIN Harvest H 
ON P.NumP = H.NumP 
JOIN Wine W 
ON H.NumW = W.NumW ; 













