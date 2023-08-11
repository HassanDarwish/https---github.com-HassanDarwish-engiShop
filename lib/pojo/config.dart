

class Config{

  int per_page=100;
  int page=1;
  late String consumerKey;
  late String consumerSecret;

  factory Config.fromJson( Map<dynamic, dynamic> json) {
    Config _config= Config(consumerSecret: json['consumerSecret'],consumerKey: json['consumerKey']);
    return _config;
  }
  Config({required this.consumerSecret,required this.consumerKey});

}