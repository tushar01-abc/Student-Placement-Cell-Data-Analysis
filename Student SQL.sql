

--  TOTAL NUMBER OF STUDENTS
SELECT COUNT(*) AS total_students
FROM student_dashboard_data;

-- ============================================

--  PLACED VS NOT PLACED COUNT
SELECT placement_status, COUNT(*) AS total_students
FROM student_dashboard_data
GROUP BY placement_status;

-- ============================================

--  PLACEMENT PERCENTAGE
SELECT 
    ROUND(
        COUNT(*) FILTER (WHERE placement_status = 'Placed') * 100.0 / COUNT(*),
        2
    ) AS placement_percentage
FROM student_dashboard_data;

-- ============================================

--  COURSE-WISE PLACED STUDENTS
SELECT course_name, COUNT(*) AS placed_students
FROM student_dashboard_data
WHERE placement_status = 'Placed'
GROUP BY course_name
ORDER BY placed_students DESC;

-- ============================================

--  COURSE-WISE AVERAGE PACKAGE
SELECT course_name,
       ROUND(AVG(package_lpa), 2) AS average_package
FROM student_dashboard_data
WHERE placement_status = 'Placed'
GROUP BY course_name
ORDER BY average_package DESC;

-- ============================================

--  TOP 5 RECRUITING COMPANIES
SELECT company_name, COUNT(*) AS total_hires
FROM student_dashboard_data
WHERE placement_status = 'Placed'
GROUP BY company_name
ORDER BY total_hires DESC
LIMIT 5;

-- ============================================

--  HIGHEST PACKAGE OFFERED
SELECT MAX(package_lpa) AS highest_package
FROM student_dashboard_data;

-- ============================================

--  STUDENT(S) WITH HIGHEST PACKAGE
SELECT student_id, course_name, company_name, package_lpa
FROM student_dashboard_data
WHERE package_lpa = (
    SELECT MAX(package_lpa) FROM student_dashboard_data
);

-- ============================================

--  CITY-WISE JOB DISTRIBUTION
SELECT city, COUNT(*) AS total_jobs
FROM student_dashboard_data
WHERE placement_status = 'Placed'
GROUP BY city
ORDER BY total_jobs DESC;

-- ============================================

--DEGREE MARKS VS PLACEMENT STATUS
SELECT placement_status,
       ROUND(AVG(degree_marks), 2) AS average_marks
FROM student_dashboard_data
GROUP BY placement_status;

-- ============================================

--  ELIGIBLE BUT NOT PLACED STUDENTS
SELECT *
FROM student_dashboard_data
WHERE degree_marks >= 60
AND placement_status = 'Not Placed';

-- ============================================

--  CREATE VIEW FOR DASHBOARD (POWER BI / TABLEAU)
CREATE OR REPLACE VIEW placement_dashboard AS
SELECT 
    course_name,
    placement_status,
    city,
    package_lpa,
    degree_marks
FROM student_dashboard_data;



