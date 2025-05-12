import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'lessons_screen.dart';
import 'quiz_screen.dart';
import 'leaderboard_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Kids Learning',
            style: GoogleFonts.comicNeue(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.book),
                text: 'Lessons',
              ),
              Tab(
                icon: Icon(Icons.quiz),
                text: 'Quiz',
              ),
              Tab(
                icon: Icon(Icons.leaderboard),
                text: 'Leaderboard',
              ),
              Tab(
                icon: Icon(Icons.person),
                text: 'Profile',
              ),
            ],
          ),
        ),
        body: const TabBarView(

          children: [
            LessonsScreen(),
            QuizScreen(),
            LeaderboardScreen(),
            ProfileScreen(),
          ],
        ),
      ),
    );
  }
}
