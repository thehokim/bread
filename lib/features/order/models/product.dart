class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final String image;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
  });

  static List<Product> getDemoProducts() {
    return [
      Product(
        id: '1',
        name: 'Свежий хлеб',
        description: 'Свежий хлеб, выпеченный каждое утро',
        price: 5000,
        image: '🍞',
      ),
    ];
  }
}