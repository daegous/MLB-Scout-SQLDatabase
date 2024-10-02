/*Programmer: Diego Saenz*/
/*Course: ITSE-2309-7P2*/

/*Creating Database*/
CREATE DATABASE MLBProspect;
USE MLBProspect;

/*Creating tables*/
CREATE TABLE Player
(
    Player_ID int PRIMARY KEY AUTO_INCREMENT,
    First_Name varchar(100) NOT NULL,
    Last_Name varchar(100) NOT NULL,
    Hometown varchar(50) NOT NULL,
    Age int NOT NULL,
    Height_In_CM int NOT NULL,
    Weight_In_Pounds int NOT NULL
);

CREATE TABLE Positions
(
Position_Id int PRIMARY KEY NOT NULL,
Position_Name varchar(20) NOT NULL,
Position_Description text(100) NOT NULL
);

CREATE TABLE Player_Preferred_Hand
(
Player_Perf_Hand_ID int PRIMARY KEY AUTO_INCREMENT,
Player_ID int NOT NULL,
FOREIGN KEY (Player_Id) REFERENCES Player(Player_ID),
Position_Id int NOT NULL,
FOREIGN KEY (Position_Id) REFERENCES Positions(Position_ID),
Batting_Hand char,
Throwing_Hand char
);

CREATE TABLE Player_Stats
(
Stat_Id int PRIMARY KEY AUTO_INCREMENT,
Batting_Avg decimal(3,3),
OBS decimal(3,3),
HR_Hit int,
RBI int,
Strikeouts int,
Walks int,
HR_Allowed int,
Innings_Pitched int,
Saves int,
Player_Id int NOT NULL,
FOREIGN KEY (Player_Id) REFERENCES Player(Player_ID)
);

/*Inserting data*/
INSERT INTO Player VALUES
(DEFAULT, 'Corey' , 'Julks' , 'Friendswood' , 28, 180, 185),
(DEFAULT,'Jose' , 'Altuve' , 'Maracay' , 33, 168, 166),
(DEFAULT,'Josh' , 'Hader' , 'Millersville' , 29, 190, 220),
(DEFAULT,'Yainer' , 'Diaz' , 'Azua' , 25, 183, 195),
(DEFAULT,'Justin' , 'Verlander' , 'Manakin' , 41, 196, 235),
(DEFAULT,'Carlos' , 'Correa' , 'Ponce' , 29, 193, 220),
(DEFAULT,'Jermey' , 'Pena' , 'Santo_Domingo' , 26, 183, 202),
(DEFAULT,'Yordan' , 'Alvarez' , 'Las_Tunas' , 26, 196, 225),
(DEFAULT,'Maurico' , 'Dubon' , 'San_Pedro_Sula' , 29, 182, 173),
(DEFAULT,'Framber' , 'Valdez' , 'Sabana' , 30, 179, 239);

INSERT INTO Positions VALUES
(7, 'Right_Field', 'Plays the left side outfield, usually the fastest and quick minded on the field'),
(4, 'Second_Base', 'Plays the middle infield, typically the fastest hands on the field'),
(12, 'MR_Pitcher' , 'The MR, pitches the ball to the batter to get outs for as long as he can in the middle of the closer and Starter'),
(2, 'Catcher' , 'Catches the ball from the pitcher, Catchers are always the smartest man on the field'),
(11, 'Starting_Pitcher', 'The Starter, pitches the ball to the batter to get outs for as long as he can'),
(6, 'Shortstop', 'Plays the middle infield, as the strongest arm and great range of defense'),
(60, 'Shortstop', 'Plays the middle infield, as the strongest arm and great range of defense'),
(70, 'Right_Field', 'Plays the right side of outfield, usually the strongest arm on the team'),
(8, 'Center_Field' , 'Plays the center of the outfield, he commands the outfielders and is almost always the best defender'),
(13, 'Closing_Pitcher' , 'The Closer, comes in after the starters or relivers and shuts down the team at the end');

