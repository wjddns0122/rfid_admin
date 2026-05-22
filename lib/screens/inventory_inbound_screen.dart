import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class InventoryInboundScreen extends StatefulWidget {
  const InventoryInboundScreen({super.key});

  @override
  State<InventoryInboundScreen> createState() => _InventoryInboundScreenState();
}

class _InventoryInboundScreenState extends State<InventoryInboundScreen> {
  final _formKey = GlobalKey<FormState>();
  String selectedProduct = '린넨 블렌드 블레이저';
  String selectedLocation = '창고 A';
  final quantityController = TextEditingController(text: '0');
  final memoController = TextEditingController();

  final List<String> products = [
    '린넨 블렌드 블레이저',
    '헤리티지 스니커즈',
    '메리노 울 폴로',
  ];
  final List<String> locations = ['창고 A', '창고 B', '매장 진열'];

  @override
  void dispose() {
    quantityController.dispose();
    memoController.dispose();
    super.dispose();
  }

  void _onInbound() {
    if (_formKey.currentState!.validate()) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$selectedProduct에 ${quantityController.text}개 입고 완료되었습니다.'),
          backgroundColor: const Color(0xFF3F3BBD),
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const _InboundAppBar(),
      body: Form(
        key: _formKey,
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 20.0, bottom: 120.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _SectionHeader(title: '대상 상품 및 입고 정보'),
                  const SizedBox(height: 12),
                  _ProductSelectorCard(
                    products: products,
                    selectedProduct: selectedProduct,
                    onProductChanged: (val) => setState(() => selectedProduct = val!),
                  ),
                  const SizedBox(height: 24),
                  const _SectionHeader(title: '입고 상세 입력'),
                  const SizedBox(height: 12),
                  _InboundInputsCard(
                    quantityController: quantityController,
                    memoController: memoController,
                    locations: locations,
                    selectedLocation: selectedLocation,
                    onLocationChanged: (val) => setState(() => selectedLocation = val),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 16,
              child: _InboundSubmitButton(onPressed: _onInbound),
            ),
          ],
        ),
      ),
    );
  }
}

// --- Sub Widgets (Each < 100 lines) ---

class _InboundAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _InboundAppBar();

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
        '재고 입고',
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

class _ProductSelectorCard extends StatelessWidget {
  final List<String> products;
  final String selectedProduct;
  final ValueChanged<String?> onProductChanged;

  const _ProductSelectorCard({
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
            '입고 대상 품목 선택',
            style: TextStyle(
              color: Color(0xFF464554),
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
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

class _InboundInputsCard extends StatelessWidget {
  final TextEditingController quantityController;
  final TextEditingController memoController;
  final List<String> locations;
  final String selectedLocation;
  final ValueChanged<String> onLocationChanged;

  const _InboundInputsCard({
    required this.quantityController,
    required this.memoController,
    required this.locations,
    required this.selectedLocation,
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
            '입고 수량',
            style: TextStyle(color: Color(0xFF464554), fontSize: 12, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 6),
          TextFormField(
            controller: quantityController,
            keyboardType: TextInputType.number,
            validator: (v) {
              if (v!.isEmpty) return '입고 수량을 입력해주세요';
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
              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFF3F3BBD))),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            '보관 위치 배정',
            style: TextStyle(color: Color(0xFF464554), fontSize: 12, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          Row(
            children: locations.map((loc) {
              final isSelected = selectedLocation == loc;
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 6.0),
                  child: InkWell(
                    onTap: () => onLocationChanged(loc),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: isSelected ? const Color(0xFFEEF2FF) : const Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: isSelected ? const Color(0xFF3F3BBD) : const Color(0xFFE2E8F0),
                          width: isSelected ? 1.5 : 1.0,
                        ),
                      ),
                      child: Text(
                        loc,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: isSelected ? const Color(0xFF3F3BBD) : const Color(0xFF464554),
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
          const Text(
            '입고 사유/메모 (선택)',
            style: TextStyle(color: Color(0xFF464554), fontSize: 12, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 6),
          TextFormField(
            controller: memoController,
            maxLines: 3,
            decoration: InputDecoration(
              hintText: '입고 메모를 입력하세요 (예: 본사 5차 정기 입고 물량)',
              hintStyle: const TextStyle(color: Color(0xFFCBD5E1), fontSize: 13),
              filled: true,
              fillColor: const Color(0xFFF8FAFC),
              contentPadding: const EdgeInsets.all(12),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFF3F3BBD))),
            ),
          ),
        ],
      ),
    );
  }
}

class _InboundSubmitButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _InboundSubmitButton({required this.onPressed});

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
              color: const Color(0xFF3F3BBD).withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF3F3BBD),
            foregroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: const Center(
            child: Text(
              '입고 완료',
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
