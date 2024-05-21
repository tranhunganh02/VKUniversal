
CREATE TABLE users (
  user_id SERIAL PRIMARY KEY,
  email VARCHAR(70) UNIQUE NOT NULL,
  password TEXT NOT NULL,
  role SMALLINT,
  phone_number VARCHAR(12),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  last_login TIMESTAMP,
  avatar TEXT
);
CREATE TABLE User_profile (
  user_profile_id SERIAL PRIMARY KEY,
  user_id INT,
  bio TEXT,
  FOREIGN KEY (user_id) REFERENCES users(user_id)
);
CREATE TABLE Link (
  link_id SERIAL PRIMARY KEY,
  link_name VARCHAR(200) NOT NULL,
  link_content TEXT,
  profile_id INT
);


CREATE INDEX idx_user_profile_user_id ON User_Profile(user_id);


CREATE TABLE Role (
  role_id SMALLSERIAL PRIMARY KEY,
  role_name VARCHAR(25) NOT NULL
);

INSERT INTO Role (role_name) VALUES ('Student');
INSERT INTO Role (role_name) VALUES ('Lecturer');
INSERT INTO Role (role_name) VALUES ('Department');
INSERT INTO Role (role_name) VALUES ('Admin');


CREATE TABLE token_keys (
  token_id UUID PRIMARY KEY,
  user_id INT NOT NULL,
  private_key TEXT NOT NULL,
  public_key TEXT,
  refresh_token TEXT,
  refresh_tokens_used TEXT[],
  FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE faculty (
  faculty_id SMALLSERIAL PRIMARY KEY,
  faculty_name VARCHAR(90) NOT NULL
);


CREATE TABLE major(
  major_id SMALLSERIAL PRIMARY KEY, 
  major_name VARCHAR(90),
  faculty_id SMALLINT,  
  FOREIGN KEY (faculty_id) REFERENCES faculty(faculty_id)
);

CREATE TABLE university_class (
  class_id SERIAL PRIMARY KEY,
  class_name VARCHAR(20) NOT NULL,
  major_id SMALLINT, 
  FOREIGN KEY (major_id) REFERENCES major(major_id)
);



CREATE TABLE Student (
  student_id SERIAL PRIMARY KEY,
  user_id INT,
  student_code VARCHAR(7),
  surname VARCHAR(20) NOT NULL,
  last_name VARCHAR(20) NOT NULL,
  date_of_birth DATE,
  gender SMALLINT,
  class_id SMALLINT,
  FOREIGN KEY (class_id) REFERENCES university_class(class_id)
);

CREATE TABLE department (
  department_id SERIAL PRIMARY KEY,
  user_id INT,
  department_name VARCHAR(50) NOT NULL,
  department_code VARCHAR(10),
  FOREIGN KEY (user_id) REFERENCES Users(user_id)
);


CREATE TABLE Acedemic_Rank (
  ar_id SERIAL PRIMARY KEY,
  ar_name VARCHAR(75) NOT NULL
);

CREATE TABLE Degree (
  degree_id SERIAL PRIMARY KEY,
  degree_name VARCHAR(75) NOT NULL
);

CREATE TABLE Lecturer (
  lecturer_id SERIAL PRIMARY KEY,
  lecturer_code VARCHAR(7),
  academic_id INT,
  user_id INT,
  faculty_id INT,
  degree_id INT,
  gender SMALLINT,
  surname VARCHAR(30) NOT NULL,
  last_name VARCHAR(30) NOT NULL,
  date_of_birth DATE,
  FOREIGN KEY (user_id) REFERENCES Users(user_id),
  FOREIGN KEY (degree_id) REFERENCES Degree(degree_id),
  FOREIGN KEY (academic_id) REFERENCES Acedemic_Rank(ar_id),
  FOREIGN KEY (faculty_id) REFERENCES Faculty(faculty_id)
);

CREATE TABLE Post (
  post_id SERIAL PRIMARY KEY,
  content TEXT,
  user_id INT,
  privacy BOOLEAN,
  post_type SMALLINT,
  created_at TIMESTAMP NOT NULL,
  updated_at TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

CREATE TABLE Post_Share (
  share_id SERIAL PRIMARY KEY,
  post_id INT,
  user_id INT,
  content TEXT,
  FOREIGN KEY (user_id) REFERENCES Users(user_id),
  FOREIGN KEY (post_id) REFERENCES Post(post_id)
);

CREATE TABLE Post_like (
  like_id SERIAL PRIMARY KEY,
  post_id INT,
  user_id INT,
  FOREIGN KEY (user_id) REFERENCES Users(user_id),
  FOREIGN KEY (post_id) REFERENCES Post(post_id)
);

CREATE TABLE Attachment (
  attachment_id SERIAL PRIMARY KEY,
  post_id INT,
  file_name VARCHAR(50),
  file_type SMALLINT,
  file_url TEXT,
  FOREIGN KEY (post_id) REFERENCES Post(post_id)
);
CREATE TABLE product_type (
    product_type_id SMALLSERIAL PRIMARY KEY,
    product_title VARCHAR(255) NOT NULL
);
ALTER TABLE product_type
ADD COLUMN category_id SMALLINT REFERENCES category(category_id);

CREATE TABLE sell_post (
    sell_post_id SERIAL PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    product_type SMALLINT REFERENCES product_type(product_type_id),
    price NUMERIC NOT NULL,
    detail TEXT,
    user_id INTEGER REFERENCES users(user_id),
    address VARCHAR(255) NOT NULL,
    image_url TEXT[]
);
ALTER TABLE sell_post
ADD COLUMN created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN updated_at TIMESTAMP,
ADD COLUMN image_url VARCHAR(255);



CREATE TABLE category (
    category_id SMALLSERIAL PRIMARY KEY,
    category_name VARCHAR(255) NOT NULL
);
--hàm xoá market post
CREATE OR REPLACE FUNCTION delete_sell_post(sell_post_id INT, user_id INT)
RETURNS BOOLEAN AS $$
DECLARE
    row_deleted BOOLEAN;
BEGIN
    DELETE FROM sell_post 
    WHERE sell_post_id = $1 AND user_id = $2
    RETURNING true INTO row_deleted;

    IF row_deleted THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION delete_sell_post(sell_post_id INT, user_id INT)
RETURNS BOOLEAN AS $$
DECLARE
    row_deleted BOOLEAN;
BEGIN
    DELETE FROM sell_post 
    WHERE sell_post_id = $1 AND user_id = $2
    RETURNING true INTO row_deleted;

    IF row_deleted THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;
END;
$$ LANGUAGE plpgsql;



-- CREATE TABLE Comment (
--   comment_id SERIAL PRIMARY KEY,
--   post_id INT,
--   user_id INT,
--   content VARCHAR(300),
--   created_at TIMESTAMP NOT NULL,
--   updated_at TIMESTAMP,
--   level SMALLINT,
--   FOREIGN KEY (post_id) REFERENCES Post(post_id),
--   FOREIGN KEY (user_id) REFERENCES Users(user_id)
-- );
CREATE OR REPLACE FUNCTION insertOrUpdateToken(
    IN token_id_param UUID,
    IN user_id_param INT,
    IN public_key_param TEXT,
    IN private_key_param TEXT,
    IN refresh_token_param TEXT
) 
RETURNS VOID AS $$
BEGIN
    -- Kiểm tra xem user_id đã tồn tại trong bảng token_keys chưa
    IF EXISTS (SELECT 1 FROM token_keys WHERE user_id = user_id_param) THEN
        -- Nếu user_id đã tồn tại, thực hiện update
        UPDATE token_keys
        SET 
            public_key = public_key_param,
            private_key = private_key_param,
            refresh_token = refresh_token_param,
            refresh_tokens_used = array_append(refresh_tokens_used, (SELECT refresh_token FROM token_keys WHERE user_id = user_id_param))
        WHERE user_id = user_id_param;
    ELSE
        -- Nếu user_id chưa tồn tại, thực hiện insert
        INSERT INTO token_keys (token_id, user_id, public_key, private_key, refresh_token)
        VALUES (token_id_param, user_id_param, public_key_param, private_key_param, refresh_token_param);
    END IF;
END;
$$ LANGUAGE plpgsql;

-- testSelect
SELECT post_id, content, created_at
FROM (
    SELECT post_id, content, created_at
    FROM Post
    WHERE user_id = 1
    UNION ALL
    SELECT p.post_id, p.content, p.created_at
    FROM Post_Share ps
    INNER JOIN Post p ON ps.post_id = p.post_id
    WHERE ps.user_id = 1
) AS combined_posts
ORDER BY created_at DESC;

CREATE OR REPLACE FUNCTION find_and_delete_user(user_id_to_find Int) RETURNS VOID AS $$
BEGIN
  -- Xóa hàng trong bảng token_keys dựa trên userId
  DELETE FROM token_keys WHERE user_id = user_id_to_find;
END;
$$ LANGUAGE plpgsql;

SELECT delete_post_and_attachments(12 , 1);

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
        s.student_id = 1;

CREATE OR REPLACE FUNCTION delete_post_and_attachments(post_id INT, user_id INT) RETURNS BOOLEAN AS $$
DECLARE
  success BOOLEAN := FALSE;
BEGIN
  BEGIN
    -- Xoá các tệp đính kèm có post_id tương ứng
    DELETE FROM Attachment WHERE Attachment.post_id = $1;
    
    -- Xoá bài viết có post_id tương ứng
    DELETE FROM Post WHERE Post.post_id = $1 AND Post.user_id = $2;

    -- Đặt biến success thành TRUE nếu không có lỗi xảy ra
    success := TRUE;
  
  EXCEPTION
    -- Xử lý ngoại lệ và ghi lại thông báo lỗi
    WHEN OTHERS THEN
      RAISE NOTICE 'Error deleting post and attachments: %', SQLERRM;
END;

-- Trả về giá trị của biến success
RETURN success;
END;
$$ LANGUAGE plpgsql;


INSERT INTO major (major_name)
VALUES 
    ('Trí tuệ nhân tạo'),
    ('Truyền thông đa phương tiện'),
    ('Công nghệ thông tin (chương trình toàn cầu)'),
    ('Công nghệ thông tin (tăng cường tiếng Nhật)'),
    ('Công nghệ thông tin (tăng cường tiếng Hàn)'),
    ('Hợp tác doanh nghiệp'),
    ('Kỹ sư phần mềm'),
    ('Mỹ thuật số'),
    ('Khoa học dữ liệu và trí tuệ nhân tạo'),
    ('Thương mại điện tử'),
    ('Marketing kỹ thuật số'),
    ('Kinh tế tài chính'),
    ('Du lịch lữ hành'),
    ('Quản trị kinh doanh (chương trình toàn cầu)'),
    ('Quản trị dự án công nghệ thông tin'),
    ('Logistic'),
    ('Quản trị kinh doanh'),
    ('Kỹ thuật máy tính'),
    ('IoT và Robotics'),
    ('An toàn mạng');

INSERT INTO university_class (class_name)
VALUES 
    ('19IT1'),
    ('19IT2'),
    ('19IT3'),
    ('19IT4'),
    ('19IT5'),
    ('19IT6'),
    ('19CE'),
    ('20AD'),
    ('20DA'),
    ('20GIT'),
    ('20MC'),
    ('20SE1'),
    ('20SE2'),
    ('20SE3'),
    ('20SE4'),
    ('20SE5'),
    ('20SE6'),
    ('20DM'),
    ('20EC'),
    ('20GBA'),
    ('20CE'),
    ('20IR'),
    ('20NS'),
    ('21AD'),
    ('21DA'),
    ('21GIT'),
    ('21JIT'),
    ('21KIT'),
    ('21MC'),
    ('21SE1'),
    ('21SE2'),
    ('21SE3'),
    ('21SE4'),
    ('21SE5'),
    ('21DM1'),
    ('21DM2'),
    ('21EC'),
    ('21EL'),
    ('21ET'),
    ('21GBA'),
    ('21IR'),
    ('21NS'),
    ('21CE1'),
    ('21CE2'),
    ('22AD'),
    ('22DA'),
    ('22GIT1'),
    ('22GIT2'),
    ('22MC'),
    ('22MCB'),
    ('22SE1'),
    ('22SE1B'),
    ('22SE2'),
    ('22SE2B'),
    ('22JIT'),
    ('22BA'),
    ('22DM'),
    ('22EF'),
    ('22EL1'),
    ('22EL2'),
    ('22ET'),
    ('22GBA'),
    ('22IM'),
    ('22CE'),
    ('22CEB'),
    ('22IR'),
    ('22IRB'),
    ('22NS'),
    ('23AI'),
    ('23DA'),
    ('23GIT'),
    ('23GITB'),
    ('23IT1'),
    ('23IT1B'),
    ('23IT2'),
    ('23IT2B'),
    ('23IT3'),
    ('23IT3B'),
    ('23IT4'),
    ('23ITe1'),
    ('23ITe2'),
    ('23BA'),
    ('23DM1'),
    ('23DM2'),
    ('23EF'),
    ('23EL1'),
    ('23EL2'),
    ('23ET'),
    ('23GBA'),
    ('23IM'),
    ('23CE1'),
    ('23CE2'),
    ('23NS1'),
    ('23NS2');

UPDATE major
SET faculty_id = (
    SELECT faculty_id
    FROM faculty
    WHERE faculty_name = 'Khoa học máy tính'
)
WHERE major_name IN ('Trí tuệ nhân tạo', 'Truyền thông đa phương tiện', 'Công nghệ thông tin (chương trình toàn cầu)', 'Công nghệ thông tin (tăng cường tiếng Nhật)', 'Công nghệ thông tin (tăng cường tiếng Hàn)', 'Kỹ sư phần mềm', 'Mỹ thuật số', 'Khoa học dữ liệu và trí tuệ nhân tạo', 'Thương mại điện tử', 'Marketing kỹ thuật số', 'Kinh tế tài chính', 'Du lịch lữ hành', 'Quản trị kinh doanh (chương trình toàn cầu)', 'Quản trị dự án công nghệ thông tin', 'Logistic');

UPDATE major
SET faculty_id = (
    SELECT faculty_id
    FROM faculty
    WHERE faculty_name = 'Kỹ thuật máy tính và điện tử'
)
WHERE major_name IN ('Quản trị kinh doanh', 'Kỹ thuật máy tính', 'IoT và Robotics', 'An toàn mạng');
UPDATE major
SET faculty_id = (
    SELECT faculty_id
    FROM faculty
    WHERE faculty_name = 'Kinh tế số & thương mại điện tử'
)
WHERE major_name IN ('Kinh tế số & thương mại điện tử', 'Hợp tác doanh nghiệp');

-- Cập nhật major_id cho lớp học thuộc major Trí tuệ nhân tạo (AI%)
UPDATE university_class
SET major_id = (
    SELECT major_id
    FROM major
    WHERE major_name = 'Trí tuệ nhân tạo'
)
WHERE class_name LIKE '%AI';

-- Cập nhật major_id cho lớp học thuộc major Truyền thông đa phương tiện (MC%)
UPDATE university_class
SET major_id = (
    SELECT major_id
    FROM major
    WHERE major_name = 'Truyền thông đa phương tiện'
)
WHERE class_name LIKE '%MC';

-- Cập nhật major_id cho lớp học thuộc major Công nghệ thông tin (chương trình toàn cầu) (GIT%)
UPDATE university_class
SET major_id = (
    SELECT major_id
    FROM major
    WHERE major_name = 'Công nghệ thông tin (chương trình toàn cầu)'
)
WHERE class_name LIKE '%GIT%';

-- Cập nhật major_id cho lớp học thuộc major Công nghệ thông tin (tăng cường tiếng Nhật) (JIT%)
UPDATE university_class
SET major_id = (
    SELECT major_id
    FROM major
    WHERE major_name = 'Công nghệ thông tin (tăng cường tiếng Nhật)'
)
WHERE class_name LIKE '%JIT%';

-- Cập nhật major_id cho lớp học thuộc major Công nghệ thông tin (tăng cường tiếng Hàn) (KIT%)
UPDATE university_class
SET major_id = (
    SELECT major_id
    FROM major
    WHERE major_name = 'Công nghệ thông tin (tăng cường tiếng Hàn)'
)
WHERE class_name LIKE '%KIT%';

-- Cập nhật major_id cho lớp học thuộc major Hợp tác doanh nghiệp (ITe%)
UPDATE university_class
SET major_id = (
    SELECT major_id
    FROM major
    WHERE major_name = 'Hợp tác doanh nghiệp'
)
WHERE class_name LIKE '%ITe%';

-- Cập nhật major_id cho lớp học thuộc major Kỹ sư phần mềm (SE%)
UPDATE university_class
SET major_id = (
    SELECT major_id
    FROM major
    WHERE major_name = 'Kỹ sư phần mềm'
)
WHERE class_name LIKE '%SE%';

-- Tiếp tục cập nhật cho các major còn lại...
-- Cập nhật major_id cho lớp học thuộc major Mỹ thuật số (DA%)
UPDATE university_class
SET major_id = (
    SELECT major_id
    FROM major
    WHERE major_name = 'Mỹ thuật số'
)
WHERE class_name LIKE '%DA%';

-- Cập nhật major_id cho lớp học thuộc major Khoa học dữ liệu và trí tuệ nhân tạo (AD%)
UPDATE university_class
SET major_id = (
    SELECT major_id
    FROM major
    WHERE major_name = 'Khoa học dữ liệu và trí tuệ nhân tạo'
)
WHERE class_name LIKE '%AD%';

-- Cập nhật major_id cho lớp học thuộc major Thương mại điện tử (EC%)
UPDATE university_class
SET major_id = (
    SELECT major_id
    FROM major
    WHERE major_name = 'Thương mại điện tử'
)
WHERE class_name LIKE '%EC%';

-- Cập nhật major_id cho lớp học thuộc major Marketing kỹ thuật số (DM%)
UPDATE university_class
SET major_id = (
    SELECT major_id
    FROM major
    WHERE major_name = 'Marketing kỹ thuật số'
)
WHERE class_name LIKE '%DM%';

-- Tiếp tục cập nhật cho các major còn lại...
-- Cập nhật major_id cho lớp học thuộc major Hợp tác doanh nghiệp (ITe%)
UPDATE university_class
SET major_id = (
    SELECT major_id
    FROM major
    WHERE major_name = 'Hợp tác doanh nghiệp'
)
WHERE class_name LIKE '%ITe%';

-- Cập nhật major_id cho lớp học thuộc major Logistic (EL%)
UPDATE university_class
SET major_id = (
    SELECT major_id
    FROM major
    WHERE major_name = 'Logistic'
)
WHERE class_name LIKE '%EL%';

-- Cập nhật major_id cho lớp học thuộc major Quản trị kinh doanh (GBA%)
UPDATE university_class
SET major_id = (
    SELECT major_id
    FROM major
    WHERE major_name = 'Quản trị kinh doanh'
)
WHERE class_name LIKE '%GBA';

-- Cập nhật major_id cho lớp học thuộc major Quản trị dự án công nghệ thông tin (IM%)
UPDATE university_class
SET major_id = (
    SELECT major_id
    FROM major
    WHERE major_name = 'Quản trị dự án công nghệ thông tin'
)
WHERE class_name LIKE '%IM';

-- Tiếp tục cập nhật cho các major còn lại...
-- Cập nhật major_id cho lớp học thuộc major Thương mại điện tử (EC%)
UPDATE university_class
SET major_id = (
    SELECT major_id
    FROM major
    WHERE major_name = 'Thương mại điện tử'
)
WHERE class_name LIKE '%EC%';

-- Cập nhật major_id cho lớp học thuộc major Marketing kỹ thuật số (DM%)
UPDATE university_class
SET major_id = (
    SELECT major_id
    FROM major
    WHERE major_name = 'Marketing kỹ thuật số'
)
WHERE class_name LIKE '%DM';

-- Cập nhật major_id cho lớp học thuộc major Kinh tế tài chính (EF%)
UPDATE university_class
SET major_id = (
    SELECT major_id
    FROM major
    WHERE major_name = 'Kinh tế tài chính'
)
WHERE class_name LIKE '%EF%';

-- Cập nhật major_id cho lớp học thuộc major Du lịch lữ hành (ET%)
UPDATE university_class
SET major_id = (
    SELECT major_id
    FROM major
    WHERE major_name = 'Du lịch lữ hành'
)
WHERE class_name LIKE '%ET%';

-- Cập nhật major_id cho lớp học thuộc major Quản trị kinh doanh (BA%)
UPDATE university_class
SET major_id = (
    SELECT major_id
    FROM major
    WHERE major_name = 'Quản trị kinh doanh'
)
WHERE class_name LIKE '%BA%';

-- Cập nhật major_id cho lớp học thuộc major Kỹ thuật máy tính (CE%)
UPDATE university_class
SET major_id = (
    SELECT major_id
    FROM major
    WHERE major_name = 'Kỹ thuật máy tính'
)
WHERE class_name LIKE '%CE%';

-- Cập nhật major_id cho lớp học thuộc major IoT và Robotics (IR%)
UPDATE university_class
SET major_id = (
    SELECT major_id
    FROM major
    WHERE major_name = 'IoT và Robotics'
)
WHERE class_name LIKE '%IR%';

-- Cập nhật major_id cho lớp học thuộc major An toàn mạng (NS%)
UPDATE university_class
SET major_id = (
    SELECT major_id
    FROM major
    WHERE major_name = 'An toàn mạng'
)
WHERE class_name LIKE '%NS%';

-- Tiếp tục cập nhật cho các major còn lại...
-- Cập nhật major_id cho lớp học thuộc major Khoa học máy tính (IT%)
UPDATE university_class
SET major_id = (
    SELECT major_id
    FROM major
    WHERE major_name = 'Khoa học máy tính'
)
WHERE class_name LIKE '%IT%';

-- Cập nhật major_id cho lớp học thuộc major Kỹ sư phần mềm (SE%)
UPDATE university_class
SET major_id = (
    SELECT major_id
    FROM major
    WHERE major_name = 'Kỹ sư phần mềm'
)
WHERE class_name LIKE '%SE%';

-- Cập nhật major_id cho lớp học thuộc major Thương mại điện tử (DM%)
UPDATE university_class
SET major_id = (
    SELECT major_id
    FROM major
    WHERE major_name = 'Thương mại điện tử'
)
WHERE class_name LIKE '%DM%';

-- Cập nhật major_id cho lớp học thuộc major Kỹ thuật máy tính và điện tử (CE%)
UPDATE university_class
SET major_id = (
    SELECT major_id
    FROM major
    WHERE major_name = 'Kỹ thuật máy tính và điện tử'
)
WHERE class_name LIKE '%CE%';

-- Cập nhật major_id cho lớp học thuộc major Công nghệ thông tin (chương trình toàn cầu) (GIT%)
UPDATE university_class
SET major_id = (
    SELECT major_id
    FROM major
    WHERE major_name = 'Công nghệ thông tin (chương trình toàn cầu)'
)
WHERE class_name LIKE '%GIT%';

-- Cập nhật major_id cho lớp học thuộc major Khoa học máy tính (MCB%)
UPDATE university_class
SET major_id = (
    SELECT major_id
    FROM major
    WHERE major_name = 'Khoa học máy tính'
)
WHERE class_name LIKE '%MCB%';

-- Cập nhật major_id cho lớp học thuộc major Kỹ sư phần mềm (SE1B%)
UPDATE university_class
SET major_id = (
    SELECT major_id
    FROM major
    WHERE major_name = 'Kỹ sư phần mềm'
)
WHERE class_name LIKE '%SE1B%';

-- Cập nhật major_id cho lớp học thuộc major IoT và Robotics (IRB%)
UPDATE university_class
SET major_id = (
    SELECT major_id
    FROM major
    WHERE major_name = 'IoT và Robotics'
)
WHERE class_name LIKE '%IRB%';

-- Cập nhật major_id cho lớp học thuộc major Hợp tác doanh nghiệp (ITe%)
UPDATE university_class
SET major_id = (
    SELECT major_id
    FROM major
    WHERE major_name = 'Hợp tác doanh nghiệp'
)
WHERE class_name LIKE '%ITe%';




INSERT INTO acedemic_rank (ar_name)
VALUES 
  ('Giáo sư'),
  ('Phó giáo sư'),
  ('Tiến sĩ'),
  ('Thạc sĩ'),
  ('Giảng viên');

INSERT INTO degree (degree_name)
VALUES 
  ('Tiến sĩ'),
  ('Thạc sĩ'),
  ('Cử nhân');


INSERT INTO faculty (faculty_name)
VALUES 
  ('Khoa học máy tính'),
  ('Kinh tế số & thương mại điện tử'),
  ('Kỹ thuật máy tính và điện tử');


--tao san user phong ban va profile
INSERT INTO users ( email, password, role, created_at)
VALUES
    ( 'DEP1@vku.udn.vn', '$2y$10$eFoHMD7lF706hUNWtMSp0udYoIGpweA/uAS4SR118D7roTsT5iB/e', 3, NOW()),
    ( 'DEP2@vku.udn.vn', '$2y$10$eFoHMD7lF706hUNWtMSp0udYoIGpweA/uAS4SR118D7roTsT5iB/e', 3, NOW()),
    ( 'DEP3@vku.udn.vn', '$2y$10$eFoHMD7lF706hUNWtMSp0udYoIGpweA/uAS4SR118D7roTsT5iB/e', 3, NOW()),
    ( 'DEP4@vku.udn.vn', '$2y$10$eFoHMD7lF706hUNWtMSp0udYoIGpweA/uAS4SR118D7roTsT5iB/e', 3, NOW()),
    ( 'DEP5@vku.udn.vn', '$2y$10$eFoHMD7lF706hUNWtMSp0udYoIGpweA/uAS4SR118D7roTsT5iB/e', 3, NOW()),
    ( 'DEP6@vku.udn.vn', '$2y$10$eFoHMD7lF706hUNWtMSp0udYoIGpweA/uAS4SR118D7roTsT5iB/e', 3, NOW()),
    ( 'DEP7@vku.udn.vn', '$2y$10$eFoHMD7lF706hUNWtMSp0udYoIGpweA/uAS4SR118D7roTsT5iB/e', 3, NOW()),
    ( 'DEP8@vku.udn.vn', '$2y$10$eFoHMD7lF706hUNWtMSp0udYoIGpweA/uAS4SR118D7roTsT5iB/e', 3, NOW());



INSERT INTO department (user_id, department_name, department_code)
VALUES 
  (5, 'Phòng Tổ chức - Hành chính', 'DEP1'),
  (6, 'Phòng Đào tạo', 'DEP2'),
  (7, 'Phòng Công tác sinh viên', 'DEP3'),
  (8, 'Department 4', 'DEP4'),
  (9, 'Department 5', 'DEP5'),
  (10, 'Department 6', 'DEP6'),
  (11, 'Department 7', 'DEP7'),
  (12, 'Department 8', 'DEP8');

UPDATE department 
SET department_name = CASE 
                          WHEN user_id = 5 THEN 'Phòng Tổ chức - Hành chính'
                          WHEN user_id = 6 THEN 'Phòng Đào tạo'
                          WHEN user_id = 7 THEN 'Phòng Công tác sinh viên'
                          WHEN user_id = 8 THEN 'Phòng Khoa học công nghệ - Hợp tác quốc tế'
                          WHEN user_id = 9 THEN 'Phòng Khảo thí và đảm bảo chất lượng giáo dục'
                          WHEN user_id = 10 THEN 'Phòng Thanh tra - Pháp chế'
                          WHEN user_id = 11 THEN 'Phòng Cơ sở vật chất'
                          WHEN user_id = 12 THEN 'Phòng Kế hoạch - Tài Chính'
                      END;


-- get student

INSERT INTO category (category_name) VALUES ('Đồ điện tử'),('Đồ gia dụng'),('Thời trang và phụ kiện'),
 ('Đồ chơi và sở thích'),
 ('Sách');


-- Đồ điện tử
INSERT INTO product_type (product_title, category_id) VALUES ('Điện thoại di động', 1),
 ('Máy tính bảng', 1),
 ('Máy tính xách tay', 1),
 ('Máy tính để bàn', 1),
 ('Máy ảnh và máy quay phim', 1),
 ('Thiết bị âm thanh', 1),
 ('Thiết bị điện tử gia dụng', 1), ('Bàn ghế', 2),
 ('Tủ kệ', 2),
 ('Đèn', 2),
 ('Trang trí nội thất', 2),
 ('Dụng cụ nhà bếp', 2),
 ('Đồ nội thất văn phòng', 2),
 ('Quần áo', 3),
 ('Giày dép', 3),
 ('Túi xách và cặp sách', 3),
 ('Đồ trang sức', 3),
 ('Đồng hồ', 3),
 ('Phụ kiện thời trang', 3),
 ('Đồ chơi trẻ em', 4),
 ('Trò chơi điện tử', 4),
 ('Bộ sưu tập', 4),
 ('Đồ thể thao và dã ngoại', 4),
 ('Nhạc cụ', 4),
 ('Đồ điều khiển từ xa', 4),
 ('Sách mới và cũ', 5),
 ('Văn phòng phẩm', 5),
 ('Bưu thiếp và sách báo', 5),
 ('Dụng cụ học tập', 5),
 ('Đồ dùng văn phòng', 5);

--create function get all category and product_type 

SELECT
    c.category_id,
    c.category_name,
    json_agg(json_build_object(
        'product_type_id', pt.product_type_id,
        'product_title', pt.product_title
    )) AS product_types
FROM
    category c
LEFT JOIN
    product_type pt ON c.category_id = pt.category_id
GROUP BY
    c.category_id, c.category_name;


SELECT sell_post_id, image_url[1], product_name, price FROM sell_post ORDER BY created_at LIMIT 6 OFFSET 12;

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
        s.user_id = 18




 SELECT EXISTS (
            SELECT 1
            FROM follow
            WHERE follower_id = 17 AND followed_id = 18
        ) AS user1_follows_user2,
        EXISTS (
            SELECT 1
            FROM follow
            WHERE follower_id = 18 AND followed_id = 177
        ) AS user2_follows_user1;

SELECT p.post_id, p.content, p.content, p.created_at, u.email
FROM post p
JOIN users u ON p.user_id = u.user_id
WHERE p.content ILIKE '%con%' OR u.email LIKE '%con%'
LIMIT 6;
