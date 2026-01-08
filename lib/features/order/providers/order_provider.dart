import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import '../models/order.dart';
import '../models/cart_item.dart';
import '../models/address.dart';

class OrderProvider with ChangeNotifier {
  final List<Order> _orders = [];
  final Uuid _uuid = const Uuid();

  List<Order> get orders => [..._orders];

  Future<Order> createOrder({
    required List<CartItem> items,
    required Address address,
    required DateTime deliveryTime,
    required double total,
    String? comment,
  }) async {
    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));

    final order = Order(
      id: _uuid.v4(),
      items: items,
      address: address,
      deliveryTime: deliveryTime,
      createdAt: DateTime.now(),
      total: total,
      status: OrderStatus.pending,
      comment: comment,
    );

    _orders.insert(0, order);
    notifyListeners();
    return order;
  }

  Order? getOrderById(String id) {
    try {
      return _orders.firstWhere((order) => order.id == id);
    } catch (e) {
      return null;
    }
  }
}