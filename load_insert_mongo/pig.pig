
-- First, register jar dependencies
 
REGISTER mongo-hadoop-pig-1.4.0.jar
REGISTER mongo-hadoop-core-1.4.0.jar


persons = LOAD 'mongodb://localhost/test.persons'
      USING com.mongodb.hadoop.pig.MongoLoader('name:chararray, department_id:int')
      AS (person_name, department_id);
 
departments = LOAD 'mongodb://localhost/test.departments'
              USING com.mongodb.hadoop.pig.MongoLoader('u__id:int, name:chararray')
              AS (department_id, department_name);

joinDepartmentPersons = JOIN departments BY department_id LEFT OUTER,
 persons BY department_id;
 
/* note: the join will prefix all the fields with the original collections:
 e.g., departments::department_id, departments::name, person::person_name, ... */
 
result = FOREACH joinDepartmentPersons
         GENERATE persons::person_name as person_name,
                  departments::department_name as department_name;
STORE result INTO 'mongodb://localhost/test.person_department'
    USING com.mongodb.hadoop.pig.MongoStorage();


dump joinDepartmentPersons ; 

 

