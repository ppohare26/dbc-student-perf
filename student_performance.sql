-- Databricks notebook source
-- MAGIC %md
-- MAGIC # Exploring Influential Factors in Student Academic Performance

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ## Objective
-- MAGIC
-- MAGIC - Determine the total number of students in the dataset.
-- MAGIC
-- MAGIC - Identify the number of students with exam scores below 70.
-- MAGIC
-- MAGIC - Analyze the gender distribution of students (male vs. female).
-- MAGIC
-- MAGIC - Examine how many male and female students scored below 70.
-- MAGIC
-- MAGIC - Analyze the distribution of students based on school type.
-- MAGIC
-- MAGIC - Assess the relationship between attendance and exam scores.
-- MAGIC
-- MAGIC - Evaluate the impact of weekly study hours and the number of tutoring sessions on exam performance.
-- MAGIC
-- MAGIC - Investigate whether family income and school type influence student scores.

-- COMMAND ----------

-- DBTITLE 1,Check the data
select * from student_data

-- COMMAND ----------

-- DBTITLE 1,Total Student Count
select count(ID) as Count from student_data

-- COMMAND ----------

-- DBTITLE 1,Number of students having <70
select count(ID) as Count from student_data where Exam_Score < 70

-- COMMAND ----------

-- DBTITLE 1,Number of students based on Gender
select count(ID) as Count, Gender from student_data group by Gender

-- COMMAND ----------

-- DBTITLE 1,Number of students based on Gender and exam score less than 70
select count(ID) as Count, Gender from student_data where Exam_Score < 70 group by Gender

-- COMMAND ----------

-- DBTITLE 1,School Type
select count(ID) as Count, School_Type from student_data where Exam_Score < 70 group by School_Type

-- COMMAND ----------

-- DBTITLE 1,Attendance
select count(ID) as Count, 
case when Attendance between 60 and 70 then '60-70' when Attendance between 71 and 80 then '71-80' when Attendance between 81 and 90 then '81-90' else '90+' end Attendance
from student_data where Exam_Score < 70
group by 2 order by Attendance

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Most of the students whose attendance is less 80 has scored less than 70 marks.

-- COMMAND ----------

select count(ID) as Count,
case when Hours_Studied between 1 and 15 then '1-15' when Hours_Studied between 16 and 24 then '16-24' when Hours_Studied between 25 and 35 then '25-35' else '36+' end Hours_Studied,
case when Tutoring_Sessions between 0 and 2 then 'Less' when Tutoring_Sessions between 3 and 5 then 'Medium' else 'High' end Tutoring_Sessions
from student_data where Exam_Score < 70
group by 2,3 order by Hours_Studied, Tutoring_Sessions

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Students who studied less than 24h hours a week and who didn't get enough tutoring are higher than others

-- COMMAND ----------

select count(ID) as Count, Family_Income, School_Type
from student_data where Exam_Score < 70
group by 2,3 order by Count

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Maximum students whose family income is medium or low and are in public schools have less than 70 marks.

-- COMMAND ----------

-- MAGIC %md
-- MAGIC

-- COMMAND ----------

-- MAGIC %md
-- MAGIC