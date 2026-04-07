CREATE OR REPLACE FUNCTION NthHighestSalary(N INT) RETURNS TABLE (Salary INT) AS $$
BEGIN
  RETURN QUERY (
 select s::int  from (SELECT s,DENSE_RANK() OVER (ORDER BY s DESC) AS rnk
      FROM (
          SELECT DISTINCT Employee.salary as s
          FROM Employee
      ) AS one ) as res where rnk = N
  );
END;
$$ LANGUAGE plpgsql;
