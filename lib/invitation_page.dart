import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'theme.dart';
import 'widgets/animated_image.dart';
import 'widgets/bunting_painter.dart';
import 'widgets/countdown_widget.dart';
import 'widgets/rsvp_form.dart';

class InvitationPage extends StatefulWidget {
  const InvitationPage({super.key});

  @override
  State<InvitationPage> createState() => _InvitationPageState();
}

class _InvitationPageState extends State<InvitationPage> {
  bool _isAr = true;
  final _scrollCtrl = ScrollController();

  @override
  void dispose() {
    _scrollCtrl.dispose();
    super.dispose();
  }

  void _toggleLang() => setState(() => _isAr = !_isAr);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: _isAr ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: AppColors.cream,
        body: Stack(
          children: [
            CustomScrollView(
              controller: _scrollCtrl,
              slivers: [
                SliverToBoxAdapter(child: _HeroSection(isAr: _isAr)),
                SliverToBoxAdapter(child: _NameSection(isAr: _isAr)),
                SliverToBoxAdapter(child: _DateSection(isAr: _isAr)),
                SliverToBoxAdapter(child: _DetailsSection(isAr: _isAr)),
                SliverToBoxAdapter(child: _NoteSection(isAr: _isAr)),
                SliverToBoxAdapter(child: _RsvpSection(isAr: _isAr)),
                SliverToBoxAdapter(child: _FooterSection(isAr: _isAr)),
              ],
            ),
            // Top bar
            _TopBar(isAr: _isAr, onToggle: _toggleLang),
          ],
        ),
      ),
    );
  }
}

// ──────────────────────────────────────────────
//  TOP BAR
// ──────────────────────────────────────────────
class _TopBar extends StatelessWidget {
  final bool isAr;
  final VoidCallback onToggle;
  const _TopBar({required this.isAr, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 13),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Logo pill
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
              decoration: BoxDecoration(
                color: AppColors.cream.withOpacity(0.92),
                borderRadius: BorderRadius.circular(999),
                border: Border.all(color: AppColors.tanPale),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.child_care, color: AppColors.tan, size: 18),
                  const SizedBox(width: 6),
                  Text(
                    isAr ? 'جان' : 'Jan',
                    style: isAr
                        ? const TextStyle(fontFamily: 'Aref Ruqaa', fontSize: 17, fontWeight: FontWeight.w700, color: AppColors.ink)
                        : GoogleFonts.jost(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.ink),
                  ),
                ],
              ),
            ),
            // Lang toggle
            GestureDetector(
              onTap: onToggle,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 7),
                decoration: BoxDecoration(
                  color: AppColors.cream.withOpacity(0.92),
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(color: AppColors.tan),
                ),
                child: Text(
                  isAr ? 'English' : 'عربي',
                  style: GoogleFonts.jost(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.ink),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ──────────────────────────────────────────────
//  HERO SECTION
// ──────────────────────────────────────────────
class _HeroSection extends StatelessWidget {
  final bool isAr;
  const _HeroSection({required this.isAr});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFD0EAFB), AppColors.sky, Color(0xFFE8F5FB), AppColors.cream],
          stops: [0, 0.5, 0.75, 1],
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 90),
          // Side balloons
          Stack(
            alignment: Alignment.topCenter,
            children: [
              // Left balloon
              Positioned(
                left: 0, top: w * 0.05,
                child: FloatingImage(
                  asset: 'assets/images/balloons.png',
                  width: w * 0.17,
                  duration: const Duration(seconds: 5),
                ),
              ),
              // Right balloon
              Positioned(
                right: 0, top: w * 0.03,
                child: FloatingImage(
                  asset: 'assets/images/balloons.png',
                  width: w * 0.14,
                  duration: const Duration(seconds: 6),
                  offsetY: 10,
                ),
              ),
              // Bear centered
              Center(
                child: FloatingImage(
                  asset: 'assets/images/bear.png',
                  width: w.clamp(220.0, 320.0),
                  duration: const Duration(milliseconds: 5500),
                  rotationDeg: 0.8,
                ),
              ),
              // Transparent spacer for the row
              SizedBox(height: w.clamp(240.0, 340.0)),
            ],
          ),
          // Text content
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: Column(
              children: [
                Text(
                  isAr ? 'أهلاً بنجمنا الصغير' : "we can't wait to see you",
                  textAlign: TextAlign.center,
                  style: isAr
                      ? const TextStyle(fontFamily: 'Aref Ruqaa', fontSize: 32, fontWeight: FontWeight.w700, color: AppColors.ink)
                      : GoogleFonts.caveat(fontSize: 38, fontWeight: FontWeight.w700, color: AppColors.ink),
                ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.3, end: 0),
                const SizedBox(height: 8),
                Text(
                  isAr ? 'جان · سبوع ٢٠٢٦' : 'Jan · Sebou 2026',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.jost(
                    fontSize: 13, letterSpacing: 1.5, color: AppColors.blue,
                    fontWeight: FontWeight.w500,
                  ),
                ).animate().fadeIn(delay: 300.ms),
                const SizedBox(height: 10),
                Text(
                  isAr ? 'ندعوكم لمشاركتنا أجمل لحظة في حياتنا' : 'Join us to celebrate the most beautiful moment',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15, color: AppColors.inkLight, height: 1.85),
                ).animate().fadeIn(delay: 400.ms),
                const SizedBox(height: 18),
                // Bunting
                SwayingWidget(child: BuntingWidget(width: (w * 0.82).clamp(0, 310))),
                const SizedBox(height: 14),
                // Scroll cue
                Column(
                  children: [
                    Text(
                      isAr ? 'اكتشفوا المزيد' : 'Scroll to explore',
                      style: const TextStyle(fontSize: 12, color: AppColors.blue,),
                    ),
                    const Icon(Icons.keyboard_arrow_down, color: AppColors.blue, size: 20),
                  ],
                ).animate(onPlay: (c) => c.repeat(reverse: true))
                    .moveY(begin: 0, end: 6, duration: 2500.ms, curve: Curves.easeInOut),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Wave
          ClipPath(
            clipper: _WaveClipper(),
            child: Container(height: 60, color: AppColors.cream),
          ),
        ],
      ),
    );
  }
}

