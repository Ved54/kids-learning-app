import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:confetti/confetti.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 2));
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDarkMode ? Colors.white : Colors.black;

    return Consumer<AppProvider>(
      builder: (context, appProvider, child) {
        final leaderboard = appProvider.leaderboard;
        final userRank = leaderboard.indexWhere(
          (entry) => entry.name == appProvider.userProfile.name,
        );

        if (userRank == 0) {
          _confettiController.play();
        }

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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Leaderboard',
                      style: GoogleFonts.comicNeue(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Expanded(
                      child: ListView.builder(
                        itemCount: leaderboard.length,
                        itemBuilder: (context, index) {
                          final entry = leaderboard[index];
                          final isUser =
                              entry.name == appProvider.userProfile.name;

                          return LeaderboardCard(
                            entry: entry,
                            isUser: isUser,
                            textColor: textColor,
                          )
                              .animate()
                              .fadeIn(
                                delay: Duration(milliseconds: 100 * index),
                              )
                              .slideX(
                                begin: 0.2,
                                end: 0,
                                delay: Duration(milliseconds: 100 * index),
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
                numberOfParticles: 50,
                gravity: 0.1,
                shouldLoop: false,
                colors: const [
                  Colors.amber,
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

class LeaderboardCard extends StatelessWidget {
  final dynamic entry;
  final bool isUser;
  final Color textColor;

  const LeaderboardCard({
    super.key,
    required this.entry,
    required this.isUser,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: isUser ? 8 : 4,
      color: isUser ? Theme.of(context).primaryColor.withOpacity(0.1) : null,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: isUser
            ? BorderSide(
                color: Theme.of(context).primaryColor,
                width: 2,
              )
            : BorderSide.none,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: _getRankColor(entry.rank),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '${entry.rank}',
                  style: GoogleFonts.comicNeue(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            CircleAvatar(
              radius: 24,
              backgroundImage: AssetImage(entry.avatar),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    entry.name,
                    style: GoogleFonts.comicNeue(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  Text(
                    'Score: ${entry.score}',
                    style: GoogleFonts.comicNeue(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getRankColor(int rank) {
    switch (rank) {
      case 1:
        return Colors.amber;
      case 2:
        return Colors.grey[400]!;
      case 3:
        return Colors.brown;
      default:
        return Colors.blue;
    }
  }
}
