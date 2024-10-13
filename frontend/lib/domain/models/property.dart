class Property {
  String title;
  String status;
  double price;

  Property({
    required this.title,
    required this.status,
    required this.price,
  });

  Property copy({
    String? title,
    String? status,
    double? price,
  }) =>
      Property(
        title: title ?? this.title,
        status: status ?? this.status,
        price: price ?? this.price,
      );

  static Property fromJson(Map<String, Object?> json) => Property(
        title: json['title'] as String,
        status: json['status'] as String,
        price: json['price'] as double,
      );

  Map<String, Object?> toJson() => {
        'name': title,
        'muscle': status,
        'instructions': price,
      };
}
