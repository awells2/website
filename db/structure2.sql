drop table if exists info;
drop table if exists confluency;
drop table if exists sytoxGreen;
drop table if exists NLS;
drop table if exists mCherryRed;
drop table if exists experimentInfo;

create table experimentinfo (
expid text,
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
expid text,
compoundname text,
catalogno text,
racknumber text,
molecularweight text,
casnumber text,
form text,
targetssupplied text,
targetsedited text,
moleculetype text,
targetspecies text,
targettype text,
information text,
smiles text,
solubility text,
url text,
pathway text,
plate text,
position text
);

create table confluency (
num int,
expid text,
compoundname text,
data text
);

create table sytoxGreen (
num int,
expId text,
compoundname text,
data text
);

create table NLS (
num int,
expId text,
compoundname text,
data text
);

create table mCherryRed(
num int,
expId text,
compoundname text,
data text
);
