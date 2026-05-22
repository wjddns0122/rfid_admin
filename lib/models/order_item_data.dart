import 'package:flutter/material.dart';

class OrderItemData {
  final String id;
  final String brand;
  final String name;
  final String options;
  final int quantity;
  String status;
  String statusMessage;
  Color statusColor;
  IconData statusIcon;
  bool isScanned;
  final String imageUrl;
  final IconData imagePlaceholderIcon;

  // Detailed specifications from Figma 112:3207
  final String subtitle;
  final String sku;
  final String color;
  final String size;
  final String locationZone;
  final String locationShelf;
  final int availableStock;
  final String pickingCaution;

  OrderItemData({
    required this.id,
    required this.brand,
    required this.name,
    required this.options,
    required this.quantity,
    required this.status,
    required this.statusMessage,
    required this.statusColor,
    required this.statusIcon,
    required this.isScanned,
    required this.imageUrl,
    required this.imagePlaceholderIcon,
    required this.subtitle,
    required this.sku,
    required this.color,
    required this.size,
    required this.locationZone,
    required this.locationShelf,
    required this.availableStock,
    required this.pickingCaution,
  });
}
