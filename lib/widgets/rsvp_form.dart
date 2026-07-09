import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme.dart';

class RsvpForm extends StatefulWidget {
  final bool isAr;
  const RsvpForm({super.key, required this.isAr});

  @override
  State<RsvpForm> createState() => _RsvpFormState();
}

class _RsvpFormState extends State<RsvpForm> {
  final _nameCtrl  = TextEditingController();
  final _noteCtrl  = TextEditingController();
  bool _attending  = true;
  bool _submitted  = false;
  bool _loading    = false;
  String _submittedName = '';

  @override
  void dispose() {
    _nameCtrl.dispose();
    _noteCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    final name = _nameCtrl.text.trim();
    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(widget.isAr ? 'من فضلك اكتب اسمك أولاً' : 'Please enter your name first'),
          backgroundColor: AppColors.blue,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
      return;
    }
    setState(() { _loading = true; _submittedName = name; });
    Future.delayed(const Duration(milliseconds: 900), () {
      if (mounted) setState(() { _submitted = true; _loading = false; });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_submitted) return _buildThankYou();
    return _buildForm();
  }

  Widget _buildForm() {
    final isAr = widget.isAr;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: AppColors.skyMid.withOpacity(0.4), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: AppColors.blue.withOpacity(0.12),
            blurRadius: 32, offset: const Offset(0, 14),
          ),
        ],
      ),
      padding: const EdgeInsets.all(26),
      child: Column(
        crossAxisAlignment:  CrossAxisAlignment.start,
        children: [
          // "we can't wait to see you"
          Center(
            child: Text(
              "we can't wait to see you",
              style: GoogleFonts.caveat(
                fontSize: 26, fontWeight: FontWeight.w700, color: AppColors.blue,
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Name field
          _fieldLabel(isAr ? 'اسمك' : 'Your name', isAr),
          const SizedBox(height: 9),
          _textField(
            controller: _nameCtrl,
            hint: isAr ? 'اكتب اسمك هنا...' : 'Write your name...',
            isAr: isAr,
          ),
          const SizedBox(height: 20),

          // Attend buttons
          _fieldLabel(isAr ? 'هل ستحضر؟' : 'Will you attend?', isAr),
          const SizedBox(height: 9),
          _attendRow(isAr),
          const SizedBox(height: 20),

          // Note field
          _fieldLabel(isAr ? 'رسالة تهنئة لجان 💌' : 'A note for Jan 💌', isAr),
          const SizedBox(height: 9),
          _textField(
            controller: _noteCtrl,
            hint: isAr ? 'اكتب تهنئتك هنا...' : 'Write your message here...',
            isAr: isAr,
            maxLines: 4,
          ),
          const SizedBox(height: 22),

          // Send button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _loading ? null : _submit,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.blue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                elevation: 4,
                shadowColor: AppColors.blue.withOpacity(0.4),
              ),
              child: _loading
                ? const SizedBox(
                    width: 22, height: 22,
                    child: CircularProgressIndicator(strokeWidth: 2.5, color: Colors.white),
                  )
                : Text(
                    isAr ? 'إرسال 💙' : 'Send 💙',
                    style: TextStyle(
                      fontFamily: isAr ? null : null,
                      fontSize: 16, fontWeight: FontWeight.w700,
                    ),
                  ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _fieldLabel(String text, bool isAr) => Text(
    text,
    textAlign: isAr ? TextAlign.right : TextAlign.left,
    textDirection: isAr ? TextDirection.rtl : TextDirection.ltr,
    style: TextStyle(
      fontSize: isAr ? 14.5 : 13.5,
      fontWeight: FontWeight.w600,
      color: AppColors.ink,
    ),
  );

  Widget _textField({
    required TextEditingController controller,
    required String hint,
    required bool isAr,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      textAlign: isAr ? TextAlign.right : TextAlign.left,
      textDirection: isAr ? TextDirection.rtl : TextDirection.ltr,
      style: TextStyle(fontSize: 14.5, color: AppColors.ink),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: AppColors.inkLight.withOpacity(0.5), fontSize: 14),
        filled: true,
        fillColor: const Color(0xFFFDFAF6),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: AppColors.tanPale, width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: AppColors.tanPale, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: AppColors.skyMid, width: 1.5),
        ),
      ),
    );
  }

  Widget _attendRow(bool isAr) {
    return Row(
      children: [
        Expanded(child: _attendBtn(isAr ? 'أيوه، هكون هناك! 🎉' : 'Yes, with joy! 🎉', true, isAr)),
        const SizedBox(width: 10),
        Expanded(child: _attendBtn(isAr ? 'للأسف مش قادر' : 'Sadly, no', false, isAr)),
      ],
    );
  }

  Widget _attendBtn(String label, bool value, bool isAr) {
    final isActive = _attending == value;
    return GestureDetector(
      onTap: () => setState(() => _attending = value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          color: isActive ? AppColors.sky : const Color(0xFFFDFAF6),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isActive ? AppColors.skyMid : AppColors.tanPale,
            width: 1.5,
          ),
          boxShadow: isActive ? [
            BoxShadow(
              color: AppColors.blue.withOpacity(0.18),
              blurRadius: 10, offset: const Offset(0, 4),
            )
          ] : [],
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: isAr ? 13 : 13.5,
            fontWeight: FontWeight.w600,
            color: isActive ? AppColors.blue : AppColors.inkLight,
          ),
        ),
      ),
    );
  }

  Widget _buildThankYou() {
    final isAr = widget.isAr;
    final titleText = isAr ? 'شكراً $_submittedName! 💙' : 'Thank you, $_submittedName! 💙';
    final bodyText = _attending
        ? (isAr
            ? 'وصلت رسالتك وفرّحت قلبنا 🎉\nفي انتظار فرحتنا بيك يوم سبوع كيرلس!'
            : 'Your message reached us and filled our hearts 🎉\nWe cannot wait to celebrate with you!')
        : (isAr
            ? 'وصلت رسالتك 💙\nسنشتاق لكم، ونحمل لكم المحبة دائماً.'
            : 'Your message reached us 💙\nWe will miss you and always hold you in our hearts.');

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: AppColors.skyMid.withOpacity(0.4), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: AppColors.blue.withOpacity(0.12),
            blurRadius: 32, offset: const Offset(0, 14),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 44, horizontal: 26),
      child: Column(
        children: [
          const Text('🐻', style: TextStyle(fontSize: 56))
              .animate().scale(begin: const Offset(0.5, 0.5), curve: Curves.elasticOut, duration: 700.ms),
          const SizedBox(height: 14),
          Text(
            titleText,
            textDirection: isAr ? TextDirection.rtl : TextDirection.ltr,
            style: isAr
                ? TextStyle(fontFamily: 'Aref Ruqaa', fontSize: 28, color: AppColors.blue, fontWeight: FontWeight.w700)
                : GoogleFonts.cormorantGaramond(fontSize: 26, color: AppColors.blue, fontStyle: FontStyle.italic, fontWeight: FontWeight.w600),
          ).animate().fadeIn(delay: 100.ms).slideY(begin: 0.3, end: 0),
          const SizedBox(height: 12),
          Text(
            bodyText,
            textDirection: isAr ? TextDirection.rtl : TextDirection.ltr,
            style: TextStyle(
              fontSize: 15.5, color: AppColors.inkLight, height: 1.9,
            ),
          ).animate().fadeIn(delay: 200.ms),
          const SizedBox(height: 20),
          const Text('🎈  🎀  🎈', style: TextStyle(fontSize: 30, letterSpacing: 6))
              .animate(delay: 300.ms).scale(begin: const Offset(0.5, 0.5), curve: Curves.elasticOut),
        ],
      ),
    ).animate().scale(
      begin: const Offset(0.7, 0.7),
      curve: Curves.elasticOut,
      duration: 600.ms,
    );
  }
}
