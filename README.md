Data Cleaning Process on the Layoff Dataset
1. Creating the Schema
First, I created a schema for the dataset to ensure that all the columns were clearly defined with appropriate data types. This schema served as a blueprint for the data import process and subsequent operations.

2. Creating the Table
Using the Table Data Import Wizard, I created a table based on the schema. This table provided the structure needed to import and store the raw data effectively.

3. Importing the Raw Data
I imported the raw data into the newly created table using the wizard. The data was then ready for cleaning and further processing.

Project Work
1. Removing Duplicates
To remove duplicate values, I first identified the unique column, company, which allowed me to distinguish the unique entries in the dataset. I then proceeded to remove all duplicate rows based on this column, ensuring that each company was represented only once in the dataset.

2. Standardizing the Data
I standardized the data by identifying and removing any extra spaces, periods, or other unnecessary characters in the columns. After cleaning these inconsistencies, I also standardized the date formats across the dataset to maintain uniformity.

3. Handling Null or Blank Values
I conducted a thorough search for null or blank values across all columns. Where feasible, I replaced these values with appropriate data. For instance, in the industry column, if the company name and location matched a known record, I performed a join operation to fill in the missing industry information.

4. Removing Unnecessary Rows/Columns
Finally, I removed any unnecessary rows or columns that were not relevant to the analysis. This step ensured that the dataset was as streamlined and efficient as possible for further use.
