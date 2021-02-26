[TOC]

#### 常用mysql

> `分组后加条件然后合并求数量`

```
SELECT t_p_address, COUNT(t_p_address) AS address FROM t_hqzb_balance GROUP BY t_p_address HAVING COUNT(t_p_address)>1
```
