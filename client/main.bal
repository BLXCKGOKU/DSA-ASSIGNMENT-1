import ballerina/io;
import ballerina/http;

type Lecturer  record {
    string staffNumber;
    string officeNumber;
    string staffName;
    string title;
    string[] coursesTeaching;
};

type Course record {
    string name?;
    string code?;
    string[] lecturers?;
};

public function main() returns error? {
    // io:println("Hello, World!");
    http:Client courseClient = check new ("localhost:4000/course");

    io:println("1. Create Course");
    io:println("2. Update Course");
    io:println("3. Delete Course");
    io:println("4. View All Courses");
    io:println("5. View Course By Code");
    io:println("6. View Course By Name");
    io:println("7. Create Lecturer");
    io:println("8. Update Lecturer");
    io:println("9. Delete Lecturer");
    io:println("10. View All Lecturer");
    io:println("11. View Lecturer By Code");
    io:println("12. View Lecturer By Name");
    string option = io:readln("Choose an option: ");

    match option {
        "1" => {
            Course course = {};
            course.name = io:readln("Enter Course Name: ");
            course.code = io:readln("Enter Course Code: ");
            string lectName = addLecturers();
            course.lecturers = [lectName];
            check create(courseClient, course);
        }
        "2" => {
            Course course = {};
            course.name = io:readln("Enter Course Name: ");
            course.code = io:readln("Enter Course Code: ");
            check update(courseClient, course);
        }
        "3" => {
            string course_name = io:readln("Enter Course Name: ");
            check delete(courseClient, course_name);
        }
        "4" => {
            check getAll(courseClient);
        }
        "5" => {
            string course_id = io:readln("Enter  Id: ");
            check getByCode(courseClient, course_id);
        }
        "6" => {
            string course_id = io:readln("Enter Lecturer Name");
            check getByName(courseClient, course_id);
        }
        "7" => {
            Course course = {};
            course.name = io:readln("Enter Lecturer Name: ");
            course.code = io:readln("Enter Lecturer Code: ");
            string lectName = addLecturers();
            course.lecturers = [lectName];
            check create(courseClient, course);
        }
        "8" => {
            Course course = {};
            course.name = io:readln("Enter Lecturer Name: ");
            course.code = io:readln("Enter Lecturer Code: ");
            check update(courseClient, course);
        }
        "9" => {
            string course_name = io:readln("Enter Lecturer Name: ");
            check delete(courseClient, course_name);
        }
        "10" => {
            check getAll(courseClient);
        }
        "11" => {
            string course_id = io:readln("Enter Lecturer Id: ");
            check getByCode(courseClient, course_id);
        }
        "12" => {
            string course_id = io:readln("Enter Lecturer Name");
            check getByName(courseClient, course_id);
        }
        _ => {
            io:println("Invalid Key");
            check main();
        }


    }
}

function addLecturers() returns string {
    string name = io:readln("Enter Lecturer Name: ");
    return name;
}

// Function to create a course

public function create(http:Client http, Course course) returns error? {
    if (http is http:Client) {
        string message = check http->/createCourse.post(course);
        io:println(message);
        string exit = io:readln("Press 0 to go back");

        if (exit === "0") {
            error? mainResult = main();
            if mainResult is error {
                io:println("Error, You can't go back.");
            }
        }
    }
}

public function update(http:Client http, Course new_course) returns error? {
    // var create = check http.post("/createCourse", course);
    io:println(new_course);
}

public function delete(http:Client http, string|string[] name) returns error? {
    if (http is http:Client) {
        string message = check http->/deleteCourseByName.get({name});
        io:println(message);
        io:println("--------------------------");
        string exit = io:readln("Press 0 to go back");
        if (exit == "0") {
            error? mainResult = main();
            if mainResult is error {
                io:println("Error, You can't go back.");
            }
        }
    }
}

public function getAll(http:Client http) returns error? {
    if (http is http:Client) {
        Course[] courses = check http->/getAllCourses;
        foreach Course item in courses {
            io:println("--------------------------");
            io:println("Course Code: ", item.code);
            io:println("Course Name: ", item.name);
            io:println("Lectures: ", item.lecturers);
        }

        io:println("--------------------------");
        string exit = io:readln("Press 0 to go back");

        if (exit == "0") {
            error? mainResult = main();
            if mainResult is error {
                io:println("Error, You can't go back.");
            }
        }
    }
}

public function getByCode(http:Client http, string code) returns error? {
    if (http is http:Client) {
        Course course = check http->/getCourseByCode(code = code);
        io:println("--------------------------");
        io:println("Course Code: ", course.code);
        io:println("Course Name: ", course.name);
        io:println("Lectures: ", course.lecturers);
        io:println("--------------------------");
        string exit = io:readln("Press 0 to go back");

        if (exit == "0") {
            error? mainResult = main();
            if mainResult is error {
                io:println("Error, You can't go back.");
            }
        }
    }
}

public function getByName(http:Client http, string name) returns error? {
    if (http is http:Client) {
        Course course = check http->/getCourseByName/[name];
        io:println("--------------------------");
        io:println("Course Code: ", course.code);
        io:println("Course Name: ", course.name);
        io:println("Lectures: ", course.lecturers);
        io:println("--------------------------");
        string exit = io:readln("Press 0 to go back");

        if (exit == "0") {
            error? mainResult = main();
            if mainResult is error {
                io:println("Error, You can't go back.");
            }
        }
    }
}
