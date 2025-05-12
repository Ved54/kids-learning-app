import 'package:flutter/material.dart';
import '../models/user_profile.dart';
import '../models/learning_content.dart';

class AppProvider with ChangeNotifier {
  UserProfile _userProfile = UserProfile(
    name: 'Little Learner',
    avatar: 'assets/avatars/lion.png',
    level: 1,
    experience: 0,
    totalStars: 0,
    isDarkMode: false,
  );

  List<LearningContent> _learningContent = [];
  List<QuizQuestion> _quizQuestions = [];
  List<LeaderboardEntry> _leaderboard = [];
  int _currentQuizIndex = 0;
  int _quizScore = 0;

  final List<String> avatars = [
    'assets/avatars/lion.png',
    'assets/avatars/giraffe.png',
    'assets/avatars/elephant.png',
    'assets/avatars/monkey.png',
    'assets/avatars/penguin.png',
  ];

  // Getters
  UserProfile get userProfile => _userProfile;
  List<LearningContent> get learningContent => _learningContent;
  List<QuizQuestion> get quizQuestions => _quizQuestions;
  List<LeaderboardEntry> get leaderboard => _leaderboard;
  int get currentQuizIndex => _currentQuizIndex;
  int get quizScore => _quizScore;
  String get selectedAvatar => _userProfile.avatar;

  // Methods
  void toggleDarkMode() {
    _userProfile = _userProfile.copyWith(isDarkMode: !_userProfile.isDarkMode);
    notifyListeners();
  }

  void updateQuizScore(int score) {
    _quizScore += score;
    _userProfile = _userProfile.copyWith(
      totalStars: _userProfile.totalStars + score,
      experience: _userProfile.experience + score,
    );
    notifyListeners();
  }

  void nextQuizQuestion() {
    if (_currentQuizIndex < _quizQuestions.length - 1) {
      _currentQuizIndex++;
      notifyListeners();
    }
  }

  void resetQuiz() {
    _currentQuizIndex = 0;
    _quizScore = 0;
    notifyListeners();
  }

  void updateAvatar(String avatarPath) {
    _userProfile = _userProfile.copyWith(avatar: avatarPath);
    notifyListeners();
  }

  // Initialize dummy data
  void initializeDummyData() {

    _quizQuestions = [
      QuizQuestion(
        question: 'What color is an apple?',
        options: ['Red', 'Blue', 'Green', 'Yellow'],
        correctOptionIndex: 0,
      ),
      QuizQuestion(
        question: 'Which animal says "Moo"?',
        options: ['Cow', 'Dog', 'Cat', 'Duck'],
        correctOptionIndex: 0,
      ),
      QuizQuestion(
        question: 'What shape has 3 sides?',
        options: ['Triangle', 'Square', 'Circle', 'Rectangle'],
        correctOptionIndex: 0,
      ),
      QuizQuestion(
        question: 'Which number comes after 5?',
        options: ['6', '4', '7', '8'],
        correctOptionIndex: 0,
      ),
      QuizQuestion(
        question: 'What letter comes after "B"?',
        options: ['C', 'A', 'D', 'E'],
        correctOptionIndex: 0,
      ),
    ];

    _leaderboard = [
      LeaderboardEntry(
        name: 'Leo the Lion',
        avatar: 'assets/avatars/lion.png',
        score: 1000,
        rank: 1,
      ),
      LeaderboardEntry(
        name: 'Sophie the Star',
        avatar: 'assets/avatars/elephant.png',
        score: 950,
        rank: 2,
      ),
      LeaderboardEntry(
        name: 'Max the Monkey',
        avatar: 'assets/avatars/monkey.png',
        score: 900,
        rank: 3,
      ),
      LeaderboardEntry(
        name: 'Panda Pete',
        avatar: 'assets/avatars/panda.png',
        score: 850,
        rank: 4,
      ),
      LeaderboardEntry(
        name: 'Giraffe George',
        avatar: 'assets/avatars/giraffe.png',
        score: 800,
        rank: 5,
      ),
    ];
  }
}
