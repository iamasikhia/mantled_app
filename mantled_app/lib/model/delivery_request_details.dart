///The model is used to store all the delivery requests created and gotten from the API
class DeliveryRequestDetails {
  /// Constructor for [DeliveryRequestDetails] class
  DeliveryRequestDetails({
    this.id,
    this.senderName,
    this.recipientName,
    this.description,
    this.pickupPhoneNumber,
    this.pickupStreetAddress,
    this.dropoffPhoneNumber,
    this.dropoffStreetAddress,
    this.pickupArea,
    this.dropoffArea,
    this.instructions,
    this.size,
    this.priority,
    this.itemCount,
    this.status,
    this.comment,
    this.cost,
    this.pickupPin,
    this.dropoffPin,
    this.pickupDate,
    this.dropoffDate,
    this.assignDate,
    this.createdAt,
    this.updatedAt,
    this.providerId,
    this.customerId,
    this.agentId,
    this.page,
  });

  int? id;
  String? senderName;
  String? recipientName;
  String? description;
  String? pickupPhoneNumber;
  String? pickupStreetAddress;
  String? dropoffPhoneNumber;
  String? dropoffStreetAddress;
  String? pickupArea;
  String? dropoffArea;
  String? instructions;
  String? size;
  String? priority;
  int? itemCount;
  String? status;
  String? comment;
  String? cost;
  int? pickupPin;
  int? dropoffPin;
  DateTime? pickupDate;
  DateTime? dropoffDate;
  DateTime? assignDate;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? providerId;
  int? customerId;
  int? agentId;
  Page? page;

  factory DeliveryRequestDetails.fromJson(Map<String, dynamic> json) =>
      DeliveryRequestDetails(
        id: json["id"],
        senderName: json["senderName"],
        recipientName: json["recipientName"],
        description: json["description"],
        pickupPhoneNumber: json["pickupPhoneNumber"],
        pickupStreetAddress: json["pickupStreetAddress"],
        dropoffPhoneNumber: json["dropoffPhoneNumber"],
        dropoffStreetAddress: json["dropoffStreetAddress"],
        pickupArea: json["pickupArea"],
        dropoffArea: json["dropoffArea"],
        instructions: json["instructions"],
        size: json["size"],
        priority: json["priority"],
        itemCount: json["itemCount"],
        status: json["status"],
        comment: json["comment"],
        cost: json["cost"],
        pickupPin: json["pickupPin"],
        dropoffPin: json["dropoffPin"],
        pickupDate: json["pickupDate"] == null
            ? null
            : DateTime.parse(json["pickupDate"]),
        dropoffDate: json["dropoffDate"] == null
            ? null
            : DateTime.parse(json["dropoffDate"]),
        assignDate: json["assignDate"] == null
            ? null
            : DateTime.parse(json["assignDate"]),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        providerId: json["ProviderId"],
        customerId: json["CustomerId"],
        agentId: json["AgentId"],
        page: Page.fromJson(json["page"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "senderName": senderName,
        "recipientName": recipientName,
        "description": description,
        "pickupPhoneNumber": pickupPhoneNumber,
        "pickupStreetAddress": pickupStreetAddress,
        "dropoffPhoneNumber": dropoffPhoneNumber,
        "dropoffStreetAddress": dropoffStreetAddress,
        "pickupArea": pickupArea,
        "dropoffArea": dropoffArea,
        "instructions": instructions,
        "size": size,
        "priority": priority,
        "itemCount": itemCount,
        "status": status,
        "comment": comment,
        "cost": cost,
        "pickupPin": pickupPin,
        "dropoffPin": dropoffPin,
        "pickupDate": pickupDate?.toIso8601String(),
        "dropoffDate": dropoffDate?.toIso8601String(),
        "assignDate": assignDate?.toIso8601String(),
        "createdAt": createdAt,
        "updatedAt": updatedAt?.toIso8601String(),
        "ProviderId": providerId,
        "CustomerId": customerId,
        "AgentId": agentId,
        "page": page?.toJson(),
      };
}

class Page {
  Page({
    this.size,
    this.totalElements,
    this.totalPages,
    this.number,
  });

  int? size;
  int? totalElements;
  int? totalPages;
  int? number;

  factory Page.fromJson(Map<String, dynamic> json) => Page(
        size: json["size"],
        totalElements: json["totalElements"],
        totalPages: json["totalPages"],
        number: json["number"],
      );

  Map<String, dynamic> toJson() => {
        "size": size,
        "totalElements": totalElements,
        "totalPages": totalPages,
        "number": number,
      };
}
