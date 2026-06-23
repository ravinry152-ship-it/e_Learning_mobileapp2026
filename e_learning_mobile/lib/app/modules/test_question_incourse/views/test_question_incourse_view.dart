// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/test_question_incourse_controller.dart';
class _Tokens {
  static const purple = Color(0xFF5C2D91);
  static const purpleDeep = Color(0xFF45216E);
  static const gold = Color(0xFFF2A93B);
  static const ink = Color(0xFF1A1B23);
  static const inkSoft = Color(0xFF6E6E7C);
  static const lilac = Color(0xFFF3EDFB);
  static const mist = Color(0xFFF7F7FB);
  static const hairline = Color(0xFFECECF3);
}

class TestQuestionIncourseView extends GetView<TestQuestionIncourseController> {
  const TestQuestionIncourseView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _Tokens.mist,
      appBar: AppBar(
        backgroundColor: _Tokens.mist,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close_rounded, color: _Tokens.ink, size: 24),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'ធ្វើតេស្តសមត្ថភាព',
          style: GoogleFonts.kantumruyPro(
            color: _Tokens.ink,
            fontWeight: FontWeight.w700,
            fontSize: 17,
          ),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () => controller.skipQuestion(),
            child: Text(
              "រំលង",
              style: GoogleFonts.kantumruyPro(
                color: _Tokens.purple,
                fontWeight: FontWeight.w700,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(
              color: _Tokens.purple,
              strokeWidth: 3,
            ),
          );
        }

        if (controller.questions.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.inbox_outlined, size: 48, color: Colors.grey.shade300),
                  const SizedBox(height: 12),
                  Text(
                    "មិនមានសំណួរសម្រាប់មេរៀននេះទេ",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.kantumruyPro(fontSize: 15, color: _Tokens.inkSoft),
                  ),
                ],
              ),
            ),
          );
        }

        final total = controller.questions.length;
        final currentIndex = controller.currentQuestionIndex.value;
        final currentQuestion = controller.questions[currentIndex];
        final List<dynamic> choices = currentQuestion['choices'] ?? [];
        final isLastQuestion = currentIndex == total - 1;
        final hasSelection = controller.selectedAnswer.value != null;

        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _SegmentedProgress(current: currentIndex, total: total),
              const SizedBox(height: 6),
              Text(
                "សំណួរទី ${currentIndex + 1} នៃ $total",
                style: GoogleFonts.kantumruyPro(
                  color: _Tokens.inkSoft,
                  fontWeight: FontWeight.w600,
                  fontSize: 12.5,
                  letterSpacing: 0.2,
                ),
              ),
              const SizedBox(height: 18),

              //  Question card with eyebrow pill + left accent
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: _Tokens.hairline),
                  boxShadow: [
                    BoxShadow(
                      color: _Tokens.purple.withOpacity(0.05),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: _Tokens.lilac,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        "សំណួរ ${currentIndex + 1}",
                        style: GoogleFonts.kantumruyPro(
                          color: _Tokens.purple,
                          fontWeight: FontWeight.w700,
                          fontSize: 11.5,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      currentQuestion['question_text'] ?? '',
                      style: GoogleFonts.kantumruyPro(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        height: 1.55,
                        color: _Tokens.ink,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              //  Choices — accent strip + checkmark on select
              Expanded(
                child: ListView.separated(
                  itemCount: choices.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final choice = choices[index];
                    final int choiceId = choice['id'];
                    final isSelected = controller.selectedAnswer.value == choiceId;

                    return _ChoiceTile(
                      prefix: choice['prefix'] ?? '',
                      text: choice['choice_text'] ?? '',
                      isSelected: isSelected,
                      onTap: () => controller.selectAnswer(choiceId),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),

              // ⏭ Primary CTA
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: !hasSelection ? null : () => controller.nextQuestion(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _Tokens.purple,
                    disabledBackgroundColor: const Color(0xFFE3E0EA),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                  ).copyWith(
                    overlayColor: WidgetStateProperty.all(_Tokens.purpleDeep.withOpacity(0.15)),
                  ),
                  child: Text(
                    isLastQuestion ? "ផ្ញើចម្លើយ" : "សំណួរបន្ទាប់",
                    style: GoogleFonts.kantumruyPro(
                      color: hasSelection ? Colors.white : const Color(0xFFAEAAB8),
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

// ── Segmented progress bar ──────────────────────────────────────
class _SegmentedProgress extends StatelessWidget {
  final int current;
  final int total;

  const _SegmentedProgress({required this.current, required this.total});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 6,
      child: Row(
        children: List.generate(total, (i) {
          final isFilled = i <= current;
          final isLast = i == total - 1;
          return Expanded(
            child: Container(
              margin: EdgeInsets.only(right: isLast ? 0 : 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                gradient: isFilled
                    ? LinearGradient(
                        colors: [_Tokens.purple, _Tokens.gold],
                        stops: [0.0, current / (total == 1 ? 1 : total - 1).clamp(0.001, 1.0)],
                      )
                    : null,
                color: isFilled ? null : _Tokens.hairline,
              ),
            ),
          );
        }),
      ),
    );
  }
}

// ── Choice tile ──────────────────────────────────────────────────
class _ChoiceTile extends StatelessWidget {
  final String prefix;
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const _ChoiceTile({
    required this.prefix,
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 14),
          decoration: BoxDecoration(
            color: isSelected ? _Tokens.lilac : Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: isSelected ? _Tokens.purple : _Tokens.hairline,
              width: isSelected ? 1.5 : 1,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 32,
                height: 32,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isSelected ? _Tokens.purple : _Tokens.mist,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  prefix,
                  style: GoogleFonts.kantumruyPro(
                    color: isSelected ? Colors.white : _Tokens.inkSoft,
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                  ),
                ),
              ),
              const SizedBox(width: 13),
              Expanded(
                child: Text(
                  text,
                  style: GoogleFonts.kantumruyPro(
                    color: _Tokens.ink,
                    fontSize: 14.5,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                    height: 1.4,
                  ),
                ),
              ),
              if (isSelected) ...[
                const SizedBox(width: 8),
                const Icon(Icons.check_circle_rounded, color: _Tokens.purple, size: 20),
              ],
            ],
          ),
        ),
      ),
    );
  }
}