-- [Business Transaction]

-- 1. What are the Annual average temperature difference in the city where Boston University locates? 

Select avgHTem-avgLTem avgTem
from Study4U_City
Where ctyId in
(Select ctyId
from Study4U_School
Where sclName='Boston University')

-- 2. Average rank of all rankings for each school
select b.sclName,a.prgType,avg(prgRank) avgRank from 
(select prgId,prgRank
from Study4U_prgrank
) as c
inner join
(select prgType,sclId,prgId from Study4U_Program) a
on c.prgId=a.prgId
inner join
(select sclName,sclId from Study4U_School) b
on a.sclId=b.sclId
group by b.sclName,a.prgType
order by prgType,avg(prgRank)


-- 3. How many rankings according to different programs do we have?
select  distinct prgType,yr,cate,count(*) schoolNumber
from Study4U_Program c, Study4U_prgrank e
where c.prgId=e.prgId
group by  prgType,yr,cate
order by prgType,yr,cate

-- 4. List top 10 (average ranking) MSBA program along with it's details (including ...)
select top 10 avg(prgRank) avgPrgRank, sclName, clgName, prgType, inStaTui, outStaTui, prgLength, optLength
from Study4U_School b, Study4U_Program c, Study4U_prgrank e
where b.sclId=c.sclId and c.prgId=e.prgId
and prgType='MSBA'
group by sclName, clgName, prgType, inStaTui, outStaTui, prgLength, optLength
order by avg(prgRank)


-- 5. List all rankings of University of Maryland-college park
select prgType rankBy , year(yr) yr ,cate, prgRank as ranks
from Study4U_School b, Study4U_Program c, Study4U_prgrank e
where b.sclId=c.sclId and c.prgId=e.prgId
and sclName = 'University of Maryland-college park'
union
select 'School' school, year(yr) yr ,cate, sclRank
from Study4U_School b, Study4U_sclrank d
where b.sclId=d.sclId
and sclName = 'University of Maryland-college park'
order by prgType, yr, cate


-- 6. List schools that their average ranking is within 100 and located in California along with their school type and class size
select sclName, sclTP, clgSize, avg(sclRank) avgSclRank, ctyName
from Study4U_City a, Study4U_School b, Study4U_sclrank e
where a.ctyId=b.ctyId and b.sclId=e.sclId
and st='CA'
group by sclName, sclTP, clgSize, ctyName
having avg(sclRank) < 101
order by avg(sclRank)

-- 7. What is the temperature, average living cost and average rent in the city that Harvard located in?
select ctyName, st, avgHTem,avgLTem, avgCostOfLiving, avgRent, avgMonthlyPass, avgOneWayFee
from Study4U_City a, Study4U_School b
where a.ctyId=b.ctyId
and sclName like '%Harvard%'

-- 8. What are schools that located in the cities where their cost of living is higher than the average cost of living?
select sclName, a.avgCostOfLiving
from Study4U_City a, Study4U_School b, 
(select avg(avgCostOfLiving) avgCostOfLiving from Study4U_City) f
where a.ctyId=b.ctyId
and a.avgCostOfLiving > f.avgCostOfLiving
order by  a.avgCostOfLiving


