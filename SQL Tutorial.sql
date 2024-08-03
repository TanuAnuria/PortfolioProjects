

/* Select, Count, Max, Min, Average, Distinct
Where Statement
<,>,<>, And, or, like, null, Not Null, In
Group By, Order By
*/
/*Select * from EmployeeDemographics
order by 4 Desc, 5 Desc

SELECT Gender,Count(Gender)As CountGender
FROM EmployeeDemographics
Where Age > 35
Group By Gender
order by Gender
*/

/* Inner join, Left/Right join, Full outer join */

/*SELECT *
FROM SQLTutorial.dbo.EmployeeDemographics
Full Outer Join SQLTutorial.dbo.EmployeeSalary
ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
*/
--Union, Union All
/*SELECT EmployeeID, Firstname, Age
FROM SQLTutorial.dbo.EmployeeDemographics
Union
SELECT EmployeeID, Jobtitle, Salary
FROM SQLTutorial.dbo.EmployeeSalary
order by EmployeeID
*/

-- Using: Case Statement

--Select Firstname, Lastname, Age,
--CASE 
--	WHEN Age>30 THEN 'old'
--	WHEN Age between 27 and 30 THEN 'young'
--	ELSE 'child'
--END
--from SQLTutorial.dbo.EmployeeDemographics
--order by Age

--SELECT Firstname, Lastname, Jobtitle, Salary,
--CASE
--	WHEN Jobtitle = 'Salesman' THEN Salary + (Salary*.10)
--	WHEN Jobtitle = 'Engineer' THEN Salary + (Salary * .50)
--	WHEN Jobtitle = 'HR' THEN Salary + (Salary *.000001)
--	ELSE Salary + (Salary*.03)
--END AS SalaryAfterRaise
--FROM SQLTutorial.dbo.EmployeeDemographics
--join SQLTutorial.dbo.EmployeeSalary
--on EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID

/* Having Clause
*/

/* Updating/Deleting data
*/

--Select * 
--from SQLTutorial.dbo.EmployeeDemographics

--Update SQLTutorial.dbo.EmployeeDemographics
--Set Firstname = 'Gamora', Gender = 'Female'
--where Lastname = 'Malone'

--Delete From SQLTutorial.dbo.EmployeeDemographics
--where EmployeeID = 1002

/* Aliasing
*/
--Select Demo.EmployeeID, Sal.Salary
--From SQLTutorial.dbo.EmployeeDemographics As Demo
--join SQLTutorial.dbo.EmployeeSalary As Sal
--on Demo.EmployeeID = Sal.EmployeeID

/* Partition By
*/

--Select Firstname, Lastname, Gender, Salary,
--count(Gender) over (Partition By Gender) As TotalGender
--From SQLTutorial.dbo.EmployeeDemographics as Demo
--join SQLTutorial.dbo.EmployeeSalary as sal
--on demo.EmployeeID = sal.EmployeeID

--Select  Gender,count(Gender)
--From SQLTutorial.dbo.EmployeeDemographics as Demo
--join SQLTutorial.dbo.EmployeeSalary as sal
--on demo.EmployeeID = sal.EmployeeID
--Group By Gender

/* CTEs- Common Table Expressions
*/

--With CTE_Employee As
--(Select Firstname, Lastname, Gender, Salary,
--count(Gender) over (Partition By Gender) As TotalGender,
--AVG(Salary) over (Partition By Gender) as AvgSalary
--from SQLTutorial..EmployeeDemographics demo
--join SQLTutorial..EmployeeSalary sal
--	on demo.EmployeeID = sal.EmployeeID
--)
--Select Firstname , Lastname
--from CTE_Employee

/* Temp tables
*/

--Create Table #Temp_Employee(

--EmployeeID int,
--JobTitle varchar(50),
--AvgSal int)

--Insert Into #Temp_Employee Values(
-- '1001', 'HR', 50000
-- )
-- Select * from #Temp_Employee

-- Insert Into #Temp_Employee
-- Select*
-- from SQLTutorial..EmployeeSalary

