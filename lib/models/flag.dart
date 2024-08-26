class Flag {
  final String country;
  final String src;

  Flag({required this.country, required this.src});

  factory Flag.fromJson(Map<String, dynamic> json) {
    return Flag(
      country: json['country'],
      src: json['src'],
    );
  }
}