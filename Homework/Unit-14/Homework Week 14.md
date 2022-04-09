### Homework Week 14

#### HTTP Requests and Responses

1. Client-Server Architecture
2. Request Line, Headers and Whitespace
3. Query Paramaters in the request line
4. Status Line, Headers, Response Body
5. 400 codes are client errors, 500 codes are server errors
6. Get and Post requests
7. Post
8. Get
9. Response Body


#### Using Curl

10. Allows the transfer of data to or from a server that  may not have  a GUI or Website to interact with, it can also be automated. 
11. `curl --request <request type> <URL>`
12. `curl -H 
13. `curl --head <website address>`
14. The Options Method

#### Sessions and Cookies

15. Set-Cookie cart=Bob
16. Cookie: cart=Bob

#### HTTP Request

17. Post
18. Upgrade-Insecure-Requests: 1
19. No
20. Login Information

#### HTTP Response

21. 200 Ok
22. Apache
23. Yes, SessionID=5
24. Text/HTML
25. Strict-Transport-Security: max-age=31536000; includeSubDomains

#### Monoliths and Microservices

26. Service
27. API
28. Load-Balancer

#### Deploying and Testing a Container Set

29. Docker-Compose
30. Docker-Copose.yml

#### Databases

31. SELECT * FROM employees;
32. INSERT INTO <database selection> (format of data) VALUES (data to add)  
33. That command says delete the whole table, not a specific entry of the table.  

#### Bonus: "The Cookie Jar"

- Question: Did you see any obvious confirmation of a login?
    - yes
- Question: How many items exist in this file?
    - 3
- Question: Is it obvious that we can access the Dashboard?
    - Yes, the HTML returned from the page looks to be the dashboard for the site
    - `curl --cookie-jar ./ryancookies.txt --form "log=Ryan" --form "pwd=123456" http://localhost:8080/wp-login.php --verbose`
- Question: Does any of the wording seem familiar? 
    - Yes, after using grep it removes a lot of the HTML and you see text that is displayed on the site itself
        - Such as: "Welcome to your WordPress Dashboard!"
        - `curl --cookie ./ryancookies.txt http://localhost:8080/wp-admin/index.php |grep Dashboard`
- Question: What Happens this time?
    - I get an error because Ryan doesn't have permission to browse the user page. 
    - `curl --cookie ./ryancookies.txt http://localhost:8080/wp-admin/users.php`
