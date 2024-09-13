SET FOREIGN_KEY_CHECKS = 0;
SET AUTOCOMMIT = 0;

DROP TABLE IF EXISTS `Addresses`;
CREATE TABLE Addresses (
    `idAddress` int(11) AUTO_INCREMENT,
    `idStudent` int(11) NOT NULL,
    `streetName` varchar(100) NOT NULL,
    `city` varchar(20) NOT NULL,
    `state` varchar(20) NOT NULL,
    `zipCode` int(11) NOT NULL,
    `country` varchar(45) NOT NULL,
    PRIMARY KEY (idAddress),
    FOREIGN KEY (idStudent) REFERENCES Students(idStudent) ON DELETE CASCADE
); 

DROP TABLE IF EXISTS `Classrooms`;
CREATE TABLE `Classrooms` (
    `idClassroom` int(11) NOT NULL AUTO_INCREMENT,
    `totalSeats` int(11) NOT NULL,
    `building` varchar(45) NOT NULL,
    `roomNumber` int(11) NOT NULL,
    PRIMARY KEY (idClassroom)
);


DROP TABLE IF EXISTS `Courses`;
CREATE TABLE `Courses` (
    `idCourse` int(11) NOT NULL AUTO_INCREMENT,
    `idClassroom` int(11) DEFAULT NULL,
    `idProfessor` int(11) NOT NULL,
    `title` varchar(45) NOT NULL,
    `description` varchar(200) NOT NULL,
    `creditHours` int(11) NOT NULL,
    `prerequisites` varchar(45) DEFAULT NULL,
    `totalEnrolled` int(11) NOT NULL,
    `meetingTime` varchar(45) DEFAULT NULL,
    `online` tinyint(4) NOT NULL,
    PRIMARY KEY (idCourse),
    FOREIGN KEY (idClassroom) REFERENCES Classrooms(idClassroom) ON DELETE CASCADE,
    FOREIGN KEY (idProfessor) REFERENCES Professors(idProfessor) ON DELETE CASCADE
);

DROP TABLE IF EXISTS `CourseSchedules`;
CREATE TABLE `CourseSchedules` (
  `idCourseSchedule` int(11) NOT NULL AUTO_INCREMENT,
  `idSchedule` int(11) NOT NULL,
  `idCourse` int(11) NOT NULL,
  `grade` varchar(2) DEFAULT NULL,
  PRIMARY KEY (idCourseSchedule),
  FOREIGN KEY (idSchedule) REFERENCES Schedules(idSchedule)  ON DELETE CASCADE,
  FOREIGN KEY (idCourse) REFERENCES Courses(idCourse)  ON DELETE CASCADE
);

DROP TABLE IF EXISTS `Professors`;
CREATE TABLE `Professors` (
  `idProfessor` int(11) NOT NULL AUTO_INCREMENT,
  `firstName` varchar(45) NOT NULL,
  `lastName` varchar(45) NOT NULL,
  `email` varchar(45) NOT NULL,
  PRIMARY KEY (idProfessor)
);



DROP TABLE IF EXISTS `Schedules`;
CREATE TABLE `Schedules` (
  `idSchedule` int(11) NOT NULL AUTO_INCREMENT,
  `idStudent` int(11) NOT NULL,
  `totalCreditHours` int(11) NOT NULL,
  `term` varchar(20) NOT NULL,
  PRIMARY KEY (idSchedule),
  FOREIGN KEY (idStudent) REFERENCES Students(idStudent)  ON DELETE CASCADE
);


DROP TABLE IF EXISTS `Students`;
CREATE TABLE `Students` (
  `idStudent` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(45) NOT NULL,
  `email` varchar(45) NOT NULL,
  `major` varchar(45) NOT NULL,
  PRIMARY KEY (idStudent)
);

SHOW TABLES;

INSERT INTO Students(username, email, major)
VALUES (
    'cameron',
    'cameron@CKHH.edu',
    'CS'
),
(
    'hla',
    'hla@CKHH.edu',
    'CS'
),
(
    'trent',
    'trent@CKHH.edu',
    'CS'
),
(
    'htun',
    'htun@ckhh.edu',
    'CS'
),
(
    'testuser',
    'testuser@ckhh.edu',
    'CS'
);