INSERT INTO Player_Preferred_Hand VALUES 
(DEFAULT, 1, 7, 'R', 'R'),
(DEFAULT, 2, 4, 'R', 'R'),
(DEFAULT, 3, 12, NULL, 'L'),
(DEFAULT, 4, 2, 'R', 'R'),
(DEFAULT, 5, 11, NULL, 'R'),
(DEFAULT, 6, 6, 'R', 'R'),
(DEFAULT, 7, 60, 'R', 'R'),
(DEFAULT, 8, 70, 'L', 'L'),
(DEFAULT, 9, 8, 'R', 'R'),
(DEFAULT, 10, 13, NULL, 'L');

INSERT INTO Player_Stats VALUES
(DEFAULT, .245, .183, 6, 33, NULL, NULL, NULL, NULL, NULL, 1),
(DEFAULT, .311, .393, 31, 51, NULL, NULL, NULL, NULL, NULL, 2),
(DEFAULT, NULL, NULL, NULL, NULL, 85, 21, 3, 56, 33, 3),
(DEFAULT, .462, .293, 16, 34, NULL, NULL, NULL, NULL, NULL, 4),
(DEFAULT, NULL, NULL, NULL, NULL, 144, 45, 19, 116, NULL, 5),
(DEFAULT, .270, .301, 18, 32, NULL, NULL, NULL, NULL, NULL, 6),
(DEFAULT, .301, .382, 20, 36, NULL, NULL, NULL, NULL, NULL, 7),
(DEFAULT, .242, .316, 34, 49, NULL, NULL, NULL, NULL, NULL, 8),
(DEFAULT, .230, .280, 22, 41, NULL, NULL, NULL, NULL, NULL, 9),
(DEFAULT, NULL, NULL, NULL, NULL, 101, 31, 14, 121, NULL, 10);


/*Select statements*/
/*Shows the players information for players who are under 200 pounds*/
SELECT Player_ID, First_Name, Last_Name, Hometown
FROM Player
WHERE Weight_In_Pounds < 200
GROUP BY Player_ID, First_Name, Last_Name, Hometown, Height_In_CM;

/*Averages age in the player table*/
SELECT COUNT(Player_ID) AS Player_Count, AVG(Age) AS Average_Age
FROM Player;

/*Shows the stats for all batters*/
SELECT CONCAT(P.First_Name, ' ', P.Last_Name) AS Name, Pos.Position_Name, PS.Batting_Avg, PS.OBS, PS.HR_Hit, PS.RBI, PPH.Batting_Hand, PPH.Throwing_Hand
FROM Player AS P
JOIN Player_Preferred_Hand AS PPH ON P.Player_ID = PPH.Player_Id
JOIN Positions AS Pos ON PPH.Position_Id = Pos.Position_Id
JOIN Player_Stats AS PS ON P.Player_ID = PS.Player_Id
WHERE Pos.Position_Name NOT IN ('Starting_Pitcher', 'Closing_Pitcher', 'MR_Pitcher');

/*Shows the stats for all pitchers*/
SELECT CONCAT(P.First_Name, ' ', P.Last_Name) AS Name, PS.Innings_Pitched, PS.HR_Allowed, PS.Strikeouts, PS.Walks, PS.Saves
FROM Player AS P
JOIN Player_Stats AS PS ON P.Player_ID = PS.Player_Id
JOIN Player_Preferred_Hand AS PPH ON P.Player_ID = PPH.Player_Id
JOIN Positions AS Pos ON PPH.Position_Id = Pos.Position_Id
WHERE Pos.Position_Name IN ('Starting_Pitcher', 'Closing_Pitcher', 'MR_Pitcher');

/*Shows the postions for all players and the postion description*/
SELECT CONCAT(P.First_Name, ' ', P.Last_Name) AS Name, Pos.Position_Name, Pos.Position_Description
FROM Player AS P
JOIN Player_Preferred_Hand AS PPH ON P.Player_ID = PPH.Player_Id
JOIN Positions AS Pos ON PPH.Position_Id = Pos.Position_Id
JOIN Player_Stats AS PS ON P.Player_ID = PS.Player_Id;

/*Drop Table statements*/
DROP TABLE Player_Preferred_Hand;
DROP TABLE Positions;
DROP TABLE Player_Stats;
DROP TABLE Player;

/*Drop Database*/
DROP DATABASE mlbprospect;








