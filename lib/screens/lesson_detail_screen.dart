import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_swiper_3/flutter_swiper_3.dart';

class LessonDetailScreen extends StatefulWidget {
  final String category;
  final List<Map<String, dynamic>> items;

  const LessonDetailScreen({
    super.key,
    required this.category,
    required this.items,
  });

  @override
  State<LessonDetailScreen> createState() => _LessonDetailScreenState();
}

class _LessonDetailScreenState extends State<LessonDetailScreen> {
  late SwiperController _swiperController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _swiperController = SwiperController();
  }

  @override
  void dispose() {
    _swiperController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDarkMode ? Colors.white : Colors.black;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.category,
          style: GoogleFonts.comicNeue(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
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
        child: Swiper(
          controller: _swiperController,
          itemCount: widget.items.length,
          onIndexChanged: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          pagination: SwiperPagination(
            builder: DotSwiperPaginationBuilder(
              activeColor: Theme.of(context).primaryColor,
              color: Colors.grey,
            ),
          ),
          itemBuilder: (context, index) {
            return LessonCard(
              title: widget.items[index]['title'],
              image: widget.items[index]['image'],
              funFact: widget.items[index]['funFact'],
              textColor: textColor,
            );
          },
        ),
      ),
    );
  }
}

class LessonCard extends StatelessWidget {
  final String title;
  final String image;
  final String funFact;
  final Color textColor;

  const LessonCard({
    super.key,
    required this.title,
    required this.image,
    required this.funFact,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => FunFactDialog(
            funFact: funFact,
            textColor: textColor,
          ),
        );
      },
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          padding: const EdgeInsets.all(24.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: [
                Theme.of(context).primaryColor.withOpacity(0.1),
                Theme.of(context).primaryColor.withOpacity(0.05),
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: image,
                child: Image.asset(
                  image,
                  height: 200,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                title,
                style: GoogleFonts.comicNeue(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                'Tap to learn a fun fact!',
                style: GoogleFonts.comicNeue(
                  fontSize: 16,
                  color: textColor.withOpacity(0.7),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FunFactDialog extends StatelessWidget {
  final String funFact;
  final Color textColor;

  const FunFactDialog({
    super.key,
    required this.funFact,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Fun Fact!',
        style: GoogleFonts.comicNeue(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
      ),
      content: Text(
        funFact,
        style: GoogleFonts.comicNeue(
          fontSize: 18,
          color: textColor,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            'Cool!',
            style: GoogleFonts.comicNeue(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
