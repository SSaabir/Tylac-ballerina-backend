import ballerina/sql;
import ballerinax/mysql;

public type DbClient mysql:Client;

// Create a MySQL client instance
public final DbClient dbClient = check new mysql:Client(
    "mysql://root:password@localhost:3306/tylac_ballerina_backend"
);

// Optional init function to verify DB connection
public function init() returns error? {
    sql:ParameterizedQuery query = `SELECT 1`;
    _ = check dbClient->execute(query);
    return;
}