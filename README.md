# Project 3: Open Source Review Platform

This project develops a web-based Open Review Platform where users can upload research papers, read them, review them with structured criteria, and participate in discussions.


## Group 3

- Chayenne-Chiara Samson [@Shanienanigans](https://github.com/Shanienanigans)
- Dominic Okonkwo [@Dominicmils](https://github.com/Dominicmils)
- Jiangnan Xia [@jiangnanx129](https://github.com/jiangnanx129)
- Jichao Yu [@ciaociaoyu](https://github.com/ciaociaoyu)


## Contributions

##### Each group member was tasked with a specific section of the Web Application, as detailed below: 

####

| Web Application | Functionality |Responsibility| 
| :-------- | :------- | :------- |
| Roles | Implemented Roles (researcher, reviewer) for various site views | Jiangnan|
| Homepage | Implemented homepage views based on implemented Roles | Jiangnan|
| All Papers | Implemented ability to show all papers within the platform | Dominic | 
| Upload Paper | Implemented the ability to upload (researchers only) and download papers| Dominic|
| Edit Upload | Implemented the ability to edit uploaded papers| Jiangnan|
| Profile | Implemented the ability to view profiles; Showing links to reviews, discussions, and downloading the paper| Dominic|
| Discussion | Implemented abiility to create and reply to discussions | Chayenne |
| Authors | Implemented Authors page to view and search authors | Jichao |
| Follow | Implemented ability to follow users so followed users apear first within homepage | Jichao|
| Reviews | Implemented ability to write reviews (reviewers only) | Dominic |


## How-To Run Code

####
1. Start your docker container.

2. Use the following command to open a shell to the started container:

```bash
docker exec -it mysql-server-4370 bash
```

3. Login to mysql:

```bash
mysql -u root -p
```

4. Create the database  using the given **ddl.sql** file

5. Populate the database with the sample data using the given **data.sql** file

5. Exit the database and the shell. Return to your local machine's terminal.

6. Navigate to the directory with the pom.xml using the terminal in your local machine and run the following command:

- On unix like machines:
```bash
mvn spring-boot:run -Dspring-boot.run.jvmArguments='-Dserver.port=8081'
```
- On windows command line:
```bash
mvn spring-boot:run -D"spring-boot.run.arguments=--server.port=8081"
```
- On windows power shell:
```bash
mvn spring-boot:run --% -Dspring-boot.run.arguments="--server.port=8081"
```

7. Open the browser and navigate to the following URL:
http://localhost:8081/


## Technologies
####
**Backend**
 - Java with Spring MVC for controllers and request handling.
 - Service classes (e.g., UserService, PaperService, ReviewService, CriterionService) for application logic.
 - Session-based authentication for login and role-specific behavior (e.g., researcher vs reviewer).

**Frontend**
 - Mustache templates (.mustache files) for server-side rendering of HTML views.
 - CSS for styling and layout of all pages.

**Database**
 - MySQL as the relational database.
 - Tables for users, papers, reviews, review criteria, review-criterion scores, comments, and author–paper relationships.
 - A JDBC-based data access layer (or Spring’s data access support) to query and update the database.

**API**
 - [Semantic Scholar API](https://www.semanticscholar.org/)

## JDBC connection
####
**Name:**

 //localhost:33306/open_review_platform

**Username:** 

root

**Password:**

 mysqlpass

## Test Users
####

1. 
    
    Username: alice

    Password: test

    Role: Author
2. 
    
    Username: bob
    
    Password: test

    Role: Reviewer
3. 
    
    Username: cara
    
    Password: test

    Role: Author


