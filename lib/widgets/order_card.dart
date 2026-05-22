import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class OrderCard extends StatelessWidget {
  final String orderNumber;
  final String customerName;
  final String timeAgo;
  final String productName;
  final String totalPrice;
  final bool isUrgent;
  final bool isNew;
  final bool isCompleted;
  final String imageUrl;
  final VoidCallback onReject;
  final VoidCallback onAccept;

  const OrderCard({
    super.key,
    required this.orderNumber,
    required this.customerName,
    required this.timeAgo,
    required this.productName,
    required this.totalPrice,
    required this.imageUrl,
    required this.onReject,
    required this.onAccept,
    this.isUrgent = false,
    this.isNew = true,
    this.isCompleted = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(17.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFC7C4D7)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 1,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _CardHeader(
            orderNumber: orderNumber,
            isUrgent: isUrgent,
            isNew: isNew,
            isCompleted: isCompleted,
            timeAgo: timeAgo,
          ),
          const SizedBox(height: 4),
          Text(
            '고객: $customerName',
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 17,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 16),
          _ProductInfo(
            productName: productName,
            totalPrice: totalPrice,
            imageUrl: imageUrl,
          ),
          const SizedBox(height: 16),
          if (isCompleted)
            Container(
              width: double.infinity,
              height: 48,
              decoration: BoxDecoration(
                color: const Color(0xFFF4F3F8),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.check_circle,
                    color: Color(0xFF5E5CE6),
                    size: 20,
                  ),
                  SizedBox(width: 8),
                  Text(
                    '전달 완료된 요청건',
                    style: TextStyle(
                      color: Color(0xFF5E5CE6),
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            )
          else
            _ActionButtons(
              onReject: onReject,
              onAccept: onAccept,
            ),
        ],
      ),
    );
  }
}

class _CardHeader extends StatelessWidget {
  final String orderNumber;
  final bool isUrgent;
  final bool isNew;
  final bool isCompleted;
  final String timeAgo;

  const _CardHeader({
    required this.orderNumber,
    required this.isUrgent,
    required this.isNew,
    required this.isCompleted,
    required this.timeAgo,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(
              orderNumber,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (isUrgent) ...[
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFDAD6),
                  borderRadius: BorderRadius.circular(9999),
                ),
                child: const Text(
                  '긴급',
                  style: TextStyle(
                    color: Color(0xFF93000A),
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: isCompleted
                    ? const Color(0xFFE8F5E9) // 연초록 배경
                    : (isNew ? const Color(0xFFE2DFFF) : const Color(0xFFFFECD6)),
                borderRadius: BorderRadius.circular(9999),
              ),
              child: Text(
                isCompleted ? '완료' : (isNew ? '신규' : '지연'),
                style: TextStyle(
                  color: isCompleted
                      ? const Color(0xFF2E7D32) // 초록 텍스트
                      : (isNew ? const Color(0xFF5E5CE6) : const Color(0xFFAE5600)),
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        Text(
          timeAgo,
          style: const TextStyle(
            color: AppColors.textSecondary,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _ProductInfo extends StatelessWidget {
  final String productName;
  final String totalPrice;
  final String imageUrl;

  const _ProductInfo({
    required this.productName,
    required this.totalPrice,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: const Color(0xFFEEF2FF),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0x4DC7C4D7)),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(11),
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => const Center(
                child: Icon(
                  Icons.shopping_bag_outlined,
                  color: Color(0xFF5E5CE6),
                  size: 28,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: SizedBox(
            height: 80,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  productName,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  '총 결제금액: $totalPrice',
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _ActionButtons extends StatelessWidget {
  final VoidCallback onReject;
  final VoidCallback onAccept;

  const _ActionButtons({
    required this.onReject,
    required this.onAccept,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 48,
            child: OutlinedButton(
              onPressed: onReject,
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color(0xFF777586)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                '거절',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: SizedBox(
            height: 48,
            child: ElevatedButton(
              onPressed: onAccept,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4441CC),
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                '수락',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
