create database demo;

use demo;

create table student (
studentid int primary key,
firstname varchar(100),
lastname varchar(100),
email varchar(100),
birthdate date,
enroolmentdate date
);

insert into student (studentid, firstname, lastname, email, birthdate, enroolmentdate) values
(1, 'ajay', 'varma', 'ajay.doe@gmail.com', '2000-01-25', '2022-08-01'),
(2, 'jay', 'raval', 'jay.raval@gmail.com', '1999-05-25', '2021-08-01');

create table courses (
    courseid int primary key,
    coursename varchar(100) not null,
    departmentid int,
    credits int check (credits > 0)
);

insert into courses (courseid, coursename, departmentid, credits)
values
(101, 'introduction to sql', 1, 3),
(102, 'data structures', 2, 4);

create table instructors (
instructorsid int primary key,
firstname varchar(100),
lastname varchar(100),
email varchar(100),
departmentid int
);

insert into instructors(instructorsid, firstname, lastname, email, departmentid) values
(1, 'alice', 'johnson', 'alice.johnson@univ.com', 1),
(2, 'bob', 'lee', 'bob.lee@univ.com', 2);

create table enrollments (
    enrollmentid int primary key,
    studentid int,
    courseid int,
    enrollmentdate date
);

insert into enrollments (enrollmentid, studentid, courseid, enrollmentdate)
values
(1, 1, 101, '2022-08-01'),
(2, 2, 102, '2021-08-01');

create table departments (
    departmentid int primary key,
    departmentname varchar(100)
);

insert into departments (departmentid, departmentname)
values
(1, 'computer science'),
(2, 'mathematics');

-- create
insert into student (studentid, name, class, city)
values (6, 'rahul', 10, 'delhi');

-- read
select * from student;

-- update
update student
set city = 'mumbai'
where studentid = 6;

-- delete
delete from student
where studentid = 6;

select *
from enrollments
where year(enrollmentdate) > 2022;

select *
from courses
where departmentid = 2
limit 5;

select courseid, count(studentid) as total_students
from enrollments
group by courseid
having count(studentid) > 5;

select s.studentid, s.firstname
from student s
where s.studentid in (
    select studentid
    from enrollments e
    join courses c on e.courseid = c.courseid
    where c.coursename = 'introduction to sql'
)
and s.studentid in (
    select studentid
    from enrollments e
    join courses c on e.courseid = c.courseid
    where c.coursename = 'data structures'
);

select distinct s.studentid, s.lastname
from student s
join enrollments e on s.studentid = e.studentid
join courses c on e.courseid = c.courseid
where c.coursename in ('introduction to sql', 'data structures');

select avg(credits) as avg_credits
from courses;

select max(firstname) as max_firstname
from instructors
where departmentid = 1;

select d.departmentname, count(e.studentid) as total_students
from departments d
join courses c on d.departmentid = c.departmentid
join enrollments e on c.courseid = e.courseid
group by d.departmentname;

select s.studentid, s.firstname, c.coursename
from student s
inner join enrollments e on s.studentid = e.studentid
inner join courses c on e.courseid = c.courseid;

select s.studentid, s.lastname, c.coursename
from student s
left join enrollments e on s.studentid = e.studentid
left join courses c on e.courseid = c.courseid;

select s.*
from student s
where s.studentid in (
    select studentid
    from enrollments
    where courseid in (
        select courseid
        from enrollments
        group by courseid
        having count(studentid) > 10
    )
);

select enrollmentid, studentid,
year(enrollmentdate) as enrollment_year
from enrollments;

select concat(firstname, ' ', lastname) as instructor_name
from instructors;

select enrollmentid,
       studentid,
       sum(1) over (order by enrollmentid) as running_total
from enrollments;

select studentid,
       enrollmentdate,
       case
           when datediff(curdate(), enrollmentdate) / 365 > 4
           then 'senior'
           else 'junior'
       end as category
from enrollments;





