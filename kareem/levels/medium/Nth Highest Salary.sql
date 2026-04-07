CREATE OR REPLACE FUNCTION NthHighestSalary(N INT) RETURNS TABLE (Salary INT) AS $$
BEGIN
  RETURN QUERY (

    SELECT a.salary FROM (SELECT Employee.salary , ROW_NUMBER() OVER (ORDER BY Employee.salary DESC) AS id FROM Employee GROUP BY Employee.salary) a WHERE id = N
      
  );
END;
$$ LANGUAGE plpgsql;