import ballerina/time;

public enum RoleType {
    Admin = "Admin",
    Customer = "Customer",
    Manager = "Manager",
    Guest = "Guest",
    Employee = "Employee",
    SalesRepresentative = "SalesRepresentative"
}

public type Role record {
    string id;
    RoleType roleType;
    string description;
};

public type User record {
    string id;
    string name;
    string email;
    string phone;
    string password;
    string roleId;
    boolean isActive = true;
    time:Utc createdAt;
    time:Utc updatedAt;
};

public type Address record {
    string id;
    string country;
    string state;
    string city;
    string addressLine1;
    string addressLine2?;
    string zipCode;
    boolean isDefault = false;
    string? userId;
    string? dealerId;
    time:Utc createdAt;
    time:Utc updatedAt;
};

public type Category record {
    string id;
    string name;
    string description;
    boolean isActive = true;
    time:Utc createdAt;
    time:Utc updatedAt;
};

public type Product record {
    string id;
    string name;
    string description;
    string categoryId;
    decimal basePrice;
    decimal finalPrice;
    string imageUrl;
    string createdBy;
    boolean isActive = true;
    time:Utc createdAt;
    time:Utc updatedAt;
};

public type Color record {
    string id;
    string name;
    string hexCode;
    string productId;
    boolean isActive = true;
    time:Utc createdAt;
    time:Utc updatedAt;
};

public type Offer record {
    string id;
    string name;
    string description;
    string code;
    string productId;
    decimal discountPercentage;
    time:Utc? startDate;
    time:Utc? endDate;
    boolean isActive = true;
    time:Utc createdAt;
    time:Utc updatedAt;
};

public enum OrderStatus {
    Pending = "Pending",
    Confirmed = "Confirmed",
    Shipped = "Shipped",
    Delivered = "Delivered",
    Cancelled = "Cancelled"
}

public type Order record {
    string id;
    string? userId;
    string? dealerId;
    decimal totalAmount;
    OrderStatus status;
    time:Utc createdAt;
    time:Utc updatedAt;
};

public type OrderItem record {
    string id;
    string orderId;
    string productId;
    string colorId;
    decimal price;
    int quantity;
    time:Utc createdAt;
    time:Utc updatedAt;
};

public type Invoice record {
    string id;
    string orderId;
    decimal totalAmount;
    string? pdfUrl;
    time:Utc createdAt;
    time:Utc updatedAt;
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
    string id;
    string orderId;
    decimal amount;
    PaymentMethod method;
    PaymentStatus status;
    time:Utc createdAt;
    time:Utc updatedAt;
};

public enum ShipmentStatus {
    Pending = "Pending",
    Shipped = "Shipped",
    InTransit = "InTransit",
    Delivered = "Delivered",
    Cancelled = "Cancelled"
}

public type Shipment record {
    string id;
    string orderId;
    string? trackingNumber;
    string? carrier;
    time:Utc? shippedAt;
    time:Utc? deliveredAt;
    ShipmentStatus status;
    string addressId;
    time:Utc createdAt;
    time:Utc updatedAt;
};

public type Dealer record {
    string id;
    string name;
    string email;
    string phone;
    string contactPerson;
    boolean isActive = true;
    time:Utc createdAt;
    time:Utc updatedAt;
};

public type DealerContract record {
    string id;
    string dealerId;
    string contractNumber;
    time:Utc? startDate;
    time:Utc? endDate;
    decimal discountPercentage;
    int maxCreditDays;
    decimal maxCreditLimit;
    boolean isActive = true;
    time:Utc createdAt;
    time:Utc updatedAt;
};

public type Review record {
    string id;
    string? productId;
    string? userId;
    int rating;
    string? comment;
    time:Utc createdAt;
    time:Utc updatedAt;
};

public type Inquiry record {
    string id;
    string? userId;
    string? dealerId;
    string subject;
    string message;
    boolean isResolved = false;
    time:Utc createdAt;
    time:Utc updatedAt;
};

public enum NotificationType {
    Orders = "Order",
    Shipments = "Shipment",
    Payments = "Payment",
    Inquirys = "Inquiry",
    Generals = "General"
}

public type Notification record {
    string id;
    string? userId;
    string? dealerId;
    NotificationType typed;
    string title;
    string message;
    boolean isRead = false;
    time:Utc createdAt;
    time:Utc updatedAt;
};

public type ActivityLog record {
    string id;
    string? userId;
    string? dealerId;
    string action;
    string? description;
    time:Utc createdAt;
    time:Utc updatedAt;
};
