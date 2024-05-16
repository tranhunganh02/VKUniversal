SELECT * from student
SELECT * from users;
-- SELECT * from university_class
-- update student
-- set class_id = 32
-- where user_id = 9
SELECT
        s.user_id,
        s.student_code,
        s.surname,
        s.last_name,
        s.date_of_birth,
        s.gender,
        uc.class_id,
        uc.class_name,
        m.major_id,
        m.major_name
    FROM
        student s
    JOIN
        university_class uc ON s.class_id = uc.class_id
    JOIN
        major m ON uc.major_id = m.major_id
    WHERE
        s.user_id = 9;