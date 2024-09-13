-- Run's multiple queiries to each of the pages of the html website for our database

-- studentPage.html
-- SELECT Students.idStudent, username, email, major, CONCAT(streetName, ", ", state, ", ", zipCode) AS Addresses
-- FROM Students NATURAL JOIN Addresses ;

-- updated student page query
SELECT Students.idStudent, username, email, major, CONCAT(streetName, ", ", city, ", ", state, ", ", zipCode, ", ", country) AS address
FROM Students
JOIN Addresses ON Students.idStudent = Addresses.idStudent
WHERE Addresses.idAddress = (
    SELECT MAX(idAddress)
    FROM Addresses
    WHERE Addresses.idStudent = Students.idStudent
)
ORDER BY Students.idStudent ASC;

-- professor.html
SELECT *
FROM Professors;

-- courses.html
-- SELECT idCourse, title, CONCAT(firstName," ", lastName) AS Professor, totalEnrolled, online, meetingTime, CONCAT(building," ", roomNumber) AS Classroom
-- FROM Courses INNER JOIN Professors ON Professors.idProfessor=Courses.idProfessor NATURAL JOIN Classrooms;

-- updated courses.html rendering query
SELECT
    Courses.idCourse,
    Courses.title,
    CONCAT(firstName, ' ', lastName) AS professor,
    totalEnrolled,
    online,
    meetingTime,
    CONCAT(building, ' ', roomNumber) AS location
FROM
    Courses
    INNER JOIN Professors ON Professors.idProfessor = Courses.idProfessor
    LEFT JOIN Classrooms ON Classrooms.idClassroom = Courses.idClassroom;

-- Schedules.html
SELECT idSchedule, idStudent, username, totalCreditHours, term
FROM Schedules NATURAL JOIN Students 
ORDER BY (idSchedule);

-- Course_Schedules.html
SELECT title AS Course, description as Description, creditHours AS Credit, prerequisites AS Prerequisites, grade AS Grade
FROM CourseDetails NATURAL JOIN Courses NATURAL JOIN CourseSchedules AS CS
WHERE CS.idCourseSchedule = >userSelectedVariable;

 -- for student schedule page, which is when you click on a student from the students' page
SELECT idSchedule, totalCreditHours, term
FROM Schedules
WHERE idSchedule = >userSelectedVariable;

-- for course details page, which is when you click on the title of a course
-- SELECT idCourse, title, CONCAT(firstName, lastName) as Professor, totalEnrolled, online, meetingTime, CONCAT(building,' ', roomNumber) as Classroom
-- FROM CourseDetails NATURAL JOIN Professors NATURAL JOIN Courses NATURAL JOIN Classrooms
-- WHERE Courses.idCourse = >userSelectedVariable;

-- updated course details page query
SELECT
    Courses.idCourse,
    Courses.title,
    CONCAT(firstName, ' ', lastName) AS professor,
    totalEnrolled,
    online,
    meetingTime,
    CONCAT(building, ' ', roomNumber) AS location
FROM
    CourseDetails
    JOIN Courses ON Courses.title = CourseDetails.title
    NATURAL JOIN Professors
    LEFT JOIN Classrooms ON Classrooms.idClassroom = Courses.idClassroom
WHERE
    Courses.idCourse = ${idCourse};

-- --------------------------------------------------------------------------------


-- INSERTING DATA TO DATABASE i.e. FORMS

-- for adding a student in students page, the first three values go into Students table
INSERT INTO Students(username, email, major)
VALUES (
    >1userSelectedUsername,
    >2userSelectedEmail,
    >3userSelectedMajor
);

-- for adding a student in students page, the last five values go into Addresses table
INSERT INTO Addresses(idStudent, streetName, city, state, zipCode, country)
VALUES (
    >useridStudent -- maximum of idStudent, basically
    >userSelectedStreetName,
    >userSelectedCity,
    >userSelectedState,
    >4userSelectedZipCode,
    >5userSelectedCountry,
);

-- for creating a new schedule in student schedule page
INSERT INTO Schedules(idStudent, totalCreditHours, term)
VALUES (
    >userSelectedidStudent,
    0, -- >totalCreditHours default value 0 since this will increment as courses are added in
    >userSelectedTerm
);

-- for adding a new course in a student's schedule
INSERT INTO CourseSchedules(idSchedule, idCourse, grade)
VALUES (
    >1userSelectedidSchedule,
    >2userSelectedidCourse,
    >3userSelectedGrade
);

-- Adding a course from CoursePage Form
INSERT INTO Courses (idClassroom, idProfessor, title, totalEnrolled, meetingTime, online)
VALUES (
    >UserSelectedClassroom, -- default null if onine is true
    >UserSelectedProfessor,
    >UserSelectedTitle,
    >UserSelectedEnrolled,
    >UserSelectedMeetingTime, -- default null if onine is true
    >UserSelectedOnline
);

-- ProfessorPage Form
INSERT INTO Professors (firstName, lastName, email)
VALUES (
    >UserSelectedFirstName,
    >UserSelectedLastName,
    >UserSelectedEmail
);



-- --------------------------------------------------------------------------------


-- UPDATING DATA TO DATABASE
-- update a student's data
UPDATE Students 
SET email = >UserSelectedEmailInput,
    major = >UserSelectedMajor,
    streetName = >UserSelectedStreetName,
    city = >UserSelectedCity,
    state = >UserSelectedState,
    zipCode = >UserSelectedZipCode,
    country = >UserSelectedCountry
WHERE idStudent = >UserSelectedidStudent

-- update a professor's data
UPDATE Professors
SET firstName = >UserSelectedFirstName,
    lastName = >UserSelectedLastName,
    email = >UserSelectedEmailInput
WHERE idProfessor = >UserSelectedidProfessor

-- update a course's data
UPDATE Courses 
SET title = >UserSelectedTitle,
    professor = >UserSelectedProfessor,
    totalEnrolled = >UserSelectedTotalEnrolled,
    online = >UserSelectedOnline,
    meetingTime = >UserSelectedMeetingTime,
    Classroom => >UserSelectedClassroom
WHERE idCourse = >UserSelectedidCourse


-- --------------------------------------------------------------------------------


-- DELETING DATA TO DATABASE

-- delete a student
DELETE
FROM Students
WHERE idStudent = >UserSelectedidStudent

-- delete a schedule
DELETE
FROM Schedules
WHERE idSchedule = >UserSelectedidSchedule

-- delete a course from a student's schedule
DELETE
FROM CourseSchedules
WHERE idSchedule = >UserSelectedidSchedule AND idCourse = >UserSelectedCourse

-- delete a professor
DELETE
FROM Professors
WHERE idProfessor = >UserSelectedidProfessor

-- delete a course
DELETE
FROM COurses
WHERE idCourse = >UserSelectedidCourse
