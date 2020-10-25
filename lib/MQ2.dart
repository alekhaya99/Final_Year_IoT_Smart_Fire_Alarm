class MQ2 {
  final double co;
  final double lpg;
  final double smoke;

  MQ2({this.co, this.lpg, this.smoke});

  factory MQ2.fromJson(Map<dynamic, dynamic> json) {
    double parser(dynamic source) {
      try {
        return double.parse(source.toString());
      } on FormatException {
        return -1;
      }
    }

    return MQ2(
        co: parser(json['co']),
        lpg: parser(json['lpg']),
        smoke: parser(json['smoke']),
    );
  }
}