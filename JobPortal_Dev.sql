Create database JobPortal_Dev
use JobPortal_Dev


-----*************** START  JOBSEEKER TABLE AND ALL RELATED PROCEDURE IS CODE ************--------------------

create table tblJobseeker
(
jid int primary key identity,
name varchar(100),
address varchar(300),
country int,
state int,
city int,
mobileno varchar(15),
gender int,
qualification int,
stream int,
jobprofile int,
skill varchar(100),
empresume varchar(200),
empimage varchar(200),
emailid varchar(100),
--confirmemailid varchar(100),
password varchar(100),
--confirmpassword varchar(100),
status int default 0,  -- it takes bydefault value 0 from itseft.
inserted_date date
)
ALTER TABLE tblJobseeker
DROP COLUMN confirmemailid,confirmpassword
alter table tblJobseeker add  usertype int default 2

drop table tblJobseeker

alter proc sp_tblJobseeker

@action varchar(50)=null,
@name varchar(100)=null,
@address varchar(300)=null,
@country int=0,
@state int=0,
@city int=0,
@mobileno varchar(15)=null,
@gender int=0,
@qualification int=0,
@stream int=0,
@jobprofile int=0,
@skill varchar(100)=null,
@empresume varchar(200)=null,
@empimage varchar(200)=null,
@emailid varchar(100)=null,
--@confirmemailid varchar(100)=null,
@password varchar(100)=null
--@confirmpassword varchar(100)=null

as
begin
	if(@action='INSERT')
	begin
		insert into tblJobseeker(
		name,
		address,
		country,
		state,
		city,
		mobileno,
		gender,
		qualification,
		stream,
		jobprofile,
		skill,
		empresume,
		empimage,
		emailid,
		--confirmemailid,
		password,
		--confirmpassword,
		inserted_date)

		values(
		@name,
		@address,
		@country,
		@state,
		@city,
		@mobileno,
		@gender,
		@qualification,
		@stream,
		@jobprofile,
		@skill,
		@empresume,
		@empimage,
		@emailid,
		--@confirmemailid,
		@password,
		--@confirmpassword,
		GETDATE())
	end
	else if(@action='GET')
	begin
	select * from tblJobseeker 
	end
end

insert into tblJobseeker(usertype) values(2) where jid between 1 and 5

update  tblJobseeker set usertype =2 where jid  between 2 and 5
-----------------------------------------------------------------------------------------------


create table tblCountry
(
countryid int primary key identity,
countryname varchar(100),
status int default 0,
inserted_date date
)
drop table tblCountry

alter proc sp_tblCountry
@action varchar(100)=null,
@countryname varchar(100)=null
as
begin
	if(@action='INSERT')
	begin
	insert into tblCountry(
	countryname,inserted_date
	)values(@countryname,GETDATE()
	)
	end
	else if(@action='GETCOUNTRY')
	begin
	select * from tblcountry 
	end
end

create table tblState
(
stateid int primary key identity,
countryid int,
statename varchar(100),
status int default 0,
inserted_date DATE
)
drop table tblState
alter proc sp_tblState
@action varchar(100)=null,
@statename varchar(100)=null,
@countryid int=0
as
begin
	if(@action='INSERT')
	begin
	insert into tblState(
	countryid,
	Statename,
	inserted_date
	)values(
	@countryid,
	@statename,
	GETDATE()
	)
	end
	else if(@action='GETSTATE')
	begin
	select * from tblState where countryid=@countryid
	end
end

select * from tblState where countryid=1

create table tblCity
(
cityid int primary key identity,
countryid int,
stateid int,
cityname varchar(100),
status int default 0,
inserted_date DATE
)
drop table tblCity

alter proc sp_tblCity
@action varchar(100)=null,
@cityname varchar(100)=null,
@countryid int=0,
@stateid int=0
as
begin
	if(@action='INSERT')
	begin
	insert into tblCity(
	countryid,
	stateid,
	cityname,
	inserted_date
	)values(
	@countryid,
	@stateid,
	@cityname,
	GETDATE()
	)
	end
	else if(@action='GETCITY')
	begin
	select * from tblCity where  countryid=@countryid and stateid=@stateid  
	end
end

create table tblQualification
(
qualificationid int primary key identity,
qualificationname varchar(100),
status int default 0,
inserted_date DATE
)

