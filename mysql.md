[TOC]
#### 常用mysql>
>`分组后加条件然后合并求数量`

```mysql
SELECT t_p_address, COUNT(t_p_address) AS address FROM
t_h_balance GROUP BY t_p_address HAVING COUNT(t_p_address)>1
```
>`手机号查询重复并且删除只剩下id最小的一条`

```mysql
DELETE FROM t_h_error WHERE id NOT IN (SELECT id from ( SELECT min(id) AS id FROM t_h_error GROUP BY t_phone)a)
```

>`地址分组以后数量求和`
```mysql
SELECT  t_p_address,  SUM(t_amount) as t_total_amount, id
FROM t_h_balance GROUP BY t_p_address
```
>`查询重复的数据并排序`

```mysql
SELECT * FROM t_h_user_copy tU WHERE t_phone IN (SELECT t_phone FROM t_h_user_copy tU GROUP BY t_phone HAVING COUNT(t_phone)>1)  ORDER BY `t_phone` DESC
```

>`查询重复的个数并排序`

```mysql
SELECT id,t_address,t_amount,t_phone, COUNT(t_phone) as cP FROM t_h_user_copy tU GROUP BY t_phone HAVING COUNT(t_phone)>1 ORDER BY cP DESC
```



```mysql
SELECT t_address, COUNT(t_address) AS cAddress,id,t_address_balance,SUM(t_amount) as sumAmount FROM t_h_error  WHERE  t_address_balance>0 GROUP BY t_address ORDER BY id ASC
```