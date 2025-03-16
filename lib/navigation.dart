import 'package:OtakuWrdd/ui/auth/controllers/user/user_controller.dart';
import 'package:OtakuWrdd/ui/main/screens/anime/anime.dart';
import 'package:OtakuWrdd/ui/main/screens/discover/discover.dart';
import 'package:OtakuWrdd/ui/main/screens/feed/feed.dart';
import 'package:OtakuWrdd/ui/main/screens/manga/manga.dart';
import 'package:OtakuWrdd/ui/main/screens/profile/profile.dart';
import 'package:OtakuWrdd/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'dart:ui';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final NavigationController controller = Get.put(NavigationController());
    final UserController userController = Get.put(UserController());
    return Scaffold(
      body: Obx(() => controller.pages[controller.index.value]),
      bottomNavigationBar: Obx(
        () => ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 250, sigmaY: 250),
            child: NavigationBarTheme(
              data: NavigationBarThemeData(
                indicatorColor: Colors.transparent,
                labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
                overlayColor: WidgetStateProperty.all(Colors.transparent),
                labelTextStyle: WidgetStateProperty.resolveWith((states) {
                  return GoogleFonts.notoSans(
                    color:
                        states.contains(WidgetState.selected)
                            ? Colors.white
                            : ConstantColors.darkGrey.withOpacity(0.7),
                    fontSize: 11,
                  );
                }),
              ),
              child: NavigationBar(
                backgroundColor: Colors.black.withOpacity(0.01),
                height: 65,
                elevation: 0,
                selectedIndex: controller.index.value,
                onDestinationSelected:
                    (index) => controller.index.value = index,
                destinations: [
                  NavigationDestination(
                    icon: Icon(
                      Icons.tv_rounded,
                      size: 32,
                      color: ConstantColors.darkGrey.withOpacity(0.7),
                    ),
                    selectedIcon: Icon(
                      Icons.tv_rounded,
                      size: 32,
                      color: Colors.white,
                    ),
                    label: 'Anime',
                  ),
                  NavigationDestination(
                    icon: Icon(
                      Iconsax.book_saved,
                      size: 32,
                      color: ConstantColors.darkGrey.withOpacity(0.7),
                    ),
                    selectedIcon: Icon(
                      Iconsax.book_saved,
                      size: 32,
                      color: Colors.white,
                    ),
                    label: 'Manga',
                  ),
                  NavigationDestination(
                    icon: Icon(
                      Iconsax.search_normal,
                      size: 32,
                      color: ConstantColors.darkGrey.withOpacity(0.7),
                    ),
                    selectedIcon: Icon(
                      Iconsax.search_normal,
                      size: 32,
                      color: Colors.white,
                    ),
                    label: 'Discover',
                  ),
                  NavigationDestination(
                    icon: Icon(
                      Icons.feed_outlined,
                      size: 32,
                      color: ConstantColors.darkGrey.withOpacity(0.7),
                    ),
                    selectedIcon: Icon(
                      Icons.feed_outlined,
                      size: 32,
                      color: Colors.white,
                    ),
                    label: 'Feed',
                  ),
                  NavigationDestination(
                    icon: Icon(
                      Iconsax.profile_circle5,
                      size: 32,
                      color: ConstantColors.darkGrey.withOpacity(0.7),
                    ),
                    selectedIcon: Icon(
                      Iconsax.profile_circle5,
                      size: 32,
                      color: Colors.white,
                    ),
                    label: userController.user.value.username,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> index = 0.obs;

  final pages = [
    const AnimeScreen(),
    const MangaScreen(),
    const DiscoverScreen(),
    const FeedScreen(),
    const ProfileScreen(),
  ];
}
