import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import 'lesson_detail_screen.dart';

class LessonsScreen extends StatelessWidget {
  const LessonsScreen({super.key});

  static final List<Map<String, dynamic>> categories = [
    {
      'title': 'Alphabets',
      'icon': Icons.abc,
      'color': Colors.blue,
      'items': [
        {
          'title': 'A - Apple',
          'image': 'assets/images/apple.png',
          'funFact': 'Did you know apples float because they are 25% air?',
        },
        {
          'title': 'B - Banana',
          'image': 'assets/images/banana.png',
          'funFact': 'Bananas are berries, but strawberries are not!',
        },
        {
          'title': 'C - Cat',
          'image': 'assets/images/cat.png',
          'funFact': 'Cats can jump up to 6 times their body length!',
        },
      ],
    },
    {
      'title': 'Numbers',
      'icon': Icons.numbers,
      'color': Colors.green,
      'items': [
        {
          'title': '1 - One',
          'image': 'assets/images/one.png',
          'funFact':
              'The number 1 is the only number that is neither prime nor composite!',
        },
        {
          'title': '2 - Two',
          'image': 'assets/images/two.png',
          'funFact': 'Two is the only even prime number!',
        },
        {
          'title': '3 - Three',
          'image': 'assets/images/three.png',
          'funFact': 'A triangle has three sides and three angles!',
        },
      ],
    },
    {
      'title': 'Animals',
      'icon': Icons.pets,
      'color': Colors.orange,
      'items': [
        {
          'title': 'Lion',
          'image': 'assets/images/lion.png',
          'funFact': 'Lions can sleep for up to 20 hours a day!',
        },
        {
          'title': 'Elephant',
          'image': 'assets/images/elephant.png',
          'funFact': 'Elephants are the only mammals that cannot jump!',
        },
        {
          'title': 'Giraffe',
          'image': 'assets/images/giraffe.png',
          'funFact':
              'Giraffes have the same number of neck vertebrae as humans!',
        },
      ],
    },
    {
      'title': 'Fruits',
      'icon': Icons.apple,
      'color': Colors.red,
      'items': [
        {
          'title': 'Apple',
          'image': 'assets/images/apple.png',
          'funFact': 'Apples float because they are 25% air!',
        },
        {
          'title': 'Banana',
          'image': 'assets/images/banana.png',
          'funFact': 'Bananas are actually berries!',
        },
        {
          'title': 'Orange',
          'image': 'assets/images/orange.png',
          'funFact': 'Oranges are actually a type of berry!',
        },
      ],
    },
    {
      'title': 'Colors',
      'icon': Icons.palette,
      'color': Colors.purple,
      'items': [
        {
          'title': 'Red',
          'image': 'assets/images/red.png',
          'funFact': 'Red is the first color babies can see!',
        },
        {
          'title': 'Blue',
          'image': 'assets/images/blue.png',
          'funFact': 'Blue is the most common favorite color!',
        },
        {
          'title': 'Green',
          'image': 'assets/images/green.png',
          'funFact': 'Green is the most common color in nature!',
        },
      ],
    },
    {
      'title': 'Shapes',
      'icon': Icons.shape_line,
      'color': Colors.pink,
      'items': [
        {
          'title': 'Circle',
          'image': 'assets/images/circle.png',
          'funFact': 'A circle has infinite lines of symmetry!',
        },
        {
          'title': 'Square',
          'image': 'assets/images/square.png',
          'funFact': 'A square has four equal sides and four right angles!',
        },
        {
          'title': 'Triangle',
          'image': 'assets/images/triangle.png',
          'funFact':
              'The sum of all angles in a triangle is always 180 degrees!',
        },
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDarkMode ? Colors.white : Colors.black;

    return Consumer<AppProvider>(
      builder: (context, appProvider, child) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: MasonryGridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return CategoryCard(
                category: categories[index],
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LessonDetailScreen(
                        category: categories[index]['title'],
                        items: categories[index]['items'],
                      ),
                    ),
                  );
                },
              )
                  .animate()
                  .fadeIn(delay: Duration(milliseconds: 100 * index))
                  .scale(delay: Duration(milliseconds: 100 * index));
            },
          ),
        );
      },
    );
  }
}

class CategoryCard extends StatelessWidget {
  final Map<String, dynamic> category;
  final VoidCallback onTap;

  const CategoryCard({
    super.key,
    required this.category,
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
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              colors: [
                category['color'] as Color,
                category['color'].withOpacity(0.7),
              ],
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                category['icon'] as IconData,
                size: 48,
                color: Colors.white,
              ),
              const SizedBox(height: 8),
              Text(
                category['title'] as String,
                style: GoogleFonts.comicNeue(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
