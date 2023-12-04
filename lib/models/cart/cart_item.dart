class CartItem {
  final String? name;
  final String? price;
  final double? latitude;
  final double? longitude;

  CartItem({this.name, this.price, this.latitude, this.longitude});
}

List<CartItem> getItems() {
  return [
    CartItem(
        name: 'Teclado ',
        price: '24',
        latitude: -56.11662257893606,
        longitude: -15.571306644945508),
    CartItem(
        name: 'Mouse',
        price: '20',
        latitude: -56.05994398887748,
        longitude: -15.587943228688175),
    CartItem(
        name: 'Monitor LED',
        price: '44',
        latitude: -56.09059421354432,
        longitude: -15.609264203489488),
    CartItem(
        name: 'Macbook Air',
        price: '240',
        latitude: -56.10032444359713,
        longitude: -15.584428569704542),
    CartItem(
        name: 'Samsung',
        price: '204',
        latitude: -56.088404911782035,
        longitude: -15.577633391832805),
    CartItem(
        name: 'iMac',
        price: '248',
        latitude: -56.07624212421642,
        longitude: -15.597081060533526),
    CartItem(
        name: 'Headphones',
        price: '29',
        latitude: -56.13486676028526,
        longitude: -15.603407013520751),
    CartItem(
        name: 'Disco USB',
        price: '19',
        latitude: -56.13778582930141,
        longitude: -15.636673628300471),
    CartItem(
        name: 'SSD',
        price: '23',
        latitude: -56.09521607281944,
        longitude: -15.647683219139665),
  ];
}
