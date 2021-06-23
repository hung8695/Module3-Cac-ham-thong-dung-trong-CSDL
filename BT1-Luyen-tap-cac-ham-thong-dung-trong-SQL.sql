use qlsv;
/*Hien thi thong tin mon hoc co credit lon nhat*/
select SubID,SubName,credit from subject, student
group by SubID,subName
having max(credit)=(select max(credit) from subject);
/*Hien thi mon hoc co diem thi lon nhat*/
select subject.SubName,max(Mark) as "Diem lon nhat"
from subject join mark on subject.SubID=markID
group by subject.SubName
having max(Mark)=(select max(Mark) from mark);
/*Hiển thị các thông tin sinh viên và điểm trung bình
 của mỗi sinh viên, xếp hạng theo thứ tự điểm giảm dần*/
select student.StudentID, student.StudentName,class.ClassName,avg(Mark) as "Điểm TB"
from student join mark on student.StudentId=mark.StudentId join class on class.classID=student.classID
group by student.StudentId,student.StudentName, class.ClassName
order by avg(Mark) desc