create proc sp_tblQualification
@action varchar(100)=null,
@qualificationname varchar(100)=null
as
begin
	if(@action='INSERTQUALIFICATION')
	begin
	insert into tblQualification
	(
	qualificationname,
	inserted_date
	)
	values
	(
	@qualificationname,
	GETDATE()
	)
	end
	else if(@action='GETQUALIFICATION')
	begin
	select * from tblQualification
	end
end

create table tblStream
(
streamid int primary key identity,
qualificationid int,
streamname varchar(100),
status int default 0,
inserted_date Date
)

alter proc sp_tblStream
@action varchar(100)=null,
@streamname varchar(100)=null,
@qualificationid int=0
as
begin
	IF(@action='INSERTSTREAM')
	begin
	insert into tblStream
	(
	qualificationid,
	streamname,
	inserted_date
	)
	values
	(
	@qualificationid,
	@streamname,
	GETDATE()
	)
	end
	else if (@action='GETSTREAM')
	begin
	select * from tblStream where qualificationid= @qualificationid
	end
end



create table tblJobprofile
(
jobprofileid int primary key identity,
jobprofilename varchar(100),
status int default 0,
inserted_date Date
)

create proc sp_tblJobprofile
@action varchar(100)=null,
@jobprofilename varchar(100)=null

as
begin
	IF(@action='INSERTJOBPROFILE')
	begin
	insert into tblJobprofile
	(
	jobprofilename,
	inserted_date
	)
	values
	(
	@jobprofilename,
	GETDATE()
	)
	end
	else if (@action='GETJOBPROFILE')
	begin
	select * from tblJobprofile 
	end
end

create table tblSkills
(
skillid int primary key identity,
jobprofileid int,
skillname varchar(100),
status int default 0,
inserted_date Date
)


create proc sp_tblSkill
@action varchar(100)=null,
@skillname varchar(100)=null,
@jobprofileid int

as
begin
	IF(@action='INSERTSKILL')
	begin
	insert into tblSkills
	(
	jobprofileid,
	skillname,
	inserted_date
	)
	values
	(
	@jobprofileid,
	@skillname,
	GETDATE()
	)
	end
	else if (@action='GETSKILL')
	begin
	select * from tblSkills where jobprofileid= @jobprofileid
	end
end

-----*************** END  JOBSEEKER TABLE AND ALL RELATED PROCEDURE IS CODE ************--------------------
select * from tblJobseeker
select * from tblCountry
select * from tblState
select * from tblCity
select * from tblQualification
select * from tblStream
select * from tblJobprofile
select * from tblSkills

---------------****** ALL TABLE IN DATABASE **********----------------------------------------

truncate table tblJobseeker

--------------******** JobRecruiter table Start  ******--------------------

create table tblRecruiter
(
recruiterid int primary key identity,
name varchar(200),
url varchar(300),
country int,
state int,
city int,
address varchar(300),
hrname varchar(100),
contactno varchar(15),
emailid varchar(100),
--confirmemailid varchar(100),
password varchar(100),
--confirmpassword varchar(100),
status int default 0,  -- it takes bydefault value 0 from itseft.
inserted_date date
)
alter table tblRecruiter add  usertype int default 3
update  tblRecruiter set usertype =3 where recruiterid  between 1 and 2

alter proc sp_tblRecruiter

@action varchar(50)=null,
@recruiterid int=0,
@name varchar(100)=null,
@url varchar(300)=null,
@country int=0,
@state int=0,
@city int=0,
@address varchar(300)=null,
@hrname varchar(100)=null,
@contactno varchar(15)=0,
@emailid varchar(100)=null,
@password varchar(100)=null

