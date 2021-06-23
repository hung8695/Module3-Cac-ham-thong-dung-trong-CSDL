use qlsv;
/*Hien thi so luong hoc vien tung noi*/
select Address,  count(studentID) as "Số lượng học viên"
from student
group by Address;
/*Tinh diem TB moi mon hoc cua tung hoc vien*/
select student.studentID, student.studentName,avg(mark)
from student join mark on student.studentID=mark.studentID
group by student.studentID, student.studentName;
/*Hien thi nhung hoc vien co diem TB>15*/
select studentName, mark,avg(mark)
from student join mark on student.studentID=mark.studentID
group by student.studentID, student.studentID
having avg(mark)>15;
/*Hien thi thong tin hoc vien co diem TB lon nhat*/
select student.studentID,student.studentName,avg(mark)
from student join mark on student.studentID=mark.studentID
group by student.studentID, student.studentName
having avg(mark)>=all(select avg(mark) from mark group by mark.studentID);

