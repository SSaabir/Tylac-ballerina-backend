import ballerina/http;

service / on new http:Listener(8090) {
    resource function get hello() returns string {
        return "Hello from Tylac Ballerina Backend!";
    }
}
