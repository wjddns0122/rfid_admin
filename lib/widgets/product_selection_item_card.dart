import 'package:flutter/material.dart';
import '../models/order_item_data.dart';

class ProductSelectionItemCard extends StatelessWidget {
  final OrderItemData item;
  final bool isSelected;
  final ValueChanged<bool?> onChanged;

  const ProductSelectionItemCard({
    super.key,
    required this.item,
    required this.isSelected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSelected
              ? const Color(0xFF3F3BBD)
              : const Color(0xFFC7C4D6).withOpacity(0.5),
          width: isSelected ? 1.5 : 1,
        ),
      ),
      child: CheckboxListTile(
        value: isSelected,
        onChanged: onChanged,
        activeColor: const Color(0xFF3F3BBD),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
        controlAffinity: ListTileControlAffinity.trailing,
        title: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: const Color(0xFFEEEDF3),
                borderRadius: BorderRadius.circular(8),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  item.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Icon(
                    item.imagePlaceholderIcon,
                    color: const Color(0xFFC7C4D6),
                    size: 24,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: const TextStyle(
                      color: Color(0xFF1A1B1F),
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    item.options,
                    style: const TextStyle(
                      color: Color(0xFF464554),
                      fontSize: 11,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
