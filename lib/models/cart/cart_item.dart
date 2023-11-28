class CartItem {
  final String? name;
  final double? price;
  final double? lat;
  final double? long;

  CartItem({this.name, this.price, this.lat, this.long});
}

List<CartItem> getItems() {
  return [
    CartItem(name: 'Teclado ', price: 24, lat: -15.628007, long: -56.152840),
    CartItem(name: 'Mouse', price: 20, lat: -15.655778, long: -56.094818),
    CartItem(name: 'Monitor LED', price: 44, lat: -15.613128, long: -56.122627),
    CartItem(
        name: 'Macbook Air', price: 240, lat: -15.620402, long: -56.071815),
    CartItem(name: 'Samsung', price: 204, lat: -15.636272, long: -56.027870),
    CartItem(name: 'iMac', price: 248, lat: -15.599240, long: -56.045380),
    CartItem(name: 'Headphones', price: 29, lat: -15.615112, long: -56.015511),
    CartItem(name: 'Disco USB', price: 19, lat: -15.571792, long: -56.073532),
    CartItem(name: 'SSD', price: 23, lat: -15.569807, long: -56.055679),
  ];
}