-- Drop Table IF EXISTS #Temp_Employee2
-- Create Table #Temp_Employee2(
-- JobTitle varchar(50),
-- EmployeesPerJob int,
-- AvgAge int,
-- AvgSalary int)

-- Insert into #Temp_Employee2
-- Select JobTitle, Count(JobTitle), Avg(Age), Avg(Salary)
-- from SQLTutorial..EmployeeDemographics emp
-- join SQLTutorial..EmployeeSalary sal
--	on emp.EmployeeID = sal.EmployeeID
--group by jobTitle

--Select *
--From #Temp_Employee2

/* String functions - TRIM, LTRIM, RTRIM, Replace, Substring, Upper, Lower
*/
Drop Table if Exists EmployeeErrors
Create Table EmployeeErrors (
EmployeeID varchar(50),
Firstname varchar(50),
Lastname varchar(50)
)
Insert into EmployeeErrors Values
('1001 ' , 'Jimbo' , 'Halbert'),
(' 1002' , 'Pamela' , 'Beasely'),
('1003', 'TOny' , 'Flendson -Fired')
Select * From EmployeeErrors

--using Trim, LTRIM, RTRIM

Select EmployeeID, Trim(EmployeeID) as IDTRIM
from EmployeeErrors
Select EmployeeID, LTrim(EmployeeID) as IDTRIM
from EmployeeErrors
Select Firstname, RTrim(Firstname) as IDTRIM
from EmployeeErrors

--Using Replace
Select Lastname, Replace(Lastname, '-Fired', ' ') as LastNameFixed
From EmployeeErrors

--Using Substring
Select err.Firstname, substring(err.Firstname,1,3) , dem.Firstname, substring(dem.Firstname,1,3)
from EmployeeErrors err
join SQLTutorial..EmployeeDemographics dem
	on substring(err.Firstname,1,3) = substring(dem.Firstname,1,3)

--Using Upper and Lower

Select Firstname , Lower(Firstname)
From EmployeeErrors

Select Firstname , Upper(Firstname)
From EmployeeErrors


/* Stored Procedures
*/

Create Procedure TEST
AS
Select *
From EmployeeDemographics

EXEC TEST

Create Procedure Temp_Employee
As
Create Table Employee(
Jobtitle varchar(100),
EmployeesPerJob int,
AvgAge int,
AvgSalary int,
)

Insert into Employee
Select Jobtitle, Count(Jobtitle), Avg(Age), Avg(Salary)
from SQLTutorial..EmployeeDemographics emp
join SQLTutorial..EmployeeSalary sal
	on emp.EmployeeID = sal.EmployeeID
group by Jobtitle

Select *
from Employee

Exec Temp_Employee

/* Subqueries (In the Select, From, and Where Statements)
*/

Select *
From EmployeeSalary

-- Subquery in Select

Select EmployeeID, Salary, (Select Avg(Salary) from EmployeeSalary) As TotalAvgSal
From EmployeeSalary

-- How to do it with partition by

Select EmployeeID, Salary, Avg(Salary) over() As TotalAvgSal
From EmployeeSalary

-- Why Group by doest not work

Select EmployeeID, Salary, Avg(Salary) As TotalAvgSal
From EmployeeSalary
Group By EmployeeID, Salary
order by 1,2

-- Subquery in from

Select a.EmployeeID, TotalAvgSal
From (Select EmployeeID, Salary, Avg(Salary) over() As TotalAvgSal
	  From EmployeeSalary) a

--Subquery in where

Select EmployeeID, Jobtitle, Salary
From EmployeeSalary
Where EmployeeID in(
		Select EmployeeID
		From EmployeeDemographics
		Where age>30)


 Select *
 from PortfolioProject..CovidDeaths
 where continent is not null
 order by 3,4

 --Select *
 --from PortfolioProject..CovidVaccinations
 --order by 3,4

 Select Location, date, total_cases, new_cases, total_deaths, population
 from PortfolioProject..CovidDeaths
 order by 1,2

 --Looking at Total cases vs Total Deaths

 Select Location, date, total_cases,total_deaths,(Convert(float,total_deaths)/ Convert(float,total_cases))*100 as DeathPercentage
 from PortfolioProject..CovidDeaths
 where location like '%States%'
 order by 1,2

 --Looking at total cases vs Population
 -- Shows what percentage of population got covid

 Select Location, date, Population, total_cases,(total_cases/population)*100 as DeathPercentage
 from PortfolioProject..CovidDeaths
 where location like '%States%'
 order by 1,2

 --Looking at countries with highest infection rate compared to population

 Select Location, Population, Max(total_cases) as HighestInfectionCount, Max((total_cases/population))*100 as 
 PercentPopulationInfected
 from PortfolioProject..CovidDeaths
 Group by Location, Population
 order by PercentPopulationInfected desc

 --Showing countries with the highest death count per population

 Select Location, Max(cast(Total_Deaths as int)) as TotalDeathCount
 from PortfolioProject..CovidDeaths
 where continent is not null
 Group by Location
 order by TotalDeathCount desc

 --let's break things down by continent

 Select continent, Max(cast(Total_Deaths as int)) as TotalDeathCount
 from PortfolioProject..CovidDeaths
 where continent is not null
 Group by continent
 order by TotalDeathCount desc

 Select location, Max(cast(Total_Deaths as int)) as TotalDeathCount
 from PortfolioProject..CovidDeaths
 where continent is not null
 Group by location
 order by TotalDeathCount desc

 --Showing the continents with the highest death count per population

 Select continent, Max(cast(Total_Deaths as int)) as TotalDeathCount
 from PortfolioProject..CovidDeaths
 where continent is not null
 Group by continent
 order by TotalDeathCount desc

 --Global Numbers

 Select sum(new_cases) as total_cases, sum(cast(new_deaths as int)) as total_deaths,
 sum(cast(new_deaths as int))/sum(new_cases)*100 as DeathPercentage
 from PortfolioProject..CovidDeaths
 --where location like '%States%'
 where continent is not null
 --Group  by date
 order by 1,2

 --CovidVaccinations

 Select *
 from PortfolioProject..CovidVaccinations

 Select *
 from PortfolioProject..CovidDeaths Dea
 join PortfolioProject..CovidVaccinations vac
	 on dea.location = vac.location
	 and dea.date = vac.date

--Looking at total population vs Vaccinations

--Use CTE

With PopvsVac (Continent, location, date, population, new_vaccinations, RollingPeopleVaccinated)
as
(
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, sum(Convert(float, vac.new_vaccinations)) over (Partition by dea.location order by dea.location, 
dea.date) as RollingPeopleVaccinated
from PortfolioProject..CovidDeaths dea
join PortfolioProject..CovidVaccinations vac
	on dea.location = vac.location
	 and dea.date = vac.date 
where dea.continent is not null
--order by 2,3
)

Select*, (RollingPeopleVaccinated/population)*100
from PopvsVac

--Temp Table
Drop Table if exists #PercentPopulationVaccinated
Create Table #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
date datetime,
Population numeric,
New_Vaccinations numeric,
RollingPeopleVaccinated numeric

)

Insert into #PercentPopulationVaccinated
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, sum(Convert(float, vac.new_vaccinations)) over (Partition by dea.location order by dea.location, 
dea.date) as RollingPeopleVaccinated
from PortfolioProject..CovidDeaths dea
join PortfolioProject..CovidVaccinations vac
	on dea.location = vac.location
	 and dea.date = vac.date 
where dea.continent is not null
--order by 2,3

Select *, (RollingPeopleVaccinated/Population)*100
from #PercentPopulationVaccinated


--Creating view to store data for later visualizations
Drop view if exists PercentPopulationVaccinated
Create View PercentPopulationVaccinated
(
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, sum(Convert(float, vac.new_vaccinations)) over (Partition by dea.location order by dea.location, 
dea.date) as RollingPeopleVaccinated
from PortfolioProject..CovidDeaths dea
join PortfolioProject..CovidVaccinations vac
	on dea.location = vac.location
	 and dea.date = vac.date 
where dea.continent is not null
--order by 2,3
)
Select *
from PercentPopulationVaccinated



