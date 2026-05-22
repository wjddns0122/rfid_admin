import 'package:flutter/material.dart';
import '../models/order_item_data.dart';
import '../widgets/order_options_bottom_sheet.dart';

class OrderDetailScreen extends StatefulWidget {
  final OrderItemData item;
  final List<OrderItemData> allItems;
  final VoidCallback onRefresh;

  const OrderDetailScreen({
    super.key,
    required this.item,
    required this.allItems,
    required this.onRefresh,
  });

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF9FE),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: _ProductDetailAppBar(imageUrl: widget.item.imageUrl),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              top: 16.0,
              bottom: 120.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _ProductImageHero(
                  imageUrl: widget.item.imageUrl,
                  imagePlaceholderIcon: widget.item.imagePlaceholderIcon,
                  isScanned: widget.item.isScanned,
                ),
                const SizedBox(height: 16),
                _ProductHeadingInfo(
                  brand: widget.item.brand,
                  name: widget.item.name,
                  subtitle: widget.item.subtitle,
                ),
                const SizedBox(height: 16),
                _BentoSpecsCard(
                  sku: widget.item.sku,
                  color: widget.item.color,
                  size: widget.item.size,
                ),
                const SizedBox(height: 16),
                _BentoLocationCard(
                  zone: widget.item.locationZone,
                  shelf: widget.item.locationShelf,
                  availableStock: widget.item.availableStock,
                ),
                const SizedBox(height: 16),
                _PickingCautionCard(cautionText: widget.item.pickingCaution),
                const SizedBox(height: 24),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: _BottomActionBar(
              item: widget.item,
              allItems: widget.allItems,
              onRefresh: () {
                setState(() {});
                widget.onRefresh();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ProductDetailAppBar extends StatelessWidget {
  final String imageUrl;

  const _ProductDetailAppBar({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFFFAF9FE),
      elevation: 0,
      scrolledUnderElevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Color(0xFF3F3BBD)),
        onPressed: () => Navigator.pop(context),
      ),
      title: const Text(
        '제품 상세 정보',
        style: TextStyle(
          color: Color(0xFF3F3BBD),
          fontSize: 20,
          fontWeight: FontWeight.w600,
          letterSpacing: -0.2,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications_none, color: Color(0xFF464554)),
          onPressed: () {},
        ),
        Container(
          margin: const EdgeInsets.only(right: 16, left: 8),
          width: 32,
          height: 32,
          decoration: const BoxDecoration(
            color: Color(0xFFE3E2E7),
            shape: BoxShape.circle,
          ),
          child: ClipOval(
            child: Image.network(
              'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=100&auto=format&fit=crop&q=60',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.person, color: Color(0xFF777585), size: 18),
            ),
          ),
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(
          color: const Color(0xFFC7C4D6),
          height: 1,
        ),
      ),
    );
  }
}

class _ProductImageHero extends StatelessWidget {
  final String imageUrl;
  final IconData imagePlaceholderIcon;
  final bool isScanned;

