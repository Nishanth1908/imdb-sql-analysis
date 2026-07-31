-- IMDb Database Setup
-- File: 01_create_tables.sql

CREATE DATABASE IF NOT EXISTS imdb;
USE imdb;

-- Table: title_basics

CREATE TABLE title_basics (
    tconst VARCHAR(20) PRIMARY KEY,
    titleType VARCHAR(30),
    primaryTitle LONGTEXT,
    originalTitle LONGTEXT,
    isAdult TINYINT,
    startYear VARCHAR(10),
    endYear VARCHAR(10),
    runtimeMinutes VARCHAR(10),
    genres VARCHAR(255)
);

-- Table: title_ratings

CREATE TABLE title_ratings (
    tconst VARCHAR(20) PRIMARY KEY,
    averageRating DECIMAL(3,1),
    numVotes INT
);

-- Table: title_crew

CREATE TABLE title_crew (
    tconst VARCHAR(20) PRIMARY KEY,
    directors LONGTEXT,
    writers LONGTEXT
);

-- Table: name_basics

CREATE TABLE name_basics (
    nconst VARCHAR(20) PRIMARY KEY,
    primaryName VARCHAR(255),
    birthYear VARCHAR(10),
    deathYear VARCHAR(10),
    primaryProfession LONGTEXT,
    knownForTitles LONGTEXT
);

-- Table title_akas

CREATE TABLE title_akas (
	titleId VARCHAR (20),
    ordering INT,
    title TEXT,
    region TEXT,
    language TEXT,
    types TEXT,
    attributes TEXT,
    isOriginalTitle boolean,
    PRIMARY KEY (titleId, ordering)
);






