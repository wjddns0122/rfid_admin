import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class InventoryRegisterScreen extends StatefulWidget {
  const InventoryRegisterScreen({super.key});

  @override
  State<InventoryRegisterScreen> createState() => _InventoryRegisterScreenState();
}

class _InventoryRegisterScreenState extends State<InventoryRegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final skuController = TextEditingController();
  final quantityController = TextEditingController(text: '0');
  String selectedCategory = 'TOP';
  String selectedLocation = '창고 A';

  final List<String> categories = ['TOP', 'BOTTOM', 'JACKET', 'SHOES', 'ACC'];
  final List<String> locations = ['창고 A', '창고 B', '매장 진열'];

  @override
  void dispose() {
    nameController.dispose();
    skuController.dispose();
    quantityController.dispose();
    super.dispose();
  }

  void _onRegister() {
    if (_formKey.currentState!.validate()) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('신규 품목이 등록되었습니다: ${nameController.text}'),
          backgroundColor: const Color(0xFF5E5CE6),
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const _RegisterAppBar(),
      body: Form(
        key: _formKey,
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 20.0, bottom: 120.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _FormSectionTitle(title: '기본 정보'),
                  const SizedBox(height: 12),
                  _RegisterFormInputs(
                    nameController: nameController,
                    skuController: skuController,
                    quantityController: quantityController,
                  ),
                  const SizedBox(height: 24),
                  _FormSectionTitle(title: '카테고리 및 위치'),
                  const SizedBox(height: 12),
                  _DropdownSelectorCard(
                    categories: categories,
                    locations: locations,
                    selectedCategory: selectedCategory,
                    selectedLocation: selectedLocation,
                    onCategoryChanged: (val) => setState(() => selectedCategory = val!),
                    onLocationChanged: (val) => setState(() => selectedLocation = val!),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 16,
              child: _RegisterSubmitButton(onPressed: _onRegister),
            ),
          ],
        ),
      ),
    );
  }
}

// --- Sub Widgets (Each < 100 lines) ---

class _RegisterAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _RegisterAppBar();

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
        '신규 품목 등록',
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

class _FormSectionTitle extends StatelessWidget {
  final String title;
  const _FormSectionTitle({required this.title});

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

class _RegisterFormInputs extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController skuController;
  final TextEditingController quantityController;

  const _RegisterFormInputs({
    required this.nameController,
    required this.skuController,
    required this.quantityController,
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
        children: [
          _buildTextField(
            controller: nameController,
            label: '품목명',
            hint: '예: 옥스퍼드 코튼 셔츠',
            validator: (v) => v!.isEmpty ? '품목명을 입력해주세요' : null,
          ),
          const SizedBox(height: 16),
          _buildTextField(
            controller: skuController,
            label: 'SKU 코드',
            hint: '예: SH-2026-WT-001',
            validator: (v) => v!.isEmpty ? 'SKU 코드를 입력해주세요' : null,
          ),
          const SizedBox(height: 16),
          _buildTextField(
            controller: quantityController,
            label: '초기 재고량',
            hint: '0',
            keyboardType: TextInputType.number,
            validator: (v) {
              if (v!.isEmpty) return '초기 수량을 입력해주세요';
              if (int.tryParse(v) == null) return '숫자만 입력 가능합니다';
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF464554),
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          validator: validator,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Color(0xFFCBD5E1), fontSize: 14),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            filled: true,
            fillColor: const Color(0xFFF8FAFC),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFF5E5CE6)),
            ),
          ),
          style: const TextStyle(color: Color(0xFF1E293B), fontSize: 14),
        ),
      ],
    );
  }
}

class _DropdownSelectorCard extends StatelessWidget {
  final List<String> categories;
  final List<String> locations;
  final String selectedCategory;
  final String selectedLocation;
  final ValueChanged<String?> onCategoryChanged;
  final ValueChanged<String?> onLocationChanged;

  const _DropdownSelectorCard({
    required this.categories,
    required this.locations,
    required this.selectedCategory,
    required this.selectedLocation,
    required this.onCategoryChanged,
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
        children: [
          _buildDropdown(
            label: '카테고리 선택',
            value: selectedCategory,
            items: categories,
            onChanged: onCategoryChanged,
          ),
          const SizedBox(height: 16),
          _buildDropdown(
            label: '초기 위치 배정',
            value: selectedLocation,
            items: locations,
            onChanged: onLocationChanged,
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown({
    required String label,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF464554),
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
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
              value: value,
              isExpanded: true,
              icon: const Icon(Icons.keyboard_arrow_down, color: Color(0xFF94A3B8)),
              style: const TextStyle(color: Color(0xFF1E293B), fontSize: 14),
              onChanged: onChanged,
              items: items.map((String val) {
                return DropdownMenuItem<String>(
                  value: val,
                  child: Text(val),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}

class _RegisterSubmitButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _RegisterSubmitButton({required this.onPressed});

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
              color: const Color(0xFF5E5CE6).withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF5E5CE6),
            foregroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: const Center(
            child: Text(
              '등록 완료',
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
