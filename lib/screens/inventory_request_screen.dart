import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class InventoryRequestScreen extends StatefulWidget {
  const InventoryRequestScreen({super.key});

  @override
  State<InventoryRequestScreen> createState() => _InventoryRequestScreenState();
}

class _InventoryRequestScreenState extends State<InventoryRequestScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isStoreTransfer = true; // true: 매장 간 이동, false: 본사 발주
  String selectedProduct = '린넨 블렌드 블레이저';
  String targetLocation = '창고 B';
  final quantityController = TextEditingController(text: '0');
  final detailController = TextEditingController();

  final List<String> products = [
    '린넨 블렌드 블레이저',
    '헤리티지 스니커즈',
    '메리노 울 폴로',
  ];
  final List<String> locations = ['창고 A', '창고 B', '매장 진열'];

  @override
  void dispose() {
    quantityController.dispose();
    detailController.dispose();
    super.dispose();
  }

  void _onSubmitRequest() {
    if (_formKey.currentState!.validate()) {
      Navigator.pop(context);
      final requestType = isStoreTransfer ? '매장 간 이동' : '본사 발주';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('[$requestType] 요청서가 정상 등록되었습니다.'),
          backgroundColor: const Color(0xFFD97706),
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const _RequestAppBar(),
      body: Form(
        key: _formKey,
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 20.0, bottom: 120.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _SectionHeader(title: '요청 정보 설정'),
                  const SizedBox(height: 12),
                  _RequestTypeToggleCard(
                    isStoreTransfer: isStoreTransfer,
                    onToggleChanged: (val) => setState(() => isStoreTransfer = val),
                  ),
                  const SizedBox(height: 24),
                  const _SectionHeader(title: '대상 상품 및 수량'),
                  const SizedBox(height: 12),
                  _TargetProductSelectorCard(
                    products: products,
                    selectedProduct: selectedProduct,
                    onProductChanged: (val) => setState(() => selectedProduct = val!),
                  ),
                  const SizedBox(height: 24),
                  const _SectionHeader(title: '상세 요청 내용 입력'),
                  const SizedBox(height: 12),
                  _RequestInputsCard(
                    quantityController: quantityController,
                    detailController: detailController,
                    locations: locations,
                    targetLocation: targetLocation,
                    onLocationChanged: (val) => setState(() => targetLocation = val!),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 16,
              child: _RequestSubmitButton(onPressed: _onSubmitRequest),
            ),
          ],
        ),
      ),
    );
  }
}

// --- Sub Widgets (Each < 100 lines) ---

class _RequestAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _RequestAppBar();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      scrolledUnderElevation: 0,
      automaticallyImplyLeading: false,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF464554), size: 18),
        onPressed: () => Navigator.pop(context),
      ),
      titleSpacing: 0,
      title: const Text(
        '새 요청 작성',
        style: TextStyle(
          color: Color(0xFF0F172A),
          fontSize: 20,
          fontWeight: FontWeight.w600,
          letterSpacing: -0.2,
        ),
      ),
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Color(0xFFE2E8F0))),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        color: Color(0xFF464554),
        fontSize: 14,
        fontWeight: FontWeight.bold,
        letterSpacing: -0.1,
      ),
    );
  }
}

class _RequestTypeToggleCard extends StatelessWidget {
  final bool isStoreTransfer;
  final ValueChanged<bool> onToggleChanged;

  const _RequestTypeToggleCard({
    required this.isStoreTransfer,
    required this.onToggleChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '요청 유형',
            style: TextStyle(color: Color(0xFF464554), fontSize: 12, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: const Color(0xFFF4F3F8),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Expanded(
                  child: _buildToggleButton('매장 간 이동', isStoreTransfer, () => onToggleChanged(true)),
                ),
                Expanded(
                  child: _buildToggleButton('본사 발주 요청', !isStoreTransfer, () => onToggleChanged(false)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToggleButton(String label, bool isActive, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          boxShadow: isActive
              ? const [BoxShadow(color: Color(0x14000000), blurRadius: 2, offset: Offset(0, 2))]
              : null,
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isActive ? const Color(0xFFD97706) : const Color(0xFF464554),
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class _TargetProductSelectorCard extends StatelessWidget {
  final List<String> products;
  final String selectedProduct;
  final ValueChanged<String?> onProductChanged;

  const _TargetProductSelectorCard({
    required this.products,
    required this.selectedProduct,
    required this.onProductChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '요청 품목 선택',
            style: TextStyle(color: Color(0xFF464554), fontSize: 12, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: selectedProduct,
                isExpanded: true,
                icon: const Icon(Icons.keyboard_arrow_down, color: Color(0xFF94A3B8)),
                style: const TextStyle(color: Color(0xFF1E293B), fontSize: 14),
                onChanged: onProductChanged,
                items: products.map((String val) {
                  return DropdownMenuItem<String>(
                    value: val,
                    child: Text(val),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RequestInputsCard extends StatelessWidget {
  final TextEditingController quantityController;
  final TextEditingController detailController;
  final List<String> locations;
  final String targetLocation;
  final ValueChanged<String?> onLocationChanged;

  const _RequestInputsCard({
    required this.quantityController,
    required this.detailController,
    required this.locations,
    required this.targetLocation,
    required this.onLocationChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '요청 수량',
            style: TextStyle(color: Color(0xFF464554), fontSize: 12, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 6),
          TextFormField(
            controller: quantityController,
            keyboardType: TextInputType.number,
            validator: (v) {
              if (v!.isEmpty) return '요청 수량을 입력해주세요';
              if (int.tryParse(v) == null || int.parse(v) <= 0) return '0보다 큰 숫자만 입력 가능합니다';
              return null;
            },
            decoration: InputDecoration(
              suffixText: '개',
              suffixStyle: const TextStyle(color: Color(0xFF464554), fontWeight: FontWeight.bold),
              filled: true,
              fillColor: const Color(0xFFF8FAFC),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFFD97706))),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            '반입 목적지 배정',
            style: TextStyle(color: Color(0xFF464554), fontSize: 12, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: targetLocation,
                isExpanded: true,
                icon: const Icon(Icons.keyboard_arrow_down, color: Color(0xFF94A3B8)),
                style: const TextStyle(color: Color(0xFF1E293B), fontSize: 14),
                onChanged: onLocationChanged,
                items: locations.map((String val) {
                  return DropdownMenuItem<String>(
                    value: val,
                    child: Text(val),
                  );
                }).toList(),
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            '요청 사유 및 내용 (선택)',
            style: TextStyle(color: Color(0xFF464554), fontSize: 12, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 6),
          TextFormField(
            controller: detailController,
            maxLines: 3,
            decoration: InputDecoration(
              hintText: '상세 요청 사유를 작성하세요.',
              hintStyle: const TextStyle(color: Color(0xFFCBD5E1), fontSize: 13),
              filled: true,
              fillColor: const Color(0xFFF8FAFC),
              contentPadding: const EdgeInsets.all(12),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFFD97706))),
            ),
          ),
        ],
      ),
    );
  }
}

class _RequestSubmitButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _RequestSubmitButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFD97706).withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFD97706),
            foregroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: const Center(
            child: Text(
              '요청서 제출',
              style: TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.bold,
                letterSpacing: -0.1,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
