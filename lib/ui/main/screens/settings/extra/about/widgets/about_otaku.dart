import 'package:OtakuWrdd/utils/constants/colors.dart';
import 'package:OtakuWrdd/utils/constants/images.dart';
import 'package:OtakuWrdd/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class AboutOtaku extends StatelessWidget {
  const AboutOtaku({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        titleSpacing: 15,
        toolbarHeight: 80,
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: const EdgeInsets.only(bottom: 32),
          child: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(Iconsax.arrow_left_2, color: ConstantColors.white),
          ),
        ),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'About OtakuWrdd',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.notoSans(
                color: ConstantColors.sixth,
                fontSize: 15.3,
              ),
            ),
            const SizedBox(height: ConstantSizes.spaceBtwItems * 2),
          ],
        ),
      ),
      body: Stack(
        children: [
          SvgPicture.asset(
            ConstantImages.mainBackground,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: ConstantSizes.spaceBtwSections * 4,
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    children: [
                      Text(
                        'OtakuWrdd started off as an idea in 2025, when there were a large fanbase of anime and manga lovers i want wanted to create something that would admire and keep their love of anime by tracking their lists & their achievements. As someone deeply immersed in the world of anime and manga, I wanted to work on this beautiful Flutter app to manage my lists instead of relying on websites or basic note-taking apps. What began as a passion project has evolved into one of my favorite apps to develop! 😄',
                        style: GoogleFonts.notoSans(
                          color: ConstantColors.white,
                          fontSize: 12,
                          height: 1.5,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'OtakuWrdd is developed and maintained by a single person: me! I have a deep passion for Flutter development and watching anime. I\'m constantly exploring new ways to create an intuitive and sleek user experience for fellow otaku who share these interests.',
                        style: GoogleFonts.notoSans(
                          color: ConstantColors.white,
                          fontSize: 12,
                          height: 1.5,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'This app is not an official app for MyAnimeList.net, just a third-party client. That means there are limitations to what I can control, such as the data processing, the content displayed on detail pages, and so on. It\'s not directly affiliated with or under it\'s control. It\'s simply a fan-made Flutter app that I\'ve created because I wanted to build something amazing for the anime community. OtakuWrdd is powered by MyAnimeList.net\'s GraphQL API to manage your anime and manga lists.',
                        style: GoogleFonts.notoSans(
                          color: ConstantColors.white,
                          fontSize: 12,
                          height: 1.5,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'If I didn\'t have a day job & studies, this would be all I would work on! This is a hobby project that I develop in my free time. Between my full-time work and life responsibilities, finding time to work on OtakuWrdd can be challenging. As a result, updates might come at a slower pace than I\'d like, and I may not respond to feedback as quickly as I wish. I do read all feedback and try to reply when possible. I appreciate everyone\'s support and apologize if updates arrive slowly.',
                        style: GoogleFonts.notoSans(
                          color: ConstantColors.white,
                          fontSize: 12,
                          height: 1.5,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'If you\'ve read this far, you\'re amazing! It\'s because of dedicated users like you that I\'m motivated to continually improve this app. Thank you so much for using OtakuWrdd, and I hope you enjoy it as much as I\'ve enjoyed building it. 🥰',
                        style: GoogleFonts.notoSans(
                          color: ConstantColors.white,
                          fontSize: 12,
                          height: 1.5,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        '- Joe Ward',
                        style: GoogleFonts.notoSans(
                          color: ConstantColors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
