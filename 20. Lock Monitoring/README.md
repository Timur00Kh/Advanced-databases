# 20. Lock Monitoring

```sql
CREATE TABLE deadlock (
    id BIGINT,
    some_integer INT
);

INSERT INTO deadlock VALUES (1, 2323);
INSERT INTO deadlock VALUES (2, 2324);
SET deadlock_timeout='30s';
```

### Making deadlock situation
![](images/2.png)
![](images/1.png)

### Deadlock monitoring
![](images/3.png)


