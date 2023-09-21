# Building an Azure Data Warehouse for Bike Share Data Analytics

This is one of the projects I completed as a part of Udacity specialization called Data Engineering with Microsoft Azure.

## Project Overview
Divvy is a bike sharing program in Chicago, Illinois USA that allows riders to purchase a pass at a kiosk or use a mobile application to unlock a bike at stations around the city and use the bike for a specified amount of time. The bikes can be returned to the same station or to another station. The City of Chicago makes the anonymized bike trip data publicly available for projects like this where we can analyze the data.

Since the data from Divvy are anonymous, we have created fake rider and account profiles along with fake payment data to go along with the data from Divvy. The dataset looks like this:

![Getting Started](data-model.png)

### The goal of this project is to develop a data warehouse solution using Azure Synapse Analytics. 

You will:

- Design a star schema based on the business outcomes listed below;
- Import the data into Synapse;
- Transform the data into the star schema;
- and finally, view the reports from Analytics.

# TASKS NEED TO DO FOR THIS PROJECT

## Task 1: Create your Azure resources

- Create an Azure Database for PostgreSQL.
- Create an Azure Synapse workspace. Note that if you've previously created a Synapse Workspace, you do not need to create a second one specifically for the project.
- Use the built-in serverless SQL pool and database within the Synapse workspace
- In the cloud lab Azure environment, you will only be able to use the built-in serverless SQL Pool.

![Alt text](https://file%2B.vscode-resource.vscode-cdn.net/Users/nevenkalukic/Azure_kurs/Project_Bike_Share/Screenshots/Task_1_Create_your_Azure_resources.png?version%3D1695291670829)

## Task 2: Design a star schema

You are being provided a relational schema that describes the data as it exists in PostgreSQL. In addition, you have been given a set of business requirements related to the data warehouse. You are being asked to design a star schema using fact and dimension tables.


## Task 3: Create the data in PostgreSQL

To prepare your environment for this project, you first must create the data in PostgreSQL. This will simulate the production environment where the data is being used in the OLTP system. This can be done using the Python script provided for you in Github: ProjectDataToPostgres.py

- Download the script file and place it in a folder where you can run a Python script
- Download the data files from the classroom resources
- Open the script file in VS Code and add the host, username, and password information for your PostgreSQL database
- Run the script and verify that all four data files are copied/uploaded into PostgreSQL
- You can verify this data exists by using pgAdmin or a similar PostgreSQL data tool.

![Alt text](https://file%2B.vscode-resource.vscode-cdn.net/Users/nevenkalukic/Azure_kurs/Project_Bike_Share/Screenshots/Task_3_Create%20_the_data_in_PostgreSQL.png?version%3D1695291607966)

## Task 4: EXTRACT the data from PostgreSQL

In your Azure Synapse workspace, you will use the ingest wizard to create a one-time pipeline that ingests the data from PostgreSQL into Azure Blob Storage. This will result in all four tables being represented as text files in Blob Storage, ready for loading into the data warehouse.

![Alt text](https://file%2B.vscode-resource.vscode-cdn.net/Users/nevenkalukic/Azure_kurs/Project_Bike_Share/Screenshots/Task_4_EXTRACT_the_data_from_PostgreSQL.png?version%3D1695291561066)

## Task 5: LOAD the data into external tables in the data warehouse

Once in Blob storage, the files will be shown in the data lake node in the Synapse Workspace. From here, you can use the script-generating function to load the data from blob storage into external staging tables in the data warehouse you created using the serverless SQL Pool.

![Alt text](https://file%2B.vscode-resource.vscode-cdn.net/Users/nevenkalukic/Azure_kurs/Project_Bike_Share/Screenshots/Task_5_LOAD_the_data_into_external_tables_in_the_data_warehouse.png?version%3D1695291458580)

## Task 6: TRANSFORM the data to the star schema using CETAS

Write SQL scripts to transform the data from the staging tables to the final star schema you designed.

The serverless SQL pool won't allow you to create persistent tables in the database, as it has no local storage. So, use CREATE EXTERNAL TABLE AS SELECT (CETAS) instead. CETAS is a parallel operation that creates external table metadata and exports the SELECT query results to a set of files in your storage account.

- Look att the Load.txt files


![Alt text](https://file%2B.vscode-resource.vscode-cdn.net/Users/nevenkalukic/Azure_kurs/Project_Bike_Share/Screenshots/Task_6_TRANSFORM_the_data_to_the_star_schema_using_CETAS.png?version%3D1695291267226)