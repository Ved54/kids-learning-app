import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:confetti/confetti.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> with TickerProviderStateMixin {
  late ConfettiController _confettiController;
  late AnimationController _progressController;
  late Animation<double> _progressAnimation;

  @override
  void initState() {
    super.initState();
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 1));
    _progressController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _progressAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _progressController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _confettiController.dispose();
    _progressController.dispose();
    super.dispose();
  }

  void _handleAnswer(BuildContext context, bool isCorrect) {
    if (isCorrect) {
      _confettiController.play();
      final appProvider = context.read<AppProvider>();
      appProvider.updateQuizScore(10);
      _progressController.forward();

      // Add a delay before moving to the next question
      Future.delayed(const Duration(seconds: 1), () {
        if (mounted) {
          if (appProvider.currentQuizIndex <
              appProvider.quizQuestions.length - 1) {
            appProvider.nextQuizQuestion();
            _progressController.reset();
          } else {
            // Quiz completed
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                final isDarkMode =
                    Theme.of(context).brightness == Brightness.dark;
                final textColor = isDarkMode ? Colors.white : Colors.black;

                return AlertDialog(
                  title: Text(
                    'Quiz Completed!',
                    style: GoogleFonts.comicNeue(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  content: Text(
                    'Your score: ${appProvider.quizScore}',
                    style: GoogleFonts.comicNeue(
                      fontSize: 18,
                      color: textColor,
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        appProvider.resetQuiz();
                      },
                      child: Text(
                        'Play Again',
                        style: GoogleFonts.comicNeue(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          }
        }
      });
    } else {
      // Show shake animation for wrong answer
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Try again!',
            style: GoogleFonts.comicNeue(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDarkMode ? Colors.white : Colors.black;

    return Consumer<AppProvider>(
      builder: (context, appProvider, child) {
        final currentQuestion =
            appProvider.quizQuestions[appProvider.currentQuizIndex];
        final progress = (appProvider.currentQuizIndex + 1) /
            appProvider.quizQuestions.length;

        return Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Theme.of(context).primaryColor.withOpacity(0.1),
                    isDarkMode ? Colors.grey[900]! : Colors.white,
                  ],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Question ${appProvider.currentQuizIndex + 1}/${appProvider.quizQuestions.length}',
                          style: GoogleFonts.comicNeue(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                        ),
                        Text(
                          'Score: ${appProvider.quizScore}',
                          style: GoogleFonts.comicNeue(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    AnimatedBuilder(
                      animation: _progressAnimation,
                      builder: (context, child) {
                        return LinearProgressIndicator(
                          value: progress,
                          backgroundColor: Colors.grey[200],
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Theme.of(context).primaryColor,
                          ),
                          minHeight: 10,
                        );
                      },
                    ),
                    const SizedBox(height: 32),
                    Card(
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(24.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: isDarkMode ? Colors.grey[800] : Colors.white,
                        ),
                        child: Text(
                          currentQuestion.question,
                          style: GoogleFonts.comicNeue(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ).animate().fadeIn().scale(),
                    const SizedBox(height: 32),
                    Expanded(
                      child: ListView.builder(
                        itemCount: currentQuestion.options.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: QuizOption(
                              option: currentQuestion.options[index],
                              onTap: () {
                                _handleAnswer(
                                  context,
                                  index == currentQuestion.correctOptionIndex,
                                );
                              },
                            ).animate().fadeIn(
                                  delay: Duration(milliseconds: 200 * index),
                                ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: ConfettiWidget(
                confettiController: _confettiController,
                blastDirectionality: BlastDirectionality.explosive,
                particleDrag: 0.05,
                emissionFrequency: 0.05,
                numberOfParticles: 20,
                gravity: 0.1,
                shouldLoop: false,
                colors: const [
                  Colors.green,
                  Colors.blue,
                  Colors.pink,
                  Colors.orange,
                  Colors.purple,
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class QuizOption extends StatelessWidget {
  final String option;
  final VoidCallback onTap;

  const QuizOption({
    super.key,
    required this.option,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDarkMode ? Colors.white : Colors.black;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              colors: [
                Theme.of(context).primaryColor.withOpacity(0.1),
                isDarkMode ? Colors.grey[800]! : Colors.white,
              ],
            ),
          ),
          child: Text(
            option,
            style: GoogleFonts.comicNeue(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}

class ShakeCurve extends Curve {
  final int count;

  const ShakeCurve({this.count = 3});

  @override
  double transformInternal(double t) {
    return sin(count * 2 * pi * t);
  }
}
