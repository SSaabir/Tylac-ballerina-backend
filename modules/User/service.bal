isolated function createUser(User user) returns User|error {
    if !isValidEmail(user.email) {
        return error("Invalid email format");
    }
    if !isValidPhone(user.phone) {
        return error("Invalid phone number format");
    }

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
