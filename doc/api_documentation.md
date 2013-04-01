Coursewa.re API endpoint documentation
======================================

The following examples use `curl` command to get the response from the server.

* * *
Sign in
-------

Should write documentation.
* * *

Classrooms
----------

To request information about classrooms that user is attended use following link:
> curl http://api.coursewa.re/v1/classrooms

To request information about a specified classroom, you should put the id of classroom in the link:
> curl http://api.coursewa.re/v1/classrooms/:id

To request collaborators of a classroom, you should put the id of classroom:
> curl http://api.coursewa.re/v1/classrooms/:classroom_id/collaborators

To request all activities in a classroom that user is attended:
> curl http://api.coursewa.re/v1/classrooms/:classroom_id/timeline

Syllabus
--------

To request the syllabus of a classroom:
> curl http://api.coursewa.re/v1/syllabus?classroom_id=:classroom_id

Lectures
--------
To request all lectures which belongs to logged user:
> curl http://api.coursewa.re/v1/lectures

To request a specified lecture which belongs to logged user:
> curl http://api.coursewa.re/v1/lectures/:id

To request a specified lecture which belongs to classroom:
> curl http://api.coursewa.re/v1/lectures/:id?classroom_id=:classroom_id

Responses
---------

To request a response that belong to logged user:
> curl http://api.coursewa.re/v1/response?assignment_id=:assignment_id

Assignments
-----------

To request all assignments which belong to logged user:
> curl http://api.coursewa.re/v1/assignments

To request a specified assigment that belong to a logged user:
> curl http://api.coursewa.re/v1/assignments/:id

To request a specified assigment that belong to a classroom:
> curl http://api.coursewa.re/v1/assignments/:id?classroom_id=:classroom_id

Note: all symbols that represents parameters value should be changed.
