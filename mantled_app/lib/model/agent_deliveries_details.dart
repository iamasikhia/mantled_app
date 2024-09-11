///The model is used to store all the delivery requests created and gotten from the API
class AgentDeliveriesDetails {
  /// Constructor for [AgentDeliveriesDetails] class
  AgentDeliveriesDetails({
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
    this.createdAt,
    this.updatedAt,
    this.providerId,
    this.customerId,
    this.agentId,
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
  DateTime? createdAt;
  DateTime? updatedAt;
  int? providerId;
  int? customerId;
  int? agentId;

  factory AgentDeliveriesDetails.fromJson(Map<String, dynamic> json) =>
      AgentDeliveriesDetails(
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
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        providerId: json["ProviderId"],
        customerId: json["CustomerId"],
        agentId: json["AgentId"],
      );


}
