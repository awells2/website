drop table if exists info;
drop table if exists confluency;
drop table if exists sytoxGreen;
drop table if exists NLS;
drop table if exists mCherryRed;
drop table if exists experimentInfo;

create table experimentinfo (
expid int,
exptype text,
researcher text,
descripton text,
title text,
timeformat text,
markers text,
cellline text,
excelname text
);


create table info (
num int,
expId int,
compoundName text,
catalogNo text,
rackNumber text,
molecularWeight real,
casNumber text,
form text,
targetsSupplied text,
targetsEdited text,
moleculeType text,
targetSpecies text,
targetType text,
information text,
smiles text,
solubility int,
url text,
pathway text,
plate int,
position text
);

create table confluency (
num int,
expId int,
compoundName text,
data text
);

create table sytoxGreen (
num int,
expId int,
compoundName text,
data text
);

create table NLS (
num int,
expId int,
compoundName text,
data text
);

create table mCherryRed(
num int,
expId int,
compoundName text,
data text
);
