import 'package:flutter/material.dart';

class PhoneNumberInput extends StatelessWidget {
  final String? initialCountryCode;
  final ValueChanged<String> onChanged;
  final String? Function(String?)? validator;
  final String? labelText;
  final String? hintText;
  final TextEditingController? controller;
  final bool enabled;

  const PhoneNumberInput({
    Key? key,
    this.initialCountryCode = '27', // Default to South Africa
    required this.onChanged,
    this.validator,
    this.labelText = 'Phone Number',
    this.hintText = 'Enter phone number',
    this.controller,
    this.enabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      enabled: enabled,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        prefixIcon: Container(
          padding: const EdgeInsets.only(left: 16.0, right: 8.0, top: 14.0, bottom: 14.0),
          margin: const EdgeInsets.only(right: 8.0),
          decoration: const BoxDecoration(
            border: Border(right: BorderSide(width: 1.0, color: Colors.grey)),
          ),
          child: const Text('+27', style: TextStyle(fontSize: 16.0)),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      onChanged: (value) {
        // Format the phone number as it's being typed
        String formattedNumber = value.trim();
        // Remove any non-digit characters
        formattedNumber = formattedNumber.replaceAll(RegExp(r'[^0-9]'), '');
        // Add the country code
        if (formattedNumber.isNotEmpty) {
          formattedNumber = '+27$formattedNumber';
        }
        onChanged(formattedNumber);
      },
      validator: validator ?? (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a phone number';
        }
        // Basic validation for South African numbers (10 digits including area code)
        final phoneNumber = value.replaceAll(RegExp(r'[^0-9]'), '');
        if (phoneNumber.length < 10) {
          return 'Please enter a valid phone number';
        }
        return null;
      },
    );
  }
}
