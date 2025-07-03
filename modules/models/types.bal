import ballerina/time;
import ballerina/uuid;


public enum RoleType {
    Admin = "Admin",
    Customer = "Customer",
    Manager = "Manager",
    Guest = "Guest",
    Employee = "Employee",
    SalesRepresentative = "SalesRepresentative"
}

public type Role record {
    uuid:Uuid id;
    RoleType roleType;
    string description;
};

public type User record {
    uuid:Uuid id;
    string name;
    string email;
    string phone;
    string  password;
    uuid:Uuid roleId;
    boolean isActive = true;
    time:Utc? createdAt = time:utcNow();
    time:Utc? updatedAt = time:utcNow();
};

public type Address record {
    uuid:Uuid id;
    string country;
    string state;
    string city;
    string addressLine1;
    string addressLine2?;
    string zipCode;
    boolean isDefault = false;
    uuid:Uuid? userId;
    uuid:Uuid? dealerId;
    time:Utc? createdAt = time:utcNow();
    time:Utc? updatedAt = time:utcNow();
};

public type Category record {
    uuid:Uuid id;
    string name;
    string description;
    boolean isActive = true;
    time:Utc? createdAt = time:utcNow();
    time:Utc? updatedAt = time:utcNow();
};

public type Product record {
    uuid:Uuid id;
    string name;
    string description;
    uuid:Uuid categoryId;
    decimal basePrice;
    decimal finalPrice;
    string imageUrl;
    uuid:Uuid createdBy;
    boolean isActive = true;
    time:Utc? createdAt = time:utcNow();
    time:Utc? updatedAt = time:utcNow();
};


public type Color record {
    uuid:Uuid id;
    string name;
    string hexCode;
    uuid:Uuid productId;
    boolean isActive = true;
    time:Utc? createdAt = time:utcNow();
    time:Utc? updatedAt = time:utcNow();
};

public type Offer record {
    uuid:Uuid id;
    string name;
    string description;
    string code;
    uuid:Uuid productId;
    decimal discountPercentage;
    time:Utc? startDate;
    time:Utc? endDate;
    boolean isActive = true;
    time:Utc? createdAt = time:utcNow();
    time:Utc? updatedAt = time:utcNow();
};

public enum OrderStatus {
    Pending = "Pending",
    Confirmed = "Confirmed",
    Shipped = "Shipped",
    Delivered = "Delivered",
    Cancelled = "Cancelled"
}
public type Order record {
    uuid:Uuid id;
    uuid:Uuid? userId;
    uuid:Uuid? dealerId;
    decimal totalAmount;
    OrderStatus status;
    time:Utc? createdAt = time:utcNow();
    time:Utc? updatedAt = time:utcNow();
};

public type OrderItem record {
    uuid:Uuid id;
    uuid:Uuid orderId;
    uuid:Uuid productId;
    uuid:Uuid colorId;
    decimal price;
    int quantity;
    time:Utc? createdAt = time:utcNow();
    time:Utc? updatedAt = time:utcNow();
};

public type Invoice record {
    uuid:Uuid id;
    uuid:Uuid orderId;
    decimal totalAmount;
    string? pdfUrl;
    time:Utc? createdAt = time:utcNow();
    time:Utc? updatedAt = time:utcNow();
};

public enum PaymentStatus {
    Pending = "Pending",
    Completed = "Completed",
    Failed = "Failed",
    Refunded = "Refunded"
}

public enum PaymentMethod {
    CreditDebitCard = "CreditDebitCard",
    PayPal = "PayPal",
    BankTransfer = "BankTransfer",
    CashOnDelivery = "CashOnDelivery"
}

public type Payment record {
    uuid:Uuid id;
    uuid:Uuid orderId;
    decimal amount;
    PaymentMethod method;
    PaymentStatus status;
    time:Utc? createdAt = time:utcNow();
    time:Utc? updatedAt = time:utcNow();
};

public enum ShipmentStatus {
    Pending = "Pending",
    Shipped = "Shipped",
    InTransit = "InTransit",
    Delivered = "Delivered",
    Cancelled = "Cancelled"
}

public type Shipment record {
    uuid:Uuid id;
    uuid:Uuid orderId;
    string? trackingNumber;
    string? carrier;
    time:Utc? shippedAt;
    time:Utc? deliveredAt?;
    ShipmentStatus status;
    uuid:Uuid addressId;
    time:Utc? createdAt = time:utcNow();
    time:Utc? updatedAt = time:utcNow();
};

public type Dealer record {
    uuid:Uuid id;
    string name;
    string email;
    string phone;
    string contactPerson;
    boolean isActive = true;
    time:Utc? createdAt = time:utcNow();
    time:Utc? updatedAt = time:utcNow();
};

public type DealerContract record {
    uuid:Uuid id;
    uuid:Uuid dealerId;
    string contractNumber;
    time:Utc? startDate;
    time:Utc? endDate?;
    decimal discountPercentage;
    int maxCreditDays;
    decimal maxCreditLimit;
    boolean isActive = true;
    time:Utc? createdAt = time:utcNow();
    time:Utc? updatedAt = time:utcNow();
};

public type Review record {
    uuid:Uuid id;
    uuid:Uuid? productId;
    uuid:Uuid? userId;
    int rating; // 1 to 5
    string comment?;
    time:Utc? createdAt = time:utcNow();
    time:Utc? updatedAt = time:utcNow();
};

public type Inquiry record {
    uuid:Uuid id;
    uuid:Uuid? userId;
    uuid:Uuid? dealerId;
    string subject;
    string message;
    boolean isResolved = false;
    time:Utc? createdAt = time:utcNow();
    time:Utc? updatedAt = time:utcNow();
};

public enum NotificationType {
    Orders = "Order",
    Shipments = "Shipment",
    Payments = "Payment",
    Inquirys = "Inquiry",
    Generals = "General"
}
public type Notification record {
    uuid:Uuid id;
    uuid:Uuid? userId;
    uuid:Uuid? dealerId;
    NotificationType typed;
    string title;
    string message;
    boolean isRead = false;
    time:Utc? createdAt = time:utcNow();
    time:Utc? updatedAt = time:utcNow();
};

public type ActivityLog record {
    uuid:Uuid id;
    uuid:Uuid? userId;
    uuid:Uuid? dealerId;
    string action;
    string description?;
    time:Utc? createdAt = time:utcNow();
    time:Utc? updatedAt = time:utcNow();
};