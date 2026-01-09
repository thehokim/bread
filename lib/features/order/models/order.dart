import 'package:intl/intl.dart';
import 'cart_item.dart';
import 'address.dart';

enum OrderStatus { pending, delivered, cancelled }

class Order {
  final String id;
  final List<CartItem> items;
  final Address address;
  final DateTime deliveryTime;
  final DateTime createdAt;
  final double total;
  final OrderStatus status;
  final String? comment;

  Order({
    required this.id,
    required this.items,
    required this.address,
    required this.deliveryTime,
    required this.createdAt,
    required this.total,
    required this.status,
    this.comment,
  });

  String get formattedDate =>
      DateFormat('dd.MM.yyyy').format(createdAt);

  String get formattedTime =>
      DateFormat('HH:mm').format(deliveryTime);

  String get statusText {
    switch (status) {
      case OrderStatus.pending:
        return 'В обработке';
      case OrderStatus.delivered:
        return 'Доставлен';
      case OrderStatus.cancelled:
        return 'Отменён';
    }
  }
}