class _WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, size.height * 0.5);
    path.quadraticBezierTo(size.width * 0.25, 0, size.width * 0.5, size.height * 0.5);
    path.quadraticBezierTo(size.width * 0.75, size.height, size.width, size.height * 0.5);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }
  @override bool shouldReclip(covariant CustomClipper<Path> _) => false;
}

// ──────────────────────────────────────────────
//  NAME SECTION
// ──────────────────────────────────────────────
class _NameSection extends StatelessWidget {
  final bool isAr;
  const _NameSection({required this.isAr});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return Container(
      color: AppColors.cream,
      padding: const EdgeInsets.fromLTRB(22, 44, 22, 36),
      child: Stack(
        children: [
          // BOY blocks bottom left
          Positioned(
            bottom: 0,
            left: isAr ? null : 0,
            right: isAr ? 0 : null,
            child: Image.asset('assets/images/blocks.png',
              width: (w * 0.18).clamp(70.0, 95.0), fit: BoxFit.contain,
            ).animate(onPlay: (c) => c.repeat(reverse: true))
              .rotate(begin: -0.06, end: 0.06, duration: 5.seconds, curve: Curves.easeInOut),
          ),
          Column(
            children: [
              Text(
                isAr ? 'نجمنا الجديد' : 'Our New Star',
                style: GoogleFonts.jost(
                  fontSize: 11,  fontWeight: FontWeight.w700,
                  color: AppColors.blueLight,
                ),
              ).animate().fadeIn(delay: 100.ms),
              const SizedBox(height: 10),
              Text(
                isAr ? 'جان' : 'Jan',
                style: isAr
                    ? const TextStyle(fontFamily: 'Aref Ruqaa', fontSize: 82, fontWeight: FontWeight.w700, color: AppColors.ink, height: 0.95)
                    : GoogleFonts.cormorantGaramond(fontSize: 88, fontStyle: FontStyle.italic, fontWeight: FontWeight.w600, color: AppColors.ink, height: 0.95),
              ).animate().fadeIn(delay: 150.ms).scale(begin: const Offset(0.9, 0.9)),
              const SizedBox(height: 8),
              Text(
                isAr ? 'سبوع نجمنا الصغير الحبيب' : 'Celebrating Our Precious Little Star',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15, color: AppColors.inkLight),
              ).animate().fadeIn(delay: 200.ms),
              const SizedBox(height: 16),
              // Star trio
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TwinklingImage(asset: 'assets/images/star.png', size: 28),
                  const SizedBox(width: 16),
                  TwinklingImage(asset: 'assets/images/star.png', size: 38, delay: 1200.ms),
                  const SizedBox(width: 16),
                  TwinklingImage(asset: 'assets/images/star.png', size: 28, delay: 2400.ms),
                ],
              ).animate().fadeIn(delay: 300.ms),
            ],
          ),
        ],
      ),
    );
  }
}

// ──────────────────────────────────────────────
//  DATE SECTION
// ──────────────────────────────────────────────
class _DateSection extends StatelessWidget {
  final bool isAr;
  const _DateSection({required this.isAr});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return Container(
      color: const Color(0xFFF5EDD8),
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 22),
      child: Stack(
        children: [
          // Floating balloon top-right
          Positioned(
            top: 12, right: isAr ? null : 0, left: isAr ? 0 : null,
            child: FloatingImage(asset: 'assets/images/balloons.png', width: (w * 0.15).clamp(60.0, 80.0)),
          ),
          Column(
            children: [
              Text(
                isAr ? 'احفظوا الموعد' : 'Save the Date',
                style: GoogleFonts.jost(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.blueLight),
              ),
              const SizedBox(height: 10),
              Text(
                isAr ? 'العد التنازلي لفرحتنا' : 'Counting Down to the Celebration',
                textAlign: TextAlign.center,
                style: isAr
                    ? const TextStyle(fontFamily: 'Aref Ruqaa', fontSize: 30, fontWeight: FontWeight.w700, color: AppColors.ink)
                    : GoogleFonts.cormorantGaramond(fontSize: 36, fontStyle: FontStyle.italic, fontWeight: FontWeight.w600, color: AppColors.ink),
              ),
              const SizedBox(height: 22),
              // Date card
              Container(
                constraints: const BoxConstraints(maxWidth: 440),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: AppColors.tanPale, width: 1.5),
                  boxShadow: [BoxShadow(color: AppColors.ink.withOpacity(0.12), blurRadius: 20, offset: const Offset(0, 8))],
                ),
                child: IntrinsicHeight(
                  child: Row(
                    children: [
                      _dateCol(isAr ? 'اليوم' : 'Day', '25', isAr ? 'الأربعاء' : 'Wednesday', isAr, left: true),
                      const VerticalDivider(color: Color(0xFFEDD9AA), width: 1.5, thickness: 1.5),
                      _dateCol(isAr ? 'الشهر' : 'Month', isAr ? 'نوفمبر' : 'Nov', '2026', isAr, isSmallVal: true),
                      const VerticalDivider(color: Color(0xFFEDD9AA), width: 1.5, thickness: 1.5),
                      _dateCol(isAr ? 'المكان' : 'Venue', isAr ? 'الميرلاند' : 'Merry land', isAr ? 'أسيوط' : 'Assiut', isAr, isSmallVal: true),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 22),
              // Countdown
              CountdownWidget(
                targetDate: DateTime(2026, 11, 25),
                isAr: isAr,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _dateCol(String label, String val, String sub, bool isAr,
      {bool left = false, bool isSmallVal = false}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
        child: Column(
          children: [
            Text(label, style: GoogleFonts.jost(fontSize: 10, letterSpacing: 2, fontWeight: FontWeight.w700, color: AppColors.blueLight)),
            const SizedBox(height: 7),
            Text(val,
              textAlign: TextAlign.center,
              style: isSmallVal
                  ? TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.blue)
                  : GoogleFonts.cormorantGaramond(fontSize: 36, fontWeight: FontWeight.w600, color: AppColors.ink),
            ),
            const SizedBox(height: 4),
            Text(sub, style: TextStyle(fontSize: 11, color: AppColors.blueLight)),
          ],
        ),
      ),
    );
  }
}

// ──────────────────────────────────────────────
//  DETAILS SECTION
// ──────────────────────────────────────────────
class _DetailsSection extends StatelessWidget {
  final bool isAr;
  const _DetailsSection({required this.isAr});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 22),
      child: Column(
        children: [
          Text(
            isAr ? 'محطات رحلتنا' : 'Celebration Details',
            style: GoogleFonts.jost(fontSize: 11, letterSpacing: 3.5, fontWeight: FontWeight.w700, color: AppColors.blueLight),
          ),
          const SizedBox(height: 10),
          Text(
            isAr ? 'تفاصيل الاحتفال' : 'Details',
            textAlign: TextAlign.center,
            style: isAr
                ? const TextStyle(fontFamily: 'Aref Ruqaa', fontSize: 30, fontWeight: FontWeight.w700, color: AppColors.ink)
                : GoogleFonts.cormorantGaramond(fontSize: 36, fontStyle: FontStyle.italic, fontWeight: FontWeight.w600, color: AppColors.ink),
          ),
          const SizedBox(height: 22),
          _stopCard('📅', isAr ? 'التاريخ والوقت' : 'Date & Time',
              isAr ? 'الأربعاء ٢٥ نوفمبر ٢٠٢٦\nالموعد الدقيق يُعلن قريباً' : 'Wednesday, Nov 25, 2026\nExact time to be announced',
              isAr),
          _starTrail(),
          _stopCardWithMap('📍', isAr ? 'مكان الاحتفال' : 'Venue',
              isAr ? 'قاعة الميرلاند، أسيوط' : 'Merry Land, Assiut',
              isAr),
          _starTrail(),
          _stopCard('🎁', isAr ? 'هديتكم' : 'Your Gift',
              isAr ? 'حضوركم وحبكم لجان هو أجمل هدية تسعدنا' : 'Your presence and love is the most beautiful gift',
              isAr),
        ],
      ),
    );
  }

  Widget _stopCard(String icon, String title, String body, bool isAr) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 500),
      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFFDFAF6),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.tanPale, width: 1),
        boxShadow: [BoxShadow(color: AppColors.ink.withOpacity(0.1), blurRadius: 16, offset: const Offset(0, 5))],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(icon, style: const TextStyle(fontSize: 26)),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: isAr ? 18 : 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.ink,
                    fontFamily: isAr ? 'Aref Ruqaa' : null,
                  ),
                ),
                const SizedBox(height: 4),
                Text(body,
                  textAlign: TextAlign.start,
                  style: const TextStyle(fontSize: 13, color: AppColors.inkLight, height: 1.7),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _stopCardWithMap(String icon, String title, String body, bool isAr) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 500),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFFDFAF6),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.tanPale, width: 1),
        boxShadow: [BoxShadow(color: AppColors.ink.withOpacity(0.1), blurRadius: 16, offset: const Offset(0, 5))],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(icon, style: const TextStyle(fontSize: 26)),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: isAr ? 18 : 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.ink,
                    fontFamily: isAr ? 'Aref Ruqaa' : null,
                  ),
                ),
                const SizedBox(height: 4),
                Text(body,
                  textAlign: TextAlign.start,
                  style: const TextStyle(fontSize: 13, color: AppColors.inkLight, height: 1.7),
                ),
                const SizedBox(height: 9),
                GestureDetector(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
                    decoration: BoxDecoration(
                      color: AppColors.sky,
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.location_on_outlined, size: 13, color: AppColors.blue),
                        const SizedBox(width: 5),
                        Text(
                          isAr ? 'افتح الموقع' : 'Open Location',
                          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.blue),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _starTrail() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TwinklingImage(asset: 'assets/images/star.png', size: 18),
          const SizedBox(width: 18),
          TwinklingImage(asset: 'assets/images/star.png', size: 18, delay: 1000.ms),
          const SizedBox(width: 18),
          TwinklingImage(asset: 'assets/images/star.png', size: 18, delay: 2000.ms),
        ],
      ),
    );
  }
}
// ──────────────────────────────────────────────
//  NOTE SECTION
// ──────────────────────────────────────────────
class _NoteSection extends StatelessWidget {
  final bool isAr;
  const _NoteSection({required this.isAr});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return Container(
      color: AppColors.cream,
      padding: const EdgeInsets.fromLTRB(22, 60, 22, 44),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Floating balloons
          Positioned(
            top: 0, left: isAr ? null : 0, right: isAr ? 0 : null,
            child: FloatingImage(asset: 'assets/images/balloons.png', width: (w * 0.16).clamp(56.0, 76.0)),
          ),
          Positioned(
            top: 12, right: isAr ? null : 0, left: isAr ? 0 : null,
            child: FloatingImage(asset: 'assets/images/balloons.png', width: (w * 0.13).clamp(50.0, 66.0), offsetY: 8),
          ),
          Column(
            children: [
              // Card with bear on top
              Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.topCenter,
                children: [
                  // Bear peeking above
                  Positioned(
                    top: -50,
                    child: Image.asset('assets/images/bear.png', width: 100, fit: BoxFit.contain),
                  ),
                  // Note card
                  Container(
                    constraints: const BoxConstraints(maxWidth: 540),
                    margin: const EdgeInsets.only(top: 50),
                    padding: const EdgeInsets.fromLTRB(26, 50, 26, 28),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: AppColors.tanPale, width: 1.5),
                      boxShadow: [BoxShadow(color: AppColors.ink.withOpacity(0.1), blurRadius: 28, offset: const Offset(0, 12))],
                    ),
                    child: Column(
                      children: [
                        Text(
                          isAr
                              ? 'من يوم ما جالنا جان، البيت بقى مليان فرح ونور. نتمنى تشاركونا هذه الفرحة وتكونوا معانا في يوم سبوعه، عشان تكتمل بيكم البهجة.'
                              : "Since the day Jan came into our lives, our home has been filled with joy and light. We'd love for you to share this happiness with us on his special day.",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16, color: AppColors.inkLight, height: 2.0),
                        ),
                        const SizedBox(height: 18),
                        Text(
                          isAr ? 'بكل الحب، والدا جان' : "With all our love, Jan's Parents",
                          textAlign: TextAlign.center,
                          style: isAr
                              ? const TextStyle(fontFamily: 'Aref Ruqaa', fontSize: 24, color: AppColors.tan, fontWeight: FontWeight.w700)
                              : GoogleFonts.caveat(fontSize: 28, fontWeight: FontWeight.w700, color: AppColors.tan),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ──────────────────────────────────────────────
//  RSVP SECTION
// ──────────────────────────────────────────────
class _RsvpSection extends StatelessWidget {
  final bool isAr;
  const _RsvpSection({required this.isAr});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.sky, AppColors.skyMid],
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 0),
      child: Column(
        children: [
          Text(
            isAr ? 'نسعد بحضوركم' : 'Join Us',
            textAlign: TextAlign.center,
            style: GoogleFonts.jost(
              fontSize: 11,
              letterSpacing: isAr ? 0 : 3,
              fontWeight: FontWeight.w700,
              color: Colors.white.withOpacity(0.8),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            isAr ? 'اتركوا لنا رسالة 🎀' : 'Leave us a message 🎀',
            textAlign: TextAlign.center,
            style: isAr
                ? const TextStyle(
              fontFamily: 'Aref Ruqaa',
              fontSize: 30,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            )
                : GoogleFonts.cormorantGaramond(
              fontSize: 36,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 24),
          RsvpForm(isAr: isAr),
          const SizedBox(height: 24),
          Text(
            isAr ? 'ولا تتأخروا!' : "Don't miss it!",
            textAlign: TextAlign.center,
            style: isAr
                ? const TextStyle(
              fontFamily: 'Aref Ruqaa',
              fontSize: 38,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            )
                : GoogleFonts.caveat(
              fontSize: 44,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ).animate(onPlay: (c) => c.repeat(reverse: true))
              .moveY(begin: 0, end: -4, duration: 2.seconds, curve: Curves.easeInOut),
        ],
      ),
    );
  }
}// ──────────────────────────────────────────────
//  FOOTER SECTION
// ──────────────────────────────────────────────
class _FooterSection extends StatelessWidget {
  final bool isAr;
  const _FooterSection({required this.isAr});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.cream,
      padding: const EdgeInsets.only(bottom: 48),
      child: Column(
        children: [
          FlyingImage(asset: 'assets/images/plane.png', width: 260),
          const SizedBox(height: 10),
          Text(
            isAr ? 'بكل الحب' : 'With all our love',
            style: const TextStyle(fontSize: 13, color: AppColors.blueLight, letterSpacing: 1),
          ),
          const SizedBox(height: 4),
          Text(
            isAr ? 'جان' : 'Jan',
            style: isAr
                ? const TextStyle(fontFamily: 'Aref Ruqaa', fontSize: 38, fontWeight: FontWeight.w700, color: AppColors.ink)
                : GoogleFonts.cormorantGaramond(fontSize: 42, fontStyle: FontStyle.italic, fontWeight: FontWeight.w600, color: AppColors.ink),
          ),
          const SizedBox(height: 8),
          Text(
            isAr ? 'سبوع · ٢٠٢٦' : 'SEBOU · 2026',
            style: const TextStyle(fontSize: 11, color: AppColors.gold, letterSpacing: 2.5),
          ),
        ],
      ),
    );
  }
}