  const _ProductImageHero({
    required this.imageUrl,
    required this.imagePlaceholderIcon,
    required this.isScanned,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.0,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFC7C4D6)),
          boxShadow: const [
            BoxShadow(
              color: Color(0x0A000000),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(11),
              child: SizedBox.expand(
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Center(
                    child: Icon(
                      imagePlaceholderIcon,
                      color: const Color(0xFFC7C4D6),
                      size: 96,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 13,
              right: 16,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: isScanned ? const Color(0xFF16A34A) : const Color(0xFF5856D6),
                  borderRadius: BorderRadius.circular(999),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x0D000000),
                      blurRadius: 1,
                      offset: Offset(0, 1),
                    ),
                  ],
                ),
                child: Text(
                  isScanned ? '피킹 완료' : '재고 있음',
                  style: TextStyle(
                    color: isScanned ? Colors.white : const Color(0xFFE7E4FF),
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.1,
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

class _ProductHeadingInfo extends StatelessWidget {
  final String brand;
  final String name;
  final String subtitle;

  const _ProductHeadingInfo({
    required this.brand,
    required this.name,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: const TextStyle(
              color: Color(0xFF3F3BBD),
              fontSize: 28,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.7,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: const TextStyle(
              color: Color(0xFF464554),
              fontSize: 16,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

class _BentoSpecsCard extends StatelessWidget {
  final String sku;
  final String color;
  final String size;

  const _BentoSpecsCard({
    required this.sku,
    required this.color,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(17.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFC7C4D6)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.info_outline, color: Color(0xFF3F3BBD), size: 20),
              SizedBox(width: 8),
              Text(
                '제품 사양',
                style: TextStyle(
                  color: Color(0xFF3F3BBD),
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  letterSpacing: -0.1,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildSpecRow('SKU', sku, showBorder: true),
          _buildSpecRow('색상', color, showBorder: true),
          _buildSpecRow('사이즈', size, showBorder: false),
        ],
      ),
    );
  }

  Widget _buildSpecRow(String label, String value, {required bool showBorder}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      decoration: BoxDecoration(
        border: showBorder
            ? const Border(bottom: BorderSide(color: Color(0xFFE5E5EA)))
            : null,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFF464554),
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Color(0xFF1A1B1F),
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _BentoLocationCard extends StatelessWidget {
  final String zone;
  final String shelf;
  final int availableStock;

  const _BentoLocationCard({
    required this.zone,
    required this.shelf,
    required this.availableStock,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(17.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFC7C4D6)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.location_on_outlined, color: Color(0xFF0058BC), size: 20),
              SizedBox(width: 8),
              Text(
                '보관 위치',
                style: TextStyle(
                  color: Color(0xFF0058BC),
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  letterSpacing: -0.1,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: const Color(0xFFF4F3F8),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '구역 / 선반',
                      style: TextStyle(
                        color: Color(0xFF464554),
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.2,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '$zone / $shelf',
                      style: const TextStyle(
                        color: Color(0xFF1A1B1F),
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ],
                ),
                const Icon(
                  Icons.storefront_outlined,
                  color: Color(0xFFC7C4D6),
                  size: 30,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Icon(Icons.inventory_2_outlined, color: Color(0xFF1A1B1F), size: 20),
              const SizedBox(width: 8),
              RichText(
                text: TextSpan(
                  style: const TextStyle(
                    color: Color(0xFF1A1B1F),
                    fontSize: 16,
                  ),
                  children: [
                    const TextSpan(text: '가용 재고: '),
                    TextSpan(
                      text: '$availableStock',
                      style: const TextStyle(
                        color: Color(0xFF3F3BBD),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const TextSpan(text: ' 개'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PickingCautionCard extends StatelessWidget {
  final String cautionText;

  const _PickingCautionCard({required this.cautionText});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(17.0),
      decoration: BoxDecoration(
        color: const Color(0xFFE2DFFF),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFC2C1FF)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 2.0),
            child: Icon(
              Icons.warning_rounded,
              color: Color(0xFF0C006A),
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '피킹 주의사항',
                  style: TextStyle(
                    color: Color(0xFF0C006A),
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.1,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  cautionText,
                  style: const TextStyle(
                    color: Color(0xFF3631B4),
                    fontSize: 15,
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomActionBar extends StatelessWidget {
  final OrderItemData item;
  final List<OrderItemData> allItems;
  final VoidCallback onRefresh;

  const _BottomActionBar({
    required this.item,
    required this.allItems,
    required this.onRefresh,
  });

  void _showScanDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return _ScanSimulatorDialog(
          item: item,
          onScanComplete: () {
            Navigator.pop(dialogContext); // Close dialog
            Navigator.pop(context, true); // Pop detail screen with "true" result
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        top: 16.0,
        bottom: 24.0,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFFAF9FE),
        border: const Border(
          top: BorderSide(color: Color(0xFFC7C4D6)),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: item.isScanned ? null : () => _showScanDialog(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3F3BBD),
                disabledBackgroundColor: const Color(0xFFE9E7ED),
                foregroundColor: Colors.white,
                disabledForegroundColor: const Color(0xFF94A3B8),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    item.isScanned ? Icons.check_circle_outline : Icons.qr_code_scanner,
                    size: 22,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    item.isScanned ? '피킹 스캔 완료' : '스캔하여 피킹 시작',
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 16),
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: const Color(0xFFE9E7ED),
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              icon: const Icon(Icons.more_horiz, color: Color(0xFF464554)),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  backgroundColor: Colors.transparent,
                  builder: (context) => OrderOptionsBottomSheet(
                    orderItems: allItems,
                    onRefresh: onRefresh,
                    orderId: '#P-2024-1015',
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ScanSimulatorDialog extends StatefulWidget {
  final OrderItemData item;
  final VoidCallback onScanComplete;

  const _ScanSimulatorDialog({
    required this.item,
    required this.onScanComplete,
  });

  @override
  State<_ScanSimulatorDialog> createState() => _ScanSimulatorDialogState();
}

class _ScanSimulatorDialogState extends State<_ScanSimulatorDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'RFID / 바코드 스캔',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A1B1F),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 160,
                  height: 160,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF4F3F8),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFC7C4D6)),
                  ),
                  child: Center(
                    child: Icon(
                      widget.item.imagePlaceholderIcon,
                      size: 64,
                      color: const Color(0xFFC7C4D6).withOpacity(0.5),
                    ),
                  ),
                ),
                AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return Positioned(
                      top: 10 + (_animationController.value * 140),
                      left: 10,
                      right: 10,
                      child: Container(
                        height: 3,
                        decoration: BoxDecoration(
                          color: const Color(0xFF5E5CE6),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF5E5CE6).withOpacity(0.5),
                              blurRadius: 4,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              '[${widget.item.brand}] ${widget.item.name}',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 15,
                color: Color(0xFF1A1B1F),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'SKU: ${widget.item.sku}',
              style: const TextStyle(
                fontSize: 13,
                color: Color(0xFF464554),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: widget.onScanComplete,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3F3BBD),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  '스캔 완료 처리',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
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
