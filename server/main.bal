import ballerina/io;
import ballerina/http;


type Course readonly & record {
    string name;
    string code;
    string staffNumber;
    string officeNumber;
    string staffName;
    string title;
    string[] coursesTeaching;
    
};
type Lecturer readonly & record {
    string staffNumber;
    string officeNumber;
    string staffName;
    string title;
    string[] coursesTeaching;
};
type name string;
type staffName string;

table<Course> key(name) courses = table [];
table<Lecturer> key(staffName) lecturer = table [];

// http:localhost:400/course
service /course on new http:Listener(4000) {
    // Array to store all courses
    // private Course[] courses = [];
    // http:localhost:400/course/createCourse
    resource function post createCourse(Course course) returns string {
        io:println(course);
        error? err = courses.add(course);
        if (err is error) {
            return string `Error, ${err.message()}`;
        }
        return string `${course.name} saved successfully`;
    }

    resource function put updateCourse(Course course) returns string {
        io:println(course);
        error? err = courses.put(course);
        if (err is error) {
            return string `Error, ${err.message()}`;
        }
        return string `${course.name} saved successfully`;
    }
    resource function get getAllCourses() returns table<Course> key(name) {
        return courses;
    }

    // get using query parameters
    resource function get getCourseByCode(string code) returns Course|string {
        foreach Course course in courses {
            if (course.code === code) {
                return course;
            }
        }

        return code + " is invalid";
    }

    // get using path parameters
    resource function get getCourseByName/[string name]() returns Course|string {
        foreach Course course in courses {
            if (course.name === name) {
                return course;
            }
        }

        return name + " doesn't exist";
    }

    resource function delete deleteCourseByName/[string name]() returns string {
        courses = <table<Course> key(name)>courses.filter((course) => course.name != name);
        // courses = courses.filter(function(Course course) returns boolean {
        //     if (course.name != name) {
        //         return true;
        //     }
        //     return false;
        // }
        // );

        // Or use this code

        table<Course> courses1 = table [];
        // same as up
        // foreach Course course in courses {
        //     if (course.name !== name) {
        //         courses1.add(course);
        //     }
        // }
        // courses = <table<Course> key(name)>courses1;

        if (courses.length() === courses1.length()) {
            return name + " not found.";
        }
        return name + " successfuly deleted";
    }

    resource function post createLecturer(Lecturer lecturer) returns string {
        io:println(lecturer);
        // error? err = lecturer.add(lecturer.staffName, lecturer);
        // if (err is error) {
            // return string `Error, ${err.message()}`;
        // }
        return string `${lecturer.staffName} saved successfully`;
    }


    resource function put updateLecturer(Lecturer lecturer ) returns string {
        io:println(lecturer );
        // error? err = lecturer.put(lecturer );
        // if (err is error) {
            // return string `Error, ${err.message()}`;
        // }
        return string `${lecturer.staffName} saved successfully`;
    }
    resource function get getAllLecturer() returns table<Lecturer> key(staffName) {
        return lecturer;
    }

    // get using query parameters
    resource function get getLecturerByCode(string code) returns Lecturer|string {
        foreach Lecturer _  in lecturer  {
        //  if (lecturer.code === code) {
                // return lecturer ;
            // }
        }

        return code + " is invalid";
    }

    // get using path parameters
    resource function get getLecturerByName/[string staffName]() returns Lecturer|string {
        foreach Lecturer lecturer  in lecturer  {
            if (lecturer.staffName === staffName) {
                return lecturer ;
            }
        }

        return staffName + " doesn't exist";
    }

    resource function delete deleteLecturerByName/[string staffName]() returns string {
        lecturer  = <table<Lecturer> key(staffName)>lecturer.filter((lecturer) => lecturer.staffName != staffName);
        // courses = courses.filter(function(Course course) returns boolean {
        //     if (course.name != name) {
        //         return true;
        //     }
        //     return false;
        // }
        // );

        // Or use this code

        table<Lecturer> lecturer1 = table [];
        // same as up
        // foreach Course course in courses {
        //     if (course.name !== name) {
        //         courses1.add(course);
        //     }
        // }
        // courses = <table<Course> key(name)>courses1;

        if (lecturer.length() === lecturer1.length()) {
            return staffName + " not found.";
        }
        return staffName + " successfuly deleted";
    }    

}
