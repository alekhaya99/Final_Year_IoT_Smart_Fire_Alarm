class SmokeSensor{
  final double co;
  final double lpg;
  final double smoke;

  SmokeSensor({this.co, this.lpg, this.smoke});

  factory SmokeSensor.fromJson(Map<dynamic, dynamic> json) {
    double parser(dynamic source) {
      try {
        return double.parse(source.toString());
      } on FormatException {
        return -1;
      }
    }

    return SmokeSensor(
        co: parser(json['co']),
        lpg: parser(json['lpg']),
        smoke: parser(json['smoke']),
    );
  }
}