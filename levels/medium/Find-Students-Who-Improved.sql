select student_id , subject , min_score as first_score , max_score as latest_score from(select student_id , subject , min_score , max_score from (
    (select student_id as id ,subject as min_sub, min_date as min_date1 , max_date as max_date1, min_score from (select min_max_date.student_id ,min_max_date.subject, min_date , max_date , score as min_score from (select  student_id , subject , min(exam_date) as min_date , max(exam_date) as max_date  from Scores group by student_id , subject ) as min_max_date join Scores on min_max_date.student_id = Scores.student_id and min_max_date.subject = Scores.subject where exam_date = min_date ) as min_score ) as minmum_score

    join

    (select student_id ,subject, min_date , max_date , max_score from (select min_max_date.student_id ,min_max_date.subject, min_date , max_date , score as max_score from (select  student_id , subject , min(exam_date) as min_date , max(exam_date) as max_date  from Scores group by student_id , subject ) as min_max_date join Scores on min_max_date.student_id = Scores.student_id and min_max_date.subject = Scores.subject where exam_date = max_date ) as max_score) as maximum_score  on minmum_score.id = maximum_score.student_id  and minmum_score.min_sub = maximum_score.subject
    ) as result ) as final where max_score > min_score order by student_id , subject;