as
begin
	if(@action='INSERT')
	begin
		insert into tblRecruiter(
		name,
		url,
		country,
		state,
		city,
		address,
		hrname,
		contactno,
		emailid,
		password,
		inserted_date)

		values(
		@name,
		@url,
		@country,
		@state,
		@city,
		@address,
		@hrname,
		@contactno,
		@emailid,
		@password,
		GETDATE())
	end
	else if(@action='GET')
	begin
	select * from  tblRecruiter
	end
	else if(@action='GETFILTERCOMPANY')
	begin
	select recruiterid,name as recruitername from tblRecruiter
	end
	else if (@action='GETRECRUITERPROFILE')
	begin
	select ROW_NUMBER()over(order by recruiterid) as SerialNumber, * from tblRecruiter
	join tblCountry on tblRecruiter.country= tblCountry.countryid
	join tblState on tblRecruiter.state= tblState.stateid
	join tblCity on tblRecruiter.city= tblCity.cityid
	where recruiterid=@recruiterid and tblRecruiter.status=0
	end
	else if(@action='DELETEPROFILE')
	begin
	update tblRecruiter set status=1 where recruiterid=@recruiterid
	end
	else if(@action='GETRECRUITERDETAILS')
	begin
	select * from tblRecruiter where recruiterid=@recruiterid
	end
	else if(@action='UPDATERECRUITER')
	begin
	update tblRecruiter set name=@name,url=@url,country=@country,state=@state,city=@city,address=@address,hrname=@hrname,contactno=@contactno 
	where recruiterid=@recruiterid
	end
end

--------------------*********** END OF RECRUITER CODE   *************---------------------------------------------------

-------------------************ START OF ADMIN CODE **********------------------------------------------------
create table tblAdmin
(
adminid int primary key identity,
name varchar(100),
age int,
--gender int,
mobileno varchar(15),
--country int,
--state int,
--city int,
emailid varchar(100),
password varchar(100),
status int default 0,
inserted_date DATE
)
alter table tblAdmin add  usertype int default 1
update  tblAdmin set usertype =1 where adminid  between 1 and 3
alter table tbladmin alter column gender varchar(100)-- working
alter table tbladmin alter column country varchar(100)-- working
alter table tbladmin alter column state varchar(100)-- working
alter table tbladmin alter column city varchar(100)-- working


insert into tblAdmin(name,age,gender,mobileno,country,state,city,emailid,password,inserted_date)
values('Admin',20,'Male','+91-9987899098','India','UP','Lucknow','admin@gmail.com','Admin123',GETDATE())

insert into tblAdmin(name,age,gender,mobileno,country,state,city,emailid,password,inserted_date)
values('Fahad',27,'Male','+91-9987800098','Pakistan','Sindh','Lahore','fahad@gmail.com','Fahad123',GETDATE())

insert into tblAdmin(name,age,gender,mobileno,country,state,city,emailid,password,inserted_date)
values('Ali',25,'Male','+91-99878990988','USA','Florida','Texas','ali@gmail.com','Ali123',GETDATE())

select * from tblAdmin
truncate table tblAdmin
--------------------*********** END OF ADMIN  CODE   *************---------------------------------------------------

------------------ START OF Admin LOGIN PAGE CODE *******-------------------
create proc sp_AdminLogin
@action varchar(100)=null,
@loginemailid varchar(100)=null,
@loginpassword varchar(100)=null
as
begin
if(@action='ADMINLOGIN')
begin
	select * from tblAdmin where emailid=@loginemailid and password=@loginpassword
end
end


------------------ END OF ADMIN LOGIN PAGE CODE *******-------------------

------------------ START OF Jobseeker LOGIN PAGE CODE *******-------------------
create proc sp_JobSeekerLogin
@action varchar(100)=null,
@jobseekeremailid varchar(100)=null,
@jobseekerpassword varchar(100)=null
as
begin
if(@action='JOBSEEKERLOGIN')
begin
	select * from tblJobseeker where emailid=@jobseekeremailid and password=@jobseekerpassword
end
end
------------------ END OF Jobseeker LOGIN PAGE CODE *******-------------------

------------------ END OF Recruiter LOGIN PAGE CODE *******-------------------
alter proc sp_RecruiterLogin
@action varchar(100)=null,
@recruiteremail varchar(100)=null,
@recruiterpassword varchar(100)=null
as
begin
	if(@action='RECRUITERLOGIN')
	begin
	select * from tblRecruiter where emailid=@recruiteremail and password=@recruiterpassword
	end
end
-- Ek me bhi ban sakta hai- ye
--inserted date me date ke sath time bhi jaye proper and aliasing kani hai
------------------ END OF Recruiter LOGIN PAGE CODE *******-------------------

-----------------------******** START OF CHANGE UPDATEJOBSEEKERPASSWORD PASSWORD CODE ********------------------
alter proc sp_ChangePassword
@action varchar(100)=null,
@oldpassword varchar(100)=null,
@newpassword varchar(100)=null,
@adminid int=0,
@recruiterid int=0,
@jid int=0
as
begin
	if(@action='UPDATEADMINPASSWORD')
	begin
	update tblAdmin set password=@newpassword  where adminid=@adminid and password=@oldpassword
	end
	if(@action='UPDATERECRUITERPASSWORD')
	begin
		update tblRecruiter set password=@newpassword  where recruiterid=@recruiterid and password=@oldpassword
	end
	if(@action='UPDATEJOBSEEKERPASSWORD')
	begin
		update tblJobseeker  set password=@newpassword  where jid=@jid and password=@oldpassword
	end
end

-----------------------******** END OF CHANGE PASSWORD CODE ********------------------


select * from tblJobseeker
select * from tblAdmin
select * from tblRecruiter
---------------------------------------------------------------------------------------------
----------******** START OF RECRUITER JOB POST TABLE CODE -----------------------------------

create table tblJobPostRecruiter
(
jobid int primary key identity,
jobprofileid  int,
recruiterid int,
minexperience varchar(100),
maxexperience varchar(100),
minsalary varchar(100),
maxsalary varchar(100),
vacancies varchar(100),
comment varchar(100),
status int default 0,
inserted_date date
)
drop table tblJobPostRecruiter

alter proc sp_tblJobPostRecruiter
@action varchar(100)=null,
@jobprofileid  int=0,
@recruiterid int=0,
@minexperience varchar(100)=null,
@maxexperience varchar(100)=null,
@minsalary varchar(100)=null,
@usersalary varchar(100)=null,
@maxsalary varchar(100)=null,
@vacancies varchar(100)=null,
@comment varchar(100)=null,
@jobid int=0
as
begin
		if(@action='INSERTJOB')
		begin
		insert into tblJobPostRecruiter(
		jobprofileid,
		recruiterid,
		minexperience,
		maxexperience,
		minsalary,
		maxsalary,
		vacancies,
		comment,
		inserted_date
		)
		values(
		@jobprofileid,
		@recruiterid,
		@minexperience,
		@maxexperience,
		@minsalary,
		@maxsalary,
		@vacancies,
		@comment,
		GETDATE()
		)
		end
		else if(@action='GETJOB')
		begin
		select ROW_NUMBER()over(order by jobid) as SerialNumber,* from tblJobPostRecruiter 
		join tblJobprofile on  tblJobPostRecruiter.jobprofileid = tblJobprofile.jobprofileid
		join tblRecruiter on tblJobPostRecruiter.recruiterid = tblRecruiter.recruiterid where tblRecruiter.recruiterid=@recruiterid and  tblJobPostRecruiter.status=0
		end
		else if(@action='SEARCHJOB')
		begin
		select  ROW_NUMBER()over(order by jobid) as SerialNumber,* from tblJobPostRecruiter 
		join tblRecruiter on tblJobPostRecruiter.recruiterid = tblRecruiter.recruiterid 
		join tblJobprofile on  tblJobPostRecruiter.jobprofileid = tblJobprofile.jobprofileid where tblJobPostRecruiter.jobprofileid=@jobprofileid and  tblRecruiter.recruiterid=@recruiterid and tblJobPostRecruiter.status=0
		end
		else if(@action='DELETEJOB')
		begin
		update tblJobPostRecruiter set status=1 where jobid=@jobid
		end
		else if(@action='EDITJOB')
		begin
		select * from tblJobPostRecruiter where jobid=@jobid
		end
		else if(@action='UPDATEJOB')
		begin
		update tblJobPostRecruiter set jobprofileid=@jobprofileid,minexperience=@minexperience,maxexperience=@maxexperience,minsalary=@minsalary,maxsalary=@maxsalary,vacancies=@vacancies,comment=@comment 
		where jobid=@jobid
		end
		else if(@action='GETALLJOBPOSTBYRECRUITER')
		begin
		select ROW_NUMBER()over(order by jobid) as SerialNumber,DATEDIFF(DAY,tblJobPostRecruiter.inserted_date,GETDATE()) As noofdays,* from tblJobPostRecruiter 
		join tblJobprofile on  tblJobPostRecruiter.jobprofileid = tblJobprofile.jobprofileid
		join tblRecruiter on tblJobPostRecruiter.recruiterid = tblRecruiter.recruiterid 
		where tblJobPostRecruiter.status=0
		end
		else if(@action='SEARCHFILTERJOB')
		begin
		select ROW_NUMBER()over(order by jobid) as SerialNumber,DATEDIFF(DAY,tblJobPostRecruiter.inserted_date,GETDATE()) As noofdays,* from tblJobPostRecruiter 
		join tblJobprofile on  tblJobPostRecruiter.jobprofileid = tblJobprofile.jobprofileid
		join tblRecruiter on tblJobPostRecruiter.recruiterid = tblRecruiter.recruiterid 
		where tblJobPostRecruiter.jobprofileid=@jobprofileid and tblJobPostRecruiter.recruiterid=@recruiterid
		and  tblJobPostRecruiter.minsalary<=@usersalary and tblJobPostRecruiter.maxsalary>=@usersalary
		and  tblJobPostRecruiter.status=0
		end
		
