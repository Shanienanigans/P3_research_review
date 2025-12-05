# Project 2: Microblogging

This project develops a Microblogging platform web application with a MySQL database backend. The instructor has implemented the frontend and backend foundation of this project. We have been tasked to complete the database and the interactions of the application with the database using Java.


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
|  Posts  | Making posts as the logged-in user |  Chayenne        |
|  Hashtags  | Posts can have hashtags. Later posts are searchable by hashtags.|  Dominic        |
|  Posts  | The logged in user should be able to like posts. |   Chayenne       |
|  Posts  | The comments should be ordered from oldest to latest in the comment list when a post is clicked. |   Chayenne       |
|  Posts  | The logged in user should be able to comment on posts after clicking the comments icon of a post.|   Chayenne       |
|  Posts  | The number of comments and likes should be displayed in the post.|   Chayenne       |
|  Posts  | The date that the post created should be displayed in the following format: Mar 07, 2025, 10:54 PM |   Chayenne       |
|  Homepage  | Home page should have posts from users that the logged in user follows.|  Jiangnan        |
|  Homepage  | The posts should be ordered from most recent to oldest. |  Jiangnan        |
|  Profile | Profile page should allow seeing posts from a specific user |  Jiangnan        |
|  Profile  | Clicking the profile item in the top bar should take the user to a page that shows the logged in users posts ordered from most recent to the oldest.|  Jiangnan        |
|  Profile  | Clicking on the user name of any user appearing on the web pages takes you to the profile page of the specific user. |  Jiangnan        |
|  People  | People page should list all users in the platform |  Jichao |
|  People  | Clicking the follow icon of a user should make the logged in user follow the user in concern. |  Jichao |
|  People  | Each user item should have their last post time in the following format: Mar 07, 2025, 10:54 PM |  Jichao |
|  People  |The users list should not contain the logged in user. | Jichao|
|  Bookmarks  | Bookmarks page should show posts that the logged in user has bookmarked. Show the most recent posts first. | Jichao |
|  Bookmarks  | The logged in user should be able to bookmark posts. | Jichao |
|  Hashtags | Hashtag search field should allow searching posts based on hashtags  |  Dominic |
|  Hashtags  |  The user should be able to type in one or more hashtags into the search field ie: #2025 #fireworks. The results should show posts that have all hashtags. Show the most recent posts first. |  Dominic |
|  New Feature: Trending  | Implement a new non-trivial feature on your own  |  Dominic |
|  New Feature: Trending  | The feature you implement should have a new UI part, a controller part, a new service part, and a new database operation.  |  Dominic |
|  New Feature: Trending  | The new feature should be at least as complex as the hash tag based search feature.  |  Dominic |

## Sources

##### List of all sources utilized by Group 3 for the completion of this project:  

####
- [Timezone Conversion](https://dev.mysql.com/doc/refman/8.4/en/date-and-time-functions.html#function_convert-tz)  
- [Oracle - Statment](https://docs.oracle.com/javase/7/docs/api/java/sql/Statement.html)
- [SQL Time/Date Format](https://docs.oracle.com/en/database/oracle/oracle-database/19/sqlrf/Format-Models.html#GUID-22F2B830-261E-4BF0-91FB-6A1DAFC6D0A3)
- [Java Spring Boot](https://docs.spring.io/spring-boot/docs/current/reference/htmlsingle/)


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

4. Create the database and user table using the given **database_setup.sql** file

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


## New Feature: Trending Hashtags
#### Description
The new feature implemented is Trending Hashtags, which displays the top 5 most-used hashtags from the most recent 20 posts.
It dynamically updates based on user activity and provides clickable links that take users directly to the hashtag search results page, showing all posts containing that hashtag.
This feature adds a new UI page, controller, service method, and SQL aggregation logic, making it comparable in complexity to the hashtag search feature.

#### How to Access it:

1. Run the web app and log in.
2. On the top navigation bar, click on “Trending”.
3. You will see a list of trending hashtags with their usage counts, displayed in styled boxes.
4. Click any hashtag (e.g. #student) to view all posts containing that hashtag.

#### Where to find code:

| **Functionality**          | **Location / File**                                                                                  | **Description**                                                                                                                                    |
| -------------------------- | ---------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------- |
| **UI**                     | `src/main/resources/templates/trending.mustache`                                                     | Defines the frontend layout for the Trending Hashtags page. Uses card-like boxes and clickable hashtag links.                                      |
| **Controller**             | `src/main/java/uga/menik/csx370/controllers/TrendingController.java`                                 | Handles the `/trending` route, retrieves data from `PostService`, and loads the trending.mustache template.                                        |
| **Service**                | `src/main/java/uga/menik/csx370/services/PostService.java`                                           | Contains the `getTrendingHashtags(int topCount, int recentPostCount)` method. Performs SQL aggregation (`COUNT`, `GROUP BY`, `ORDER BY`, `LIMIT`). |
| **SQL / Schema Additions** | No schema changes required. Uses existing `post`, `hashtag`, and `post_hashtag` tables for analysis. | Performs aggregation across existing tables to count and rank hashtags.                                                                            |



