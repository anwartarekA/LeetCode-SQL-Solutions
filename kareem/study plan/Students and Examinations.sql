SELECT Students.student_id , (SELECT student_name FROM Students S WHERE Students.student_id = S.student_id),Subjects.subject_name , (CASE WHEN Examinations.subject_name IS NULL THEN 0 ELSE COUNT(*) END)  AS attended_exams FROM Students
CROSS JOIN Subjects
LEFT OUTER JOIN Examinations
ON Examinations.student_id = Students.student_id AND Subjects.subject_name = Examinations.subject_name
GROUP BY Students.student_id , Examinations.subject_name,Subjects.subject_name
ORDER BY Students.student_id, Subjects.subject_name