class DeliveryAgentLocation {
  final double latitude;
  final double longitude;
  final bool isDelivered;

  DeliveryAgentLocation({
    required this.latitude,
    required this.longitude,
    required this.isDelivered,
  });

  // Factory constructor to create a DelivererLocation from a JSON map.
  factory DeliveryAgentLocation.fromJson(Map<String, dynamic> json) {
    return DeliveryAgentLocation(
      latitude: json['latitude'],
      longitude: json['longitude'],
      isDelivered: json['isDelivered'],
    );
  }
}
