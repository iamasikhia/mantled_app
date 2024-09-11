///The model is used to store all the logistic fares created and gotten from the API
class LogisticsFares {
  /// Constructor for [LogisticsFares] class
  LogisticsFares({
    this.id,
    this.origin,
    this.destination,
    this.size,
    this.cost,
    this.providerId,
    this.createdAt,
    this.updatedAt,
    this.provider,
  });

  int? id;
  String? origin;
  String? destination;
  String? size;
  String? cost;
  int? providerId;
  DateTime? createdAt;
  DateTime? updatedAt;
  Provider? provider;
  // List<Provider> provider;

  factory LogisticsFares.fromJson(Map<String, dynamic> json) => LogisticsFares(
        id: json["id"],
        origin: json["origin"],
        destination: json["destination"],
        size: json["size"],
        cost: json["cost"],
        providerId: json["ProviderId"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        provider: Provider.fromJson(json["Provider"]),
        //   provider: List<Provider>.from(json["Provider"].map((x) => Provider.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "origin": origin,
        "destination": destination,
        "size": size,
        "cost": cost,
        "ProviderId": providerId,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "Provider": provider?.toJson(),
        // "Provider": provider.toList(),
      };
}

class Provider {
  Provider({
    this.id,
    this.companyName,
    this.phoneNumber,
    this.createdAt,
    this.updatedAt,
    this.userId,
    this.avgRating,
  });

  int? id;
  String? companyName;
  String? phoneNumber;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? userId;
  dynamic avgRating;

  factory Provider.fromJson(Map<String, dynamic> json) => Provider(
        id: json["id"],
        companyName: json["companyName"],
        phoneNumber: json["phoneNumber"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        userId: json["UserId"],
        avgRating: json["avgRating"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "companyName": companyName,
        "phoneNumber": phoneNumber,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "UserId": userId,
        "avgRating": avgRating,
      };
}
