import ballerina/uuid;
import ballerina/time;
import tylac_ballerina_backend.models as models;
import tylac_ballerina_backend.db as db;
isolated function createUser(models:User user) returns models:User|error {

    user.id = uuid:createRandomUuid();
    user.createdAt = time:utcNow();
    user.updatedAt = user.createdAt;

    _= check db:dbClient->execute(`
        INSERT INTO User (id, name, email, phone, password, roleId, isActive, createdAt, updatedAt)
        VALUES (${user.id}, ${user.name}, ${user.email}, ${user.phone}, ${user.password},
                ${user.roleId}, ${user.isActive}, ${user.createdAt}, ${user.updatedAt})
    `);

    return user;
}