end
-------------------------------------------------------------------------------------
select * from tblJobprofile
select * from tblJobPostRecruiter where status=0
select * from tblRecruiter
select * from tblAdmin
select * from tblJobseeker
truncate table tblJobPostRecruiter
------------------------------------------------------------------------------------------

-- TESTING  QUERY LOGIC 

select * from sys.objects where type = 'U' -- For permamnet table
select * from sys.objects where type = 'P' --  For procedure
select * from sys.objects where type = 'PK' -- For primary key
select * from sys.objects where type = 'F' -- for function
select * from sys.databases

select  ROW_NUMBER()over(order by jobid) as SerialNumber,* from tblJobPostRecruiter 
		join tblRecruiter on tblJobPostRecruiter.recruiterid = tblRecruiter.recruiterid 
		join tblJobprofile on  tblJobPostRecruiter.jobprofileid = tblJobprofile.jobprofileid 
		where   tblRecruiter.recruiterid=1 and tblJobPostRecruiter.status=0

		select * from tblJobPostRecruiter where jobid=1

		select ROW_NUMBER()over(order by jobid) as SerialNumber,DATEDIFF(DAY,tblJobPostRecruiter.inserted_date,GETDATE()) As noofdays,* from tblJobPostRecruiter 
		join tblJobprofile on  tblJobPostRecruiter.jobprofileid = tblJobprofile.jobprofileid
		join tblRecruiter on tblJobPostRecruiter.recruiterid = tblRecruiter.recruiterid 
		where tblJobPostRecruiter.status=0

		SELECT inserted_date,* FROM tblJobPostRecruiter
		SELECT DATEDIFF(HOUR,'09-08-1995',GETDATE())

		SELECT DATEDIFF(DAY,'2023-05-03',GETDATE())
	    select  DATEDIFF(DAY,tblJobPostRecruiter.inserted_date,GETDATE()) As noofdays from tblJobPostRecruiter
		select	DATEDIFF(HOUR,tblJobPostRecruiter.inserted_date,GETDATE()) As noofhours from tblJobPostRecruiter

		
		SELECT inserted_date,* FROM tblJobPostRecruiter where status=0
		update tblJobPostRecruiter set inserted_date='2023-05-01' where jobid=1 and jobid=4

		update tblJobPostRecruiter set inserted_date='2023-03-02' where jobid  between 10 and 12
		update tblJobPostRecruiter set inserted_date='2023-05-01' where jobid=1 

		select ROW_NUMBER()over(order by jobid) as SerialNumber,DATEDIFF(DAY,tblJobPostRecruiter.inserted_date,GETDATE()) As noofdays,* from tblJobPostRecruiter 
		join tblJobprofile on  tblJobPostRecruiter.jobprofileid = tblJobprofile.jobprofileid
		join tblRecruiter on tblJobPostRecruiter.recruiterid = tblRecruiter.recruiterid 
		where tblJobPostRecruiter.jobprofileid=1 and tblJobPostRecruiter.recruiterid=2
		and  tblJobPostRecruiter.minsalary>='50000' and tblJobPostRecruiter.maxsalary<='50000'
		and  tblJobPostRecruiter.status=0

		
		select ROW_NUMBER()over(order by jobid) as SerialNumber,DATEDIFF(DAY,tblJobPostRecruiter.inserted_date,GETDATE()) As noofdays,* from tblJobPostRecruiter 
		join tblJobprofile on  tblJobPostRecruiter.jobprofileid = tblJobprofile.jobprofileid
		join tblRecruiter on tblJobPostRecruiter.recruiterid = tblRecruiter.recruiterid 
		where tblJobPostRecruiter.jobprofileid=1 and tblJobPostRecruiter.recruiterid=1
		and  tblJobPostRecruiter.minsalary<='60001' and tblJobPostRecruiter.maxsalary>='60001'
		and  tblJobPostRecruiter.status=0

		select ROW_NUMBER()over(order by jobid) as SerialNumber,DATEDIFF(DAY,tblJobPostRecruiter.inserted_date,GETDATE()) As noofdays,* from tblJobPostRecruiter 
		join tblJobprofile on  tblJobPostRecruiter.jobprofileid = tblJobprofile.jobprofileid
		join tblRecruiter on tblJobPostRecruiter.recruiterid = tblRecruiter.recruiterid 
		where tblJobPostRecruiter.jobprofileid=1 and tblJobPostRecruiter.recruiterid=1
		and  tblJobPostRecruiter.minsalary<='60000' and tblJobPostRecruiter.maxsalary>='60000'
		and  tblJobPostRecruiter.status=0

		select * from tblJobPostRecruiter
		where tblJobPostRecruiter.jobprofileid=1 and tblJobPostRecruiter.recruiterid=1
		and  tblJobPostRecruiter.minsalary<='60000' and tblJobPostRecruiter.maxsalary>='60000'
		and  tblJobPostRecruiter.status=0

		if ('tblJobPostRecruiter.maxsalary'=@usersalary)
		begin
		select * from tblJobPostRecruiter
		where tblJobPostRecruiter.jobprofileid=1 and tblJobPostRecruiter.recruiterid=1
		and tblJobPostRecruiter.maxsalary<='60000' and  tblJobPostRecruiter.minsalary<='60000'  
		and  tblJobPostRecruiter.status=0
		end

		if ('tblJobPostRecruiter.maxsalary'='60000')
		begin
		select * from tblJobPostRecruiter
		where tblJobPostRecruiter.jobprofileid=1 and tblJobPostRecruiter.recruiterid=1
		and tblJobPostRecruiter.maxsalary<='60000' and  tblJobPostRecruiter.minsalary<='60000'  
		and  tblJobPostRecruiter.status=0
		end

		select ROW_NUMBER()over(order by jobid) as SerialNumber,DATEDIFF(DAY,tblJobPostRecruiter.inserted_date,GETDATE()) As noofdays, * from tblJobPostRecruiter
		join tblJobprofile on  tblJobPostRecruiter.jobprofileid = tblJobprofile.jobprofileid
		join tblRecruiter on tblJobPostRecruiter.recruiterid = tblRecruiter.recruiterid
		where tblJobPostRecruiter.jobprofileid=1 and tblJobPostRecruiter.recruiterid=1
		and tblJobPostRecruiter.maxsalary<='60000' and  tblJobPostRecruiter.minsalary<='60000'  
		and  tblJobPostRecruiter.status=0

		if @usersalary = (select top(1) (maxsalary)  from tblJobPostRecruiter) 
		--if @usersalary='tblJobPostRecruiter.maxsalary'
		begin
		select ROW_NUMBER()over(order by jobid) as SerialNumber,DATEDIFF(DAY,tblJobPostRecruiter.inserted_date,GETDATE()) As noofdays, * from tblJobPostRecruiter
		join tblJobprofile on  tblJobPostRecruiter.jobprofileid = tblJobprofile.jobprofileid
		join tblRecruiter on tblJobPostRecruiter.recruiterid = tblRecruiter.recruiterid
		where tblJobPostRecruiter.jobprofileid=1 and tblJobPostRecruiter.recruiterid=1
		and tblJobPostRecruiter.maxsalary<='60000' and  tblJobPostRecruiter.minsalary<='60000'  
		and  tblJobPostRecruiter.status=0
		end
		
			select * from tblRecruiter where emailid='hclindia@hcl.com' and password='HCL@@' and tblRecruiter.status=0



		update tblRecruiter set status=0 where recruiterid=1

		update tblRecruiter set status=0 where recruiterid=2
		select * from tblRecruiter
		select * from tbljobseeker

		delete from tblRecruiter where recruiterid=3
		select * from tbljobseeker

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


		








