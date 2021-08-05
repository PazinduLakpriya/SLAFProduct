//// @dart=2.9
class Movie {
  final int id;
  final String product_name;
  final String product_location;
  final int product_price;
  final int quantity;

  Movie({
     required this.id,
    required this.product_name,
    required this.product_location,
    required this.product_price,
    required this.quantity});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
        id: json["id"],
        product_name: json["product_name"],
        product_location: json["product_location"],
        product_price: json["product_price"],
        quantity: json["quantity"]

    );
  }
}