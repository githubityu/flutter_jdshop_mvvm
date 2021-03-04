[TOC]
#### 常用mysql>
>`分组后加条件然后合并求数量`

```mysql
SELECT t_p_address, COUNT(t_p_address) AS address FROM
t_hqzb_balance GROUP BY t_p_address HAVING COUNT(t_p_address)>1
```
>`手机号查询重复并且删除只剩下id最小的一条`

```mysql
DELETE FROM t_hqzb_error WHERE id NOT IN (SELECT id from ( SELECT min(id) AS id FROM t_hqzb_error GROUP BY t_phone)a)
```

>`地址分组以后数量求和`
```mysql
SELECT  t_p_address,  SUM(t_amount) as t_total_amount, id
FROM t_hqzb_balance GROUP BY t_p_address
```


