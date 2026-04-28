import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _nameCtrl = TextEditingController(text: 'John');
  final _emailCtrl = TextEditingController(text: 'john@example.com');
  final _phoneCtrl = TextEditingController(text: '+1 234 567 8900');
  final _ageCtrl = TextEditingController(text: '28');
  final _weightCtrl = TextEditingController(text: '75');
  final _heightCtrl = TextEditingController(text: '178');
  String _selectedGender = 'Male';
  String _selectedGoal = 'Lose Weight';

  final _genders = ['Male', 'Female', 'Other'];
  final _goals = ['Lose Weight', 'Build Muscle', 'Stay Fit', 'Improve Endurance'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightBg,
      appBar: AppBar(
        backgroundColor: AppTheme.lightBg,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppTheme.textPrimary, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Edit Profile',
            style: GoogleFonts.poppins(
                color: AppTheme.textPrimary, fontWeight: FontWeight.w600, fontSize: 18)),
        actions: [
          TextButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Profile saved!'), backgroundColor: Color(0xFF22C55E)),
              );
              Navigator.pop(context);
            },
            child: Text('Save',
                style: GoogleFonts.poppins(color: AppTheme.primary, fontWeight: FontWeight.w600, fontSize: 14)),
          ),
        ],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Avatar
            Center(
              child: Stack(
                children: [
                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppTheme.primary.withOpacity(0.1),
                    ),
                    child: const Icon(Icons.person_rounded, color: AppTheme.primary, size: 50),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: AppTheme.primary,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: const Icon(Icons.camera_alt_rounded, color: Colors.white, size: 14),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),
            _sectionLabel('Personal Information'),
            const SizedBox(height: 12),
            _buildField('Full Name', _nameCtrl, Icons.person_outline),
            const SizedBox(height: 12),
            _buildField('Email', _emailCtrl, Icons.email_outlined, type: TextInputType.emailAddress),
            const SizedBox(height: 12),
            _buildField('Phone', _phoneCtrl, Icons.phone_outlined, type: TextInputType.phone),
            const SizedBox(height: 20),
            _sectionLabel('Body Metrics'),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(child: _buildField('Age', _ageCtrl, Icons.cake_outlined, type: TextInputType.number)),
                const SizedBox(width: 10),
                Expanded(child: _buildField('Weight (kg)', _weightCtrl, Icons.monitor_weight_outlined, type: TextInputType.number)),
                const SizedBox(width: 10),
                Expanded(child: _buildField('Height (cm)', _heightCtrl, Icons.height_rounded, type: TextInputType.number)),
              ],
            ),
            const SizedBox(height: 20),
            _sectionLabel('Gender'),
            const SizedBox(height: 12),
            Row(
              children: _genders.map((g) {
                final selected = _selectedGender == g;
                return Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _selectedGender = g),
                    child: Container(
                      margin: EdgeInsets.only(right: g == _genders.last ? 0 : 10),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: selected ? AppTheme.primary : Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: selected ? AppTheme.primary : AppTheme.lightBorder),
                      ),
                      alignment: Alignment.center,
                      child: Text(g,
                          style: GoogleFonts.poppins(
                              color: selected ? Colors.white : AppTheme.textPrimary,
                              fontWeight: FontWeight.w500,
                              fontSize: 13)),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            _sectionLabel('Primary Goal'),
            const SizedBox(height: 12),
            ..._goals.map((g) {
              final selected = _selectedGoal == g;
              return GestureDetector(
                onTap: () => setState(() => _selectedGoal = g),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(
                    color: selected ? AppTheme.primary.withOpacity(0.08) : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                        color: selected ? AppTheme.primary : AppTheme.lightBorder,
                        width: selected ? 1.5 : 1),
                  ),
                  child: Row(
                    children: [
                      Icon(selected ? Icons.radio_button_checked : Icons.radio_button_off,
                          color: selected ? AppTheme.primary : AppTheme.textLight, size: 20),
                      const SizedBox(width: 12),
                      Text(g,
                          style: GoogleFonts.poppins(
                              color: selected ? AppTheme.primary : AppTheme.textPrimary,
                              fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                              fontSize: 14)),
                    ],
                  ),
                ),
              );
            }),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Profile updated successfully!'), backgroundColor: Color(0xFF22C55E)),
                  );
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primary,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  elevation: 0,
                ),
                child: Text('Save Changes',
                    style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 15)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionLabel(String text) => Text(text,
      style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600, color: AppTheme.textPrimary));

  Widget _buildField(String label, TextEditingController ctrl, IconData icon,
      {TextInputType type = TextInputType.text}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500, color: AppTheme.textSecondary)),
        const SizedBox(height: 6),
        TextField(
          controller: ctrl,
          keyboardType: type,
          style: GoogleFonts.poppins(fontSize: 14, color: AppTheme.textPrimary),
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: AppTheme.textLight, size: 18),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: AppTheme.lightBorder)),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: AppTheme.lightBorder)),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: AppTheme.primary, width: 1.5)),
          ),
        ),
      ],
    );
  }
}
