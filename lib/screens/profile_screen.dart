import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDarkMode ? Colors.white : Colors.black;

    return Consumer<AppProvider>(
      builder: (context, appProvider, child) {
        return Scaffold(
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
            child: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Stack(
                          children: [
                            Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Theme.of(context).primaryColor,
                                  width: 3,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    blurRadius: 10,
                                    offset: const Offset(0, 5),
                                  ),
                                ],
                              ),
                              child: ClipOval(
                                child: Image.asset(
                                  appProvider.selectedAvatar,
                                  fit: BoxFit.cover,
                                  width: 120,
                                  height: 120,
                                ),
                              ),
                            ),
                            Positioned(
                              right: 0,
                              bottom: 0,
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  shape: BoxShape.circle,
                                ),
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: Text(
                                          'Choose Avatar',
                                          style: GoogleFonts.comicNeue(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        content: SizedBox(
                                          width: double.maxFinite,
                                          child: GridView.builder(
                                            shrinkWrap: true,
                                            gridDelegate:
                                                const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 3,
                                              crossAxisSpacing: 10,
                                              mainAxisSpacing: 10,
                                            ),
                                            itemCount:
                                                appProvider.avatars.length,
                                            itemBuilder: (context, index) {
                                              return GestureDetector(
                                                onTap: () {
                                                  appProvider.updateAvatar(
                                                      appProvider
                                                          .avatars[index]);
                                                  Navigator.pop(context);
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                      color: appProvider
                                                                  .selectedAvatar ==
                                                              appProvider
                                                                      .avatars[
                                                                  index]
                                                          ? Theme.of(context)
                                                              .primaryColor
                                                          : Colors.transparent,
                                                      width: 2,
                                                    ),
                                                  ),
                                                  child: ClipOval(
                                                    child: Image.asset(
                                                      appProvider
                                                          .avatars[index],
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        appProvider.userProfile.name,
                        style: GoogleFonts.comicNeue(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                        textAlign: TextAlign.center,
                      ).animate().fadeIn(),
                      const SizedBox(height: 24),
                      Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Your Stats',
                                style: GoogleFonts.comicNeue(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: textColor,
                                ),
                              ),
                              const SizedBox(height: 16),
                              StatTile(
                                icon: Icons.star,
                                title: 'Level',
                                value: '${appProvider.userProfile.level}',
                                textColor: textColor,
                              ),
                              const SizedBox(height: 8),
                              StatTile(
                                icon: Icons.trending_up,
                                title: 'Experience',
                                value: '${appProvider.userProfile.experience}',
                                textColor: textColor,
                              ),
                              const SizedBox(height: 8),
                              StatTile(
                                icon: Icons.emoji_events,
                                title: 'Total Stars',
                                value: '${appProvider.userProfile.totalStars}',
                                textColor: textColor,
                              ),
                            ],
                          ),
                        ),
                      ).animate().slideY(begin: 0.2, end: 0),
                      const SizedBox(height: 24),
                      Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Customize',
                                style: GoogleFonts.comicNeue(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: textColor,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Choose Avatar',
                                style: GoogleFonts.comicNeue(
                                  fontSize: 16,
                                  color: textColor,
                                ),
                              ),
                              const SizedBox(height: 8),
                              SizedBox(
                                height: 70,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: appProvider.avatars.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(right: 8.0),
                                      child: AvatarChoice(
                                        avatar: appProvider.avatars[index],
                                        isSelected:
                                            appProvider.selectedAvatar ==
                                                appProvider.avatars[index],
                                        onTap: () {
                                          appProvider.updateAvatar(
                                              appProvider.avatars[index]);
                                        },
                                      ),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(height: 16),
                              SwitchListTile(
                                title: Text(
                                  'Dark Mode',
                                  style: GoogleFonts.comicNeue(
                                    fontSize: 16,
                                    color: textColor,
                                  ),
                                ),
                                value: appProvider.userProfile.isDarkMode,
                                onChanged: (value) {
                                  appProvider.toggleDarkMode();
                                },
                              ),
                            ],
                          ),
                        ),
                      ).animate().slideY(
                          begin: 0.2,
                          end: 0,
                          delay: const Duration(milliseconds: 200)),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class StatTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color textColor;

  const StatTile({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Theme.of(context).primaryColor),
        const SizedBox(width: 8),
        Text(
          title,
          style: GoogleFonts.comicNeue(
            fontSize: 16,
            color: textColor,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: GoogleFonts.comicNeue(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
      ],
    );
  }
}

class AvatarChoice extends StatelessWidget {
  final String avatar;
  final bool isSelected;
  final VoidCallback onTap;

  const AvatarChoice({
    super.key,
    required this.avatar,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: isSelected
                ? Theme.of(context).primaryColor
                : Colors.transparent,
            width: 3,
          ),
        ),
        child: CircleAvatar(
          radius: 25,
          backgroundImage: AssetImage(avatar),
        ),
      ),
    );
  }
}
