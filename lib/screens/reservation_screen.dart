import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/custom_app_bar.dart';

class ReservationScreen extends StatefulWidget {
  const ReservationScreen({super.key});

  @override
  State<ReservationScreen> createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen> {
  int? selectedAddress;
  int? selectedTariff;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  static const _addresses = [
    {
      'active': 'assets/reservaation/adress-container1.png',
      'inactive': 'assets/reservaation/adress-container1-off.png',
    },
    {
      'active': 'assets/reservaation/adress-container2.png',
      'inactive': 'assets/reservaation/adress-container2-off.png',
    },
    {
      'active': 'assets/reservaation/adress-container3.png',
      'inactive': 'assets/reservaation/adress-container3-off.png',
    },
  ];

  static const _tariffs = [
    {
      'active': 'assets/prices/1hour.png',
      'inactive': 'assets/reservaation/1hour-off.png',
      'price': '150',
    },
    {
      'active': 'assets/prices/3hours.png',
      'inactive': 'assets/reservaation/3hours-off.png',
      'price': '400',
    },
    {
      'active': 'assets/prices/5hours.png',
      'inactive': 'assets/reservaation/5hours-off.png',
      'price': '625',
    },
    {
      'active': 'assets/prices/all-day.png',
      'inactive': 'assets/reservaation/all-day-off.png',
      'price': '800',
    },
    {
      'active': 'assets/prices/all-night.png',
      'inactive': 'assets/reservaation/all-night-off.png',
      'price': '400',
    },
    {
      'active': 'assets/prices/one-hour-ps.png',
      'inactive': 'assets/reservaation/one-hour-ps-off.png',
      'price': '150',
    },
  ];

  bool get _isPhoneValid {
    final digits = phoneController.text.replaceAll(RegExp(r'\D'), '');
    return digits.length >= 10;
  }

  bool get _isFormComplete =>
      selectedAddress != null &&
      selectedTariff != null &&
      selectedDate != null &&
      selectedTime != null &&
      nameController.text.trim().isNotEmpty &&
      _isPhoneValid;

  void _onReservationPressed() {
    Navigator.of(context).pop(true);
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: customAppBar(context, title: 'Reservations'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Address cards
            for (int i = 0; i < _addresses.length; i++)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedAddress = i;
                      selectedTariff = null;
                    });
                  },
                  child: Image.asset(
                    selectedAddress == i
                        ? _addresses[i]['active']!
                        : _addresses[i]['inactive']!,
                    width: double.infinity,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),

            // Form + tariffs (visible after address selection)
            if (selectedAddress != null) ...[
              const SizedBox(height: 8),
              // Name
              Text(
                'Name:',
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF1A1A1A),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: nameController,
                onChanged: (_) => setState(() {}),
                decoration: InputDecoration(
                  hintText: 'Name',
                  hintStyle: GoogleFonts.inter(color: Colors.grey[400]),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFFFFCC00), width: 2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Phone number
              Text(
                'Phone number:',
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF1A1A1A),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: phoneController,
                onChanged: (_) => setState(() {}),
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  _PhoneInputFormatter(),
                ],
                decoration: InputDecoration(
                  hintText: '+49 XXX XXXXXXX',
                  hintStyle: GoogleFonts.inter(color: Colors.grey[400]),
                  prefixIcon: const Icon(Icons.phone, color: Colors.grey),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  errorText: phoneController.text.isNotEmpty && !_isPhoneValid
                      ? 'Enter at least 10 digits'
                      : null,
                  errorStyle: GoogleFonts.inter(fontSize: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFFFFCC00), width: 2),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.red),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.red, width: 2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Date
              Text(
                'Date:',
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF1A1A1A),
                ),
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: selectedDate ?? DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                    builder: (context, child) {
                      return Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: const ColorScheme.light(
                            primary: Color(0xFFFFCC00),
                            onPrimary: Colors.black,
                          ),
                        ),
                        child: child!,
                      );
                    },
                  );
                  if (date != null) {
                    setState(() => selectedDate = date);
                  }
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: Text(
                    selectedDate != null
                        ? '${selectedDate!.day.toString().padLeft(2, '0')}.${selectedDate!.month.toString().padLeft(2, '0')}.${selectedDate!.year}'
                        : 'Select date',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      color: selectedDate != null ? const Color(0xFF1A1A1A) : Colors.grey[400],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Time
              Text(
                'Time:',
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF1A1A1A),
                ),
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () async {
                  final time = await showTimePicker(
                    context: context,
                    initialTime: selectedTime ?? TimeOfDay.now(),
                    builder: (context, child) {
                      return Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: const ColorScheme.light(
                            primary: Color(0xFFFFCC00),
                            onPrimary: Colors.black,
                          ),
                        ),
                        child: child!,
                      );
                    },
                  );
                  if (time != null) {
                    setState(() => selectedTime = time);
                  }
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: Text(
                    selectedTime != null
                        ? '${selectedTime!.hour.toString().padLeft(2, '0')}:${selectedTime!.minute.toString().padLeft(2, '0')}'
                        : 'Select time',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      color: selectedTime != null ? const Color(0xFF1A1A1A) : Colors.grey[400],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Tariff
              Text(
                'Tariff:',
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF1A1A1A),
                ),
              ),
              const SizedBox(height: 12),
              // Tariff grid
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.85,
                ),
                itemCount: _tariffs.length,
                itemBuilder: (context, index) {
                  return _buildTariffCard(index);
                },
              ),
              const SizedBox(height: 24),
              // Reservations button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _isFormComplete ? _onReservationPressed : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isFormComplete
                        ? const Color(0xFFFFCC00)
                        : Colors.grey[400],
                    foregroundColor: _isFormComplete
                        ? Colors.black
                        : Colors.white,
                    disabledBackgroundColor: Colors.grey[400],
                    disabledForegroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(26),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'Reservation',
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildTariffCard(int index) {
    final isSelected = selectedTariff == index;
    final tariff = _tariffs[index];

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTariff = index;
        });
      },
      child: isSelected
          ? Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    tariff['active']!,
                    fit: BoxFit.contain,
                  ),
                ),
                Positioned.fill(
                  child: Align(
                    alignment: const Alignment(0, 0.65),
                    // child: Text(
                    //   tariff['price']!,
                    //   style: GoogleFonts.inter(
                    //     fontSize: 40,
                    //     fontWeight: FontWeight.w900,
                    //     fontStyle: FontStyle.italic,
                    //     color: const Color(0xFF1A1A1A),
                    //   ),
                    // ),
                  ),
                ),
              ],
            )
          : Image.asset(
              tariff['inactive']!,
              fit: BoxFit.contain,
            ),
    );
  }
}

class _PhoneInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digits = newValue.text.replaceAll(RegExp(r'\D'), '');
    final buffer = StringBuffer('+');

    for (int i = 0; i < digits.length && i < 15; i++) {
      if (i == 2 || i == 5 || i == 8) {
        buffer.write(' ');
      }
      buffer.write(digits[i]);
    }

    final formatted = buffer.toString();
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
