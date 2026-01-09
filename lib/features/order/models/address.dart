class Address {
  final String id;
  final String name;
  final String? details;
  final bool isHome;

  const Address({
    required this.id,
    required this.name,
    this.details,
    this.isHome = false,
  });

  String get fullAddress {
    if (details == null || details!.isEmpty) return name;
    return '$name, $details';
  }

  static List<Address> getDemoAddresses() {
    return const [
      Address(
        id: '1',
        name: 'Дом',
        details: 'ул. Навои, 15',
        isHome: true,
      ),
      Address(
        id: '2',
        name: 'Работа',
        details: 'БЦ Millennium, 5 этаж',
        isHome: false,
      ),
    ];
  }
}
