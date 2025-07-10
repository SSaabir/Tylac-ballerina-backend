
import ballerina/log;

public function migrate() returns error? {
    // Role
    _ = check dbClient->execute(`CREATE TABLE IF NOT EXISTS Role (
        id CHAR(36) PRIMARY KEY,
        roleType VARCHAR(50),
        description TEXT
    )`);

    // User
    _ = check dbClient->execute(`CREATE TABLE IF NOT EXISTS User (
        id CHAR(36) PRIMARY KEY,
        name VARCHAR(100),
        email VARCHAR(100) UNIQUE,
        phone VARCHAR(20),
        password TEXT,
        roleId CHAR(36),
        isActive BOOLEAN DEFAULT TRUE,
        createdAt DATETIME,
        updatedAt DATETIME,
        FOREIGN KEY (roleId) REFERENCES Role(id)
    )`);

    // Address
    _=check dbClient->execute(`CREATE TABLE IF NOT EXISTS Address (
        id CHAR(36) PRIMARY KEY,
        country VARCHAR(100),
        state VARCHAR(100),
        city VARCHAR(100),
        addressLine1 TEXT,
        addressLine2 TEXT,
        zipCode VARCHAR(20),
        isDefault BOOLEAN DEFAULT FALSE,
        userId CHAR(36),
        dealerId CHAR(36),
        createdAt DATETIME,
        updatedAt DATETIME,
        FOREIGN KEY (userId) REFERENCES User(id),
        FOREIGN KEY (dealerId) REFERENCES Dealer(id)
    )`);

    // Category
    _=check dbClient->execute(`CREATE TABLE IF NOT EXISTS Category (
        id CHAR(36) PRIMARY KEY,
        name VARCHAR(100),
        description TEXT,
        isActive BOOLEAN DEFAULT TRUE,
        createdAt DATETIME,
        updatedAt DATETIME
    )`);

    // Product
    _=check dbClient->execute(`CREATE TABLE IF NOT EXISTS Product (
        id CHAR(36) PRIMARY KEY,
        name VARCHAR(100),
        description TEXT,
        categoryId CHAR(36),
        basePrice DECIMAL(10,2),
        finalPrice DECIMAL(10,2),
        imageUrl TEXT,
        createdBy CHAR(36),
        isActive BOOLEAN DEFAULT TRUE,
        createdAt DATETIME,
        updatedAt DATETIME,
        FOREIGN KEY (categoryId) REFERENCES Category(id),
        FOREIGN KEY (createdBy) REFERENCES User(id)
    )`);

    // Color
    _=check dbClient->execute(`CREATE TABLE IF NOT EXISTS Color (
        id CHAR(36) PRIMARY KEY,
        name VARCHAR(50),
        hexCode VARCHAR(10),
        productId CHAR(36),
        isActive BOOLEAN DEFAULT TRUE,
        createdAt DATETIME,
        updatedAt DATETIME,
        FOREIGN KEY (productId) REFERENCES Product(id)
    )`);

    // Offer
    _=check dbClient->execute(`CREATE TABLE IF NOT EXISTS Offer (
        id CHAR(36) PRIMARY KEY,
        name VARCHAR(100),
        description TEXT,
        code VARCHAR(50),
        productId CHAR(36),
        discountPercentage DECIMAL(5,2),
        startDate DATETIME,
        endDate DATETIME,
        isActive BOOLEAN DEFAULT TRUE,
        createdAt DATETIME,
        updatedAt DATETIME,
        FOREIGN KEY (productId) REFERENCES Product(id)
    )`);

    // Dealer
    _=check dbClient->execute(`CREATE TABLE IF NOT EXISTS Dealer (
        id CHAR(36) PRIMARY KEY,
        name VARCHAR(100),
        email VARCHAR(100),
        phone VARCHAR(20),
        contactPerson VARCHAR(100),
        isActive BOOLEAN DEFAULT TRUE,
        createdAt DATETIME,
        updatedAt DATETIME
    )`);

    // DealerContract
    _=check dbClient->execute(`CREATE TABLE IF NOT EXISTS DealerContract (
        id CHAR(36) PRIMARY KEY,
        dealerId CHAR(36),
        contractNumber VARCHAR(100),
        startDate DATETIME,
        endDate DATETIME,
        discountPercentage DECIMAL(5,2),
        maxCreditDays INT,
        maxCreditLimit DECIMAL(10,2),
        isActive BOOLEAN DEFAULT TRUE,
        createdAt DATETIME,
        updatedAt DATETIME,
        FOREIGN KEY (dealerId) REFERENCES Dealer(id)
    )`);

    // Order
    _=check dbClient->execute(`CREATE TABLE IF NOT EXISTS Order (
        id CHAR(36) PRIMARY KEY,
        userId CHAR(36),
        dealerId CHAR(36),
        totalAmount DECIMAL(10,2),
        status VARCHAR(20),
        createdAt DATETIME,
        updatedAt DATETIME,
        FOREIGN KEY (userId) REFERENCES User(id),
        FOREIGN KEY (dealerId) REFERENCES Dealer(id)
    )`);

    // OrderItem
    _=check dbClient->execute(`CREATE TABLE IF NOT EXISTS OrderItem (
        id CHAR(36) PRIMARY KEY,
        orderId CHAR(36),
        productId CHAR(36),
        colorId CHAR(36),
        price DECIMAL(10,2),
        quantity INT,
        createdAt DATETIME,
        updatedAt DATETIME,
        FOREIGN KEY (orderId) REFERENCES Order(id),
        FOREIGN KEY (productId) REFERENCES Product(id),
        FOREIGN KEY (colorId) REFERENCES Color(id)
    )`);

    // Invoice
    _=check dbClient->execute(`CREATE TABLE IF NOT EXISTS Invoice (
        id CHAR(36) PRIMARY KEY,
        orderId CHAR(36),
        totalAmount DECIMAL(10,2),
        pdfUrl TEXT,
        createdAt DATETIME,
        updatedAt DATETIME,
        FOREIGN KEY (orderId) REFERENCES Order(id)
    )`);

    // Payment
    _=check dbClient->execute(`CREATE TABLE IF NOT EXISTS Payment (
        id CHAR(36) PRIMARY KEY,
        orderId CHAR(36),
        amount DECIMAL(10,2),
        method VARCHAR(50),
        status VARCHAR(50),
        createdAt DATETIME,
        updatedAt DATETIME,
        FOREIGN KEY (orderId) REFERENCES Order(id)
    )`);

    // Shipment
    _=check dbClient->execute(`CREATE TABLE IF NOT EXISTS Shipment (
        id CHAR(36) PRIMARY KEY,
        orderId CHAR(36),
        trackingNumber VARCHAR(100),
        carrier VARCHAR(100),
        shippedAt DATETIME,
        deliveredAt DATETIME,
        status VARCHAR(50),
        addressId CHAR(36),
        createdAt DATETIME,
        updatedAt DATETIME,
        FOREIGN KEY (orderId) REFERENCES Order(id),
        FOREIGN KEY (addressId) REFERENCES Address(id)
    )`);

    // Review
    _=check dbClient->execute(`CREATE TABLE IF NOT EXISTS Review (
        id CHAR(36) PRIMARY KEY,
        productId CHAR(36),
        userId CHAR(36),
        rating INT,
        comment TEXT,
        createdAt DATETIME,
        updatedAt DATETIME,
        FOREIGN KEY (productId) REFERENCES Product(id),
        FOREIGN KEY (userId) REFERENCES User(id)
    )`);

    // Inquiry
    _=check dbClient->execute(`CREATE TABLE IF NOT EXISTS Inquiry (
        id CHAR(36) PRIMARY KEY,
        userId CHAR(36),
        dealerId CHAR(36),
        subject VARCHAR(200),
        message TEXT,
        isResolved BOOLEAN DEFAULT FALSE,
        createdAt DATETIME,
        updatedAt DATETIME,
        FOREIGN KEY (userId) REFERENCES User(id),
        FOREIGN KEY (dealerId) REFERENCES Dealer(id)
    )`);

    // Notification
    _=check dbClient->execute(`CREATE TABLE IF NOT EXISTS Notification (
        id CHAR(36) PRIMARY KEY,
        userId CHAR(36),
        dealerId CHAR(36),
        type VARCHAR(50),
        title VARCHAR(100),
        message TEXT,
        isRead BOOLEAN DEFAULT FALSE,
        createdAt DATETIME,
        updatedAt DATETIME,
        FOREIGN KEY (userId) REFERENCES User(id),
        FOREIGN KEY (dealerId) REFERENCES Dealer(id)
    )`);

    // ActivityLog
    _=check dbClient->execute(`CREATE TABLE IF NOT EXISTS ActivityLog (
        id CHAR(36) PRIMARY KEY,
        userId CHAR(36),
        dealerId CHAR(36),
        action VARCHAR(100),
        description TEXT,
        createdAt DATETIME,
        updatedAt DATETIME,
        FOREIGN KEY (userId) REFERENCES User(id),
        FOREIGN KEY (dealerId) REFERENCES Dealer(id)
    )`);

    log:printInfo("✅ Migration: All tables created.");
}