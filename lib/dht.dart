class DHT {
  final double temp;
  final double humidity;
  final double heatIndex;
  final double temp_F;

  DHT({this.temp, this.humidity, this.heatIndex, this.temp_F});

  factory DHT.fromJson(Map<dynamic, dynamic> json) {
    double parser(dynamic source) {
      try {
        return double.parse(source.toString());
      } on FormatException {
        return -1;
      }
    }

    return DHT(
        temp: parser(json['temp']),
        humidity: parser(json['hum']),
        heatIndex: parser(json['ht']),
        temp_F: parser(json['temp_F']));
  }
}