import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/address.dart';

class OrderCheckoutScreen extends StatefulWidget {
  const OrderCheckoutScreen({super.key});

  @override
  State<OrderCheckoutScreen> createState() => _OrderCheckoutScreenState();
}

class _OrderCheckoutScreenState extends State<OrderCheckoutScreen> {
  Address? _selectedAddress;
  DateTime? _selectedTime;
  final TextEditingController _commentController = TextEditingController();
  bool _isLoading = false;
  final bool _hasOrderedToday = false;

  final List<DateTime> _availableTimes = [
    DateTime(2024, 1, 1, 7, 0),
    DateTime(2024, 1, 1, 7, 30),
    DateTime(2024, 1, 1, 8, 0),
    DateTime(2024, 1, 1, 8, 30),
    DateTime(2024, 1, 1, 9, 0),
    DateTime(2024, 1, 1, 9, 30),
    DateTime(2024, 1, 1, 10, 0),
  ];

  @override
  void initState() {
    super.initState();
    final addresses = Address.getDemoAddresses();
    if (addresses.isNotEmpty) {
      _selectedAddress = addresses.first;
    }
    _selectedTime = _availableTimes.first;

    // Check if user already ordered today
    final now = DateTime.now();
    // final orders = context.read<OrderProvider>().orders;
    // _hasOrderedToday = orders.any((order) {
    //   return order.createdAt.year == now.year &&
    //          order.createdAt.month == now.month &&
    //          order.createdAt.day == now.day;
    // });
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  Future<void> _placeOrder() async {
    if (_selectedAddress == null || _selectedTime == null) return;

    if (_hasOrderedToday) {
      _showErrorDialog(
          'Вы уже сделали заказ сегодня. Можно заказать только 1 раз в день.');
      return;
    }

    setState(() => _isLoading = true);

    try {
      // final cart = context.read<CartProvider>();
      // final orderProvider = context.read<OrderProvider>();

      final now = DateTime.now();
      final deliveryTime = DateTime(
        now.year,
        now.month,
        now.day,
        _selectedTime!.hour,
        _selectedTime!.minute,
      );

      // await orderProvider.createOrder(
      //   items: cart.items.values.toList(),
      //   address: _selectedAddress!,
      //   deliveryTime: deliveryTime,
      //   total: cart.totalAmount,
      //   comment: _commentController.text.isEmpty ? null : _commentController.text,
      // );

      // cart.clear();

      if (mounted) {
        Navigator.of(context).popUntil((route) => route.isFirst);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Заказ успешно оформлен!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ошибка: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        content: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              const Icon(
                Icons.warning_amber_rounded,
                color: Color(0xFFFF8C00),
                size: 32,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  message,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showAddressSelector() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Адрес доставки',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ...Address.getDemoAddresses().map((address) {
              return ListTile(
                leading: Icon(
                  address.isHome ? Icons.home : Icons.location_on,
                  color: const Color(0xFFFF8C00),
                ),
                title: Text(address.name),
                subtitle: Text(address.details ?? ''),
                trailing: _selectedAddress?.id == address.id
                    ? const Icon(Icons.check, color: Color(0xFFFF8C00))
                    : null,
                onTap: () {
                  setState(() => _selectedAddress = address);
                  Navigator.pop(context);
                },
              );
            }),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F0),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Оформление заказа',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Address Section
            _SectionCard(
              icon: Icons.location_on,
              iconColor: const Color(0xFFFF8C00),
              title: 'Адрес доставки',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: _showAddressSelector,
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF8F0),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            _selectedAddress?.isHome == true
                                ? Icons.home
                                : Icons.location_on,
                            color: const Color(0xFFFF8C00),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _selectedAddress?.name ?? 'Выберите адрес',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                ),
                                if (_selectedAddress != null)
                                  Text(
                                    _selectedAddress!.details ?? '',
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontSize: 14,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          const Icon(Icons.arrow_drop_down),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Time Section
            _SectionCard(
              icon: Icons.access_time,
              iconColor: const Color(0xFFFF8C00),
              title: 'Время доставки',
              subtitle: '07:00 - 10:00',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: _availableTimes.map((time) {
                        final isSelected = _selectedTime?.hour == time.hour &&
                            _selectedTime?.minute == time.minute;
                        return _TimeSlot(
                          time: time,
                          isSelected: isSelected,
                          onTap: () => setState(() => _selectedTime = time),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF3E0),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.info_outline,
                            color: Color(0xFFFF8C00), size: 20),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Выберите удобное время: ${DateFormat('HH:mm').format(_selectedTime ?? _availableTimes.first)}',
                            style: const TextStyle(
                              color: Color(0xFFFF8C00),
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Comment Section
            _SectionCard(
              icon: Icons.comment,
              iconColor: Colors.grey,
              title: 'Комментарий к заказу',
              child: TextField(
                controller: _commentController,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'Подъезд, этаж, ориентир...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFFFF8C00)),
                  ),
                  filled: true,
                  fillColor: const Color(0xFFFFF8F0),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Order Summary
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFFFE8CC)),
              ),
              child: const Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Количество:',
                        style: TextStyle(fontSize: 16),
                      ),
                      // Text(
                      //   '${cart.totalQuantity} шт',
                      //   style: const TextStyle(
                      //     fontSize: 16,
                      //     fontWeight: FontWeight.w600,
                      //   ),
                      // ),
                    ],
                  ),
                  Divider(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Цена:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // Text(
                      //   '${NumberFormat('#,###').format(cart.totalAmount)} сум',
                      //   style: const TextStyle(
                      //     fontSize: 20,
                      //     fontWeight: FontWeight.bold,
                      //     color: Color(0xFFFF8C00),
                      //   ),
                      // ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Warning if already ordered
            if (_hasOrderedToday)
              Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF3E0),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFFF8C00)),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.warning_amber_rounded, color: Color(0xFFFF8C00)),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Вы уже сделали заказ сегодня. Можно заказывать только 1 раз в день.',
                        style: TextStyle(color: Color(0xFFFF8C00)),
                      ),
                    ),
                  ],
                ),
              ),

            // Place Order Button
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed:
                    (_isLoading || _hasOrderedToday) ? null : _placeOrder,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF8C00),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  disabledBackgroundColor: Colors.grey.shade300,
                ),
                child: _isLoading
                    ? const SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Text(
                        'Оформить заказ',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String? subtitle;
  final Widget child;

  const _SectionCard({
    required this.icon,
    required this.iconColor,
    required this.title,
    this.subtitle,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFFFE8CC)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: iconColor),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (subtitle != null)
                    Text(
                      subtitle!,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }
}

class _TimeSlot extends StatelessWidget {
  final DateTime time;
  final bool isSelected;
  final VoidCallback onTap;

  const _TimeSlot({
    required this.time,
    required this.isSelected,
    required this.onTap,
  });

  String _getEmoji() {
    final hour = time.hour;
    if (hour == 7) return '🌅';
    if (hour == 7 && time.minute == 30) return '☕';
    if (hour == 8) return '🌞';
    if (hour == 8 && time.minute == 30) return '🥐';
    if (hour == 9) return '☀️';
    if (hour == 9 && time.minute == 30) return '🌤️';
    return '🌻';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFF8C00) : const Color(0xFFFFF8F0),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? const Color(0xFFFF8C00) : Colors.grey.shade300,
          ),
        ),
        child: Column(
          children: [
            Text(
              _getEmoji(),
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 4),
            Text(
              DateFormat('HH:mm').format(time),
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
