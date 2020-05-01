# 6. Inherited Table

```sql
SELECT
    (SELECT count(id) FROM student1) as student1,
    (SELECT count(id) FROM student2) as student2,
    (SELECT count(id) FROM student3) as student3,
    (SELECT count(id) FROM student4) as student4,
    (SELECT count(id) FROM student5) as student5,
    (SELECT count(id) FROM student6) as student6,
    (SELECT count(id) FROM student7) as student7,
    (SELECT count(id) FROM student8) as student8,
    (SELECT count(id) FROM student9) as student9,
    (SELECT count(id) FROM student10) as student10
```