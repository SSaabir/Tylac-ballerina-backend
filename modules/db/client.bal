package hp.tylac_ballerina_backend.db;
import ballerinax/mysql;

public mysql:Client dbClient = check new mysql:Client({
    host: "localhost",
    port: 3306,
    user: "root",
    password: "password",
    database: "tylac_db",
    connectionPool: { maxOpenConnections: 5 }
});
