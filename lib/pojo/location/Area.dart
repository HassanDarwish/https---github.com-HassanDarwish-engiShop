
class DeliveryArea {
  String? latitudeMax;
  String? longitudeMin;

  DeliveryArea({this.latitudeMax, this.longitudeMin});

  DeliveryArea.fromJson(Map<String, dynamic> json) {
    latitudeMax = json['latitudeMax'];
    longitudeMin = json['longitudeMin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['latitudeMax'] = latitudeMax;
    data['longitudeMin'] = longitudeMin;
    return data;
  }
}