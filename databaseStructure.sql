CREATE TABLE users (
    userID INT NOT NULL AUTO_INCREMENT,
    firstName VARCHAR(30),
    lastName VARCHAR(30),
    password CHAR(32), -- should be encrypted, CHAR is better if the field is always the same length
    email VARCHAR(64) NOT NULL, -- not null if this is what you will use as a "username"
    PRIMARY KEY (userID)
);

CREATE TABLE personalInfo (
    userID INT NOT NULL,
    gender ENUM ('MALE', 'FEMALE'),
    dateOfBirth DATE,
    phoneNumber VARCHAR(15),
    personalEmail VARCHAR(64), -- may or may not be the same as the email field in the "users" table
    workEmail VARCHAR(64),
    bio TEXT,
    FOREIGN KEY (userID) REFERENCES users (userID)
);

/* this table is not specific to any single user. It is just a list of jobs that have been created */
CREATE TABLE jobs (
    jobID INT NOT NULL AUTO_INCREMENT,
    company VARCHAR(100),
    title VARCHAR(100),
    description TEXT,
    PRIMARY KEY (jobID)
);

/* the workInfo table will hold one entry per user per job. So if a user has held five jobs,
   there will be five rows with that userID in this table, each with a different jobID, which
   refers to an entry in the "jobs" table above. */
CREATE TABLE workInfo (
    userID INT NOT NULL,
    jobID INT NOT NULL,
    startDate DATE,
    endDate DATE, -- can set this to null if it's the user's current job
    FOREIGN KEY (userID) REFERENCES users (userID),
    FOREIGN KEY (jobID) REFERENCES jobs (jobID)
);

CREATE TABLE schools (
    schoolID INT NOT NULL AUTO_INCREMENT,
    schoolName VARCHAR(100),
    -- any other information you want to provide about the school (city, address, phone, etc)
    PRIMARY KEY (schoolID)
);

CREATE TABLE schoolPrograms (
    programID INT NOT NULL AUTO_INCREMENT,
    programName VARCHAR(100),
    -- any other information you want to provide about the program (department, teachers, etc)
    PRIMARY KEY (programID)
);

CREATE TABLE educationInfo (
    userID INT NOT NULL,
    schoolID INT,
    programID INT,
    startDate DATE,
    endDate DATE,
    FOREIGN KEY (userID) REFERENCES users (userID),
    FOREIGN KEY (schoolID) REFERENCES schools (schoolID),
    FOREIGN KEY (programID) REFERENCES schoolPrograms (programID)
);

CREATE TABLE relationships (
    userID INT NOT NULL,
    userID2 INT, -- allowed to be null if the user is single or does not specify who they are in a relationship with
    status ENUM ('SINGLE', 'IN A RELATIONSHIP', 'MARRIED', 'IT''S COMPLICATED' /* etc */),
    FOREIGN KEY (userID) REFERENCES users (userID)
);

/* each photo is created here. This way, when a user wants to share a photo,
   we don't have to duplicate each column. We just create another row in
   the "userPhotos" table below that) REFERENCES the same photoID. */
CREATE TABLE photos (
    photoID INT NOT NULL AUTO_INCREMENT,
    url VARCHAR(200),
    caption VARCHAR(200),
    dateOfUpload TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (photoID)
);

CREATE TABLE userPhotos (
    userID INT NOT NULL,
    photoID INT NOT NULL,
    FOREIGN KEY (userID) REFERENCES users (userID),
    FOREIGN KEY (photoID) REFERENCES photos (photoID)
);

/* vidoes, handled exactly the same as photos */
CREATE TABLE videos (
    videoID INT NOT NULL AUTO_INCREMENT,
    url VARCHAR(200),
    caption VARCHAR(200),
    dateOfUpload TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (videoID)
);

CREATE TABLE userVideos (
    userID INT NOT NULL,
    videoID INT NOT NULL,
    FOREIGN KEY (userID) REFERENCES users (userID),
    FOREIGN KEY (videoID) REFERENCES videos (videoID)
);

CREATE TABLE status (
    userID INT NOT NULL,
    status TEXT,
    FOREIGN KEY (userID) REFERENCES users (userID)
);