import db;
import models;
import ballerina/uuid;
import ballerina/time;
import ballerina/lang.'string as string;
import ballerina/lang.'error as error;

isolated function createUser(User user) returns User|error {

    user.id = uuid:create();
    user.createdAt = time:utcNow();
    user.updatedAt = user.createdAt;

    check dbClient->execute(`
        INSERT INTO User (id, name, email, phone, password, roleId, isActive, createdAt, updatedAt)
        VALUES (${user.id}, ${user.name}, ${user.email}, ${user.phone}, ${user.password},
                ${user.roleId}, ${user.isActive}, ${user.createdAt}, ${user.updatedAt})
    `);

    return user;
}
