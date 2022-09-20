# Cleaning Nashville housing data
### viewing the dataset
	SELECT *
	FROM PortfolioProjects.dbo.Nashville;

### converting the datetime to a date format
	UPDATE Nashville
	SET SalesDateCoverted = CONVERT(Date,SaleDate)
	ALTER TABLE Nashville
	ADD SalesDateCoverted Date;

### fishing out where PropertyAddress is null to update it
	SELECT n1.ParcelID,n1.PropertyAddress,n2.ParcelID,n2.PropertyAddress, ISNULL(n1.PropertyAddress,n2.PropertyAddress)
	FROM PortfolioProjects.dbo.Nashville n1
	JOIN PortfolioProjects.dbo.Nashville n2
	ON n1.ParcelID = n2.ParcelID
	AND n1.UniqueID <> N2.UniqueID
	WHERE n1.PropertyAddress IS NULL


### updating rows that are null with data
	UPDATE n1
	SET PropertyAddress = ISNULL(n1.PropertyAddress,n2.PropertyAddress)
	FROM PortfolioProjects.dbo.Nashville n1
	JOIN PortfolioProjects.dbo.Nashville n2
	ON n1.ParcelID = n2.ParcelID
	AND n1.UniqueID <> N2.UniqueID
	WHERE n1.PropertyAddress IS NULL



### splitting the property address into city and address and updating the table using the substring function
	SELECT 
	SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1) as Address
	, SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1, LEN(PropertyAddress)) as Address
	FROM PortfolioProjects.dbo.Nashville

	UPDATE PortfolioProjects.dbo.Nashville
	SET PropertySplitAddress =  SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1) 
	ALTER TABLE PortfolioProjects.dbo.Nashville
	ADD PropertySplitAddress NVARCHAR(255);

	UPDATE PortfolioProjects.dbo.Nashville
	SET PropertyCityAddress =   SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1, LEN(PropertyAddress)) 
	ALTER TABLE PortfolioProjects.dbo.Nashville
	ADD PropertyCityAddress NVARCHAR(255);



### splitting the property address into city and address and updating the table using the Parsename & Replace function
	SELECT 
	PARSENAME(REPLACE(OwnerAddress, ',', '.'),3) as Housing,
	PARSENAME(REPLACE(OwnerAddress, ',', '.'),2) as City,
	PARSENAME(REPLACE(OwnerAddress, ',', '.'),1)  as Status
	FROM PortfolioProjects.dbo.Nashville;

### updating the table
	ALTER TABLE PortfolioProjects.dbo.Nashville
	ADD Housing NVARCHAR(255)
	UPDATE PortfolioProjects.dbo.Nashville
	SET Housing = PARSENAME(REPLACE(OwnerAddress, ',', '.'),3);

	ALTER TABLE PortfolioProjects.dbo.Nashville
	ADD City NVARCHAR(255)
	UPDATE PortfolioProjects.dbo.Nashville
	SET City = PARSENAME(REPLACE(OwnerAddress, ',', '.'),2);

	ALTER TABLE PortfolioProjects.dbo.Nashville
	ADD Status NVARCHAR(255)
	UPDATE PortfolioProjects.dbo.Nashville
	SET Status = PARSENAME(REPLACE(OwnerAddress, ',', '.'),1);

	SELECT *
	FROM PortfolioProjects.dbo.Nashville;

### replacing the 'n' and 'y' letters with 'yes' and 'no'
	SELECT DISTINCT(SoldAsVacant),COUNT(SoldAsVacant)
	FROM PortfolioProjects.dbo.Nashville
	GROUP BY SoldAsVacant
	ORDER BY 2;

	SELECT SoldAsVacant
	, CASE WHEN SoldAsVacant = 'N' THEN 'No'
	  WHEN SoldAsVacant ='Y' THEN 'Yes'
	  ELSE SoldAsVacant
	  END 
	FROM PortfolioProjects.dbo.Nashville

	UPDATE PortfolioProjects.dbo.Nashville
	SET SoldAsVacant = CASE WHEN SoldAsVacant = 'N' THEN 'No'
	  WHEN SoldAsVacant ='Y' THEN 'Yes'
	  ELSE SoldAsVacant
	  END 
	FROM PortfolioProjects.dbo.Nashville;



### removing duplicates from the table
	WITH ROWNUMCTE AS (
	SELECT *, ROW_NUMBER() OVER (
	PARTITION BY ParcelID,
		     PropertyAddress,
		     SalePrice,
		     SaleDate,
		     LegalReference
		     ORDER BY 
		     UniqueID 
		     ) row_num
	FROM PortfolioProjects.dbo.Nashville)
	SELECT * 
	FROM ROWNUMCTE
	WHERE row_num > 1
	ORDER BY
	PropertyAddress

