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
      name: 'Monitor LED',
      price: '44',
      latitude: -15.609264203489488,
      longitude: -56.09059421354432,
    ),
    CartItem(
      name: 'Teclado ',
      price: '24',
      latitude: -15.571306644945508,
      longitude: -56.11662257893606,
    ),
    CartItem(
      name: 'Mouse',
      price: '20',
      latitude: -15.587943228688175,
      longitude: -56.05994398887748,
    ),
    CartItem(
      name: 'Macbook Air',
      price: '240',
      latitude: -15.584428569704542,
      longitude: -56.10032444359713,
    ),
    CartItem(
      name: 'Samsung',
      price: '204',
      latitude: -15.577633391832805,
      longitude: -56.088404911782035,
    ),
    CartItem(
      name: 'iMac',
      price: '248',
      latitude: -15.597081060533526,
      longitude: -56.07624212421642,
    ),
    CartItem(
      name: 'Headphones',
      price: '29',
      latitude: -15.603407013520751,
      longitude: -56.13486676028526,
    ),
    CartItem(
      name: 'Disco USB',
      price: '19',
      latitude: -15.636673628300471,
      longitude: -56.13778582930141,
    ),
    CartItem(
      name: 'SSD',
      price: '23',
      latitude: -15.647683219139665,
      longitude: -56.09521607281944,
    ),
  ];
}
