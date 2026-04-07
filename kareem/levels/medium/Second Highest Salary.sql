SELECT COALESCE((SELECT DISTINCT salary FROM (SELECT DENSE_RANK() over (ORDER BY salary DESC) AS rank , salary FROM Employee) WHERE rank = 2) , NULL) AS SecondHighestSalary;