SELECT * FROM Students;

INSERT INTO Classrooms(totalSeats, building, roomNumber)
VALUES (
    75,
    'Weniger',
    153
),
(
    155,
    'Weniger',
    151
),
(
    105,
    'Linus Pauling Science Center',
    125
),
(
    450,
    'Test Building',
    1230
);

SELECT * FROM Classrooms;

INSERT INTO Professors(firstName, lastName, email)
VALUES(
    "Paris",
    "Kalathas",
    "kalathap@oregonstate.edu"
),
(
    "Christopher",
    "Buss",
    "bussch@oregonstate.edu"
),
(
    "Rob",
    "Hess",
    "hessr@oregonstate.edu"
),
(
    "Test",
    "Case",
    "casetest@oregonstate.edu"
);

SELECT * FROM Professors;

INSERT INTO Addresses(idStudent, streetName, city, state, zipCode, country)
VALUES
(
   (SELECT idStudent from Students WHERE username = "hla"),
    "5678 Winter Valley",
    "Albany",
    "Oregon",
    97332,
    "USA"
),
(
    (SELECT idStudent from Students WHERE username = "cameron"),
    "1234 Spring Valley",
    "Corvallis",
    "Oregon",
    97330,
    "USA"
),
(
    (SELECT idStudent from Students WHERE username = "trent"),
    "9999 Error Location",
    "Auburn",
    "Washington",
    98092,
    "USA"
),
(
    (SELECT idStudent from Students WHERE username = "htun"),
    "Yankin Rd",
    "Yangon",
    "Yangon",
    11081,
    "Myanmar"
),
(
    (SELECT idStudent from Students WHERE username = "testuser"),
    "0000 No Street",
    "Nocity",
    "Nostate",
    00000,
    "Nocountry"
);

SELECT * FROM Addresses;

INSERT INTO Courses(idClassroom, idProfessor, title, description, creditHours, prerequisites, totalEnrolled, meetingTime, online) 
VALUES
(
    (SELECT idClassroom FROM Classrooms WHERE idClassroom = 1),
    (SELECT idProfessor FROM Professors WHERE firstName = "Paris"),
    "Intro to Assembly",
    "Learning IA32, MASM and CISC Architecture", 
    4,
    "NULL",
    0,
    "17:00",
    0
),
(
    (SELECT idClassroom FROM Classrooms WHERE idClassroom = 2),
    (SELECT idProfessor FROM Professors WHERE firstName = "Christopher"),
    "Intro to Databases",
    "Learning HTML, CSS, and Javascript", 
    4,
    "NULL",
    0,
    "8:00",
    0
),
(
    NULL,
    (SELECT idProfessor FROM Professors WHERE firstName = "Rob"),
    "Web Development",
    "Learning database management system", 
    4,
    "NULL",
    0,
    NULL,
    1
),
(
    NULL,
    (SELECT idProfessor FROM Professors WHERE firstName = "Test"),
    "Test Course",
    "Test Course description", 
    4,
    "NULL",
    0,
    NULL,
    1
);

SELECT * FROM Courses;

INSERT INTO Schedules(idStudent, totalCreditHours, term)
VALUES
(
   (SELECT idStudent from Students WHERE username = "hla"),
    16,
    "Spring 2023"
),
(
    (SELECT idStudent from Students WHERE username = "cameron"),
    20,
    "Spring 2023"
),
(
    (SELECT idStudent from Students WHERE username = "trent"),
    32,
    "Fall 2022"
);

SELECT * FROM Schedules;

INSERT INTO CourseSchedules(idSchedule, idCourse, grade)
VALUES
(
    (SELECT idSchedule from Schedules WHERE idSchedule = 2),
    2,
    "A-"
),
(
    (SELECT idSchedule from Schedules WHERE idSchedule = 1),
    1,
    "A"
),
(
    (SELECT idSchedule from Schedules WHERE idSchedule = 3),
    3,
    "A"
);

SELECT * FROM CourseSchedules;



SET FOREIGN_KEY_CHECKS = 1;
COMMIT;