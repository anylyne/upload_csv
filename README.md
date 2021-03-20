# README

Code Assesment Feb/2021

# PART 1
As a user, I should be able to upload this sample CSV and import the data into a database.
IMPORTER REQUIREMENTS:
1. The data needs to load into 3 tables. ​People,​ ​Locations ​and ​Affiliations
2. A ​Person ​can belong to many ​Locations
3. A ​Person ​can belong to many ​Affiliations
4. A ​Person​ without an ​Affiliation ​should be skipped
5. A ​Person ​should have both a ​first_name​ and ​last_name​. All fields need to be validated except for ​last_name​, ​weapon​ and ​vehicle​ which are optional.
6. Names and Locations should all be titlecased

# PART 2
1. As a user, I should be able to view these results from the importer in a table.
2. As a user, I should be able to paginate through the results so that I can see a maximum
of 10 results at a time.
3. As a user, I want to type in a search box so that I can filter the results I want to see.
4. As a user, I want to be able to click on a table column heading to reorder the visible
results.

# TODO
* Fix pagination and sortable links combining with the Filter term.
