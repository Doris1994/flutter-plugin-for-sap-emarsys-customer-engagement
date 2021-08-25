class CartItem {
  final String id;
  final double price;
  final int qty;
  CartItem({
    required this.id,
    required this.price,
    required this.qty,
  });

  Map<String, dynamic> toMap() {
    return {'id': id, 'price': price, 'qty': qty};
  }
}
