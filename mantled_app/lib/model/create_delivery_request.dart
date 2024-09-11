/// A class to hold my [CreateDeliveryRequest] model

class CreateDeliveryRequest {
  /// A string variable to hold the product description
  String? productDescription;

  /// A string variable to hold the amount of items being shipped
  String? itemCount;

  /// A string variable to hold the phone number of the pickup location
  String? pickUpPhoneNumber;

  /// A string variable to hold the phone number of the drop-off location
  String? dropOffPhoneNumber;

  /// A string variable to hold the address of the pickup location
  String? pickUpAddress;

  /// A string variable to hold the address of the drop-off location
  String? dropOffAddress;

  /// A string variable to hold the pickup location area
  String? pickUpArea;

  /// A string variable to hold the drop-off location area
  String? dropOffArea;

  /// A string variable to hold the delivery instruction
  String? deliveryInstruction;

  /// A string variable to hold the size category of the product
  String? productSize;

  /// A string variable to the delivery priority
  String? priority;

  /// A string variable to hold the provider ID for logistic provider selection
  int? providerId;

  /// A string variable to hold the sender name
  String? senderName;

  /// A string variable to hold the recipient name
  String? recipientName;

  /// A string variable to hold the recipient name
  int? cost;

  /// Constructor for [CreateDeliveryRequest] class
  CreateDeliveryRequest();
}
