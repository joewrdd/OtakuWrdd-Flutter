import 'dart:ui';

import 'package:OtakuWrdd/common/widgets/design/rounded_image.dart';
import 'package:OtakuWrdd/ui/auth/controllers/user/user_controller.dart';
import 'package:OtakuWrdd/ui/main/controllers/discover_scroll_controller.dart';
import 'package:OtakuWrdd/ui/main/controllers/profile_controller.dart';
import 'package:OtakuWrdd/ui/main/screens/discover/widgets/discovery_headers.dart';
import 'package:OtakuWrdd/ui/main/screens/profile/widgets/user_favorites.dart';
import 'package:OtakuWrdd/ui/main/screens/settings/settings.dart';
import 'package:OtakuWrdd/utils/constants/colors.dart';
import 'package:OtakuWrdd/utils/constants/images.dart';
import 'package:OtakuWrdd/utils/constants/sizes.dart';
import 'package:OtakuWrdd/utils/shimmers/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userController = Get.put(UserController());
    final discoverScrollController = Get.put(DiscoverScrollController());
    final profileController = Get.put(ProfileController());
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        titleSpacing: 15,
        toolbarHeight: 80,
        centerTitle: true,
        leadingWidth: 0,
        leading: const SizedBox.shrink(),
        actions: [
          Container(
            margin: const EdgeInsets.only(top: 2),
            alignment: Alignment.topCenter,
            child: IconButton(
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              onPressed: () => Get.to(() => const SettingsScreen()),
              icon: const Icon(Iconsax.setting_2, size: 25),
            ),
          ),
        ],
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              userController.user.value.username,
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
        flexibleSpace: Obx(
          () => ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 10 * discoverScrollController.opacity.value,
                sigmaY: 10 * discoverScrollController.opacity.value,
              ),
              child: Container(
                width: double.infinity,
                height: 150,
                color: Colors.black.withOpacity(
                  0.2 * discoverScrollController.opacity.value,
                ),
              ),
            ),
          ),
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
          CustomScrollView(
            controller: discoverScrollController.scrollController,
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: ConstantSizes.spaceBtwSections * 3.7,
                  ),
                  child: Container(
                    height: 180,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.3),
                          BlendMode.darken,
                        ),
                        image: AssetImage(ConstantImages.japaneseFlower),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Obx(() {
                            final networkImage =
                                userController.user.value.profilePicture;
                            final image =
                                networkImage.isNotEmpty
                                    ? networkImage
                                    : ConstantImages.mainLogo;
                            if (userController.isProfileLoading.value) {
                              return const TShimmerEffect(
                                width: 120,
                                height: 120,
                                radius: 100,
                              );
                            }
                            return CustomRoundedImage(
                              imageUrl: image,
                              isNetworkImage: networkImage.isNotEmpty,
                              border: Border.all(
                                color: ConstantColors.sixth.withOpacity(0.4),
                              ),
                              height: 120,
                              width: 120,
                            );
                          }),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: ConstantSizes.spaceBtwSections / 2,
                            left: ConstantSizes.spaceBtwItems / 2,
                          ),
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  DiscoveryHeaders(text: 'TOTAL ANIME'),
                                  Obx(
                                    () => Text(
                                      profileController
                                          .totalAnimeCompleted
                                          .value
                                          .toString(),
                                      style: GoogleFonts.notoSans(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        color: ConstantColors.sixth,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: ConstantSizes.spaceBtwItems / 2,
                                  ),
                                  DiscoveryHeaders(text: 'EPISODES WATCHED'),
                                  Obx(
                                    () => Text(
                                      profileController
                                          .totalEpisodesWatched
                                          .value
                                          .toString(),
                                      style: GoogleFonts.notoSans(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        color: ConstantColors.sixth,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: ConstantSizes.spaceBtwItems / 2,
                                  ),
                                  DiscoveryHeaders(text: 'FOLLOWERS'),
                                  Text(
                                    '-',
                                    style: GoogleFonts.notoSans(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      color: ConstantColors.sixth,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(width: ConstantSizes.profileSpace),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  DiscoveryHeaders(text: 'TOTAL MANGA'),
                                  Obx(
                                    () => Text(
                                      profileController
                                          .totalMangaCompleted
                                          .value
                                          .toString(),
                                      style: GoogleFonts.notoSans(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        color: ConstantColors.sixth,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: ConstantSizes.spaceBtwItems / 2,
                                  ),
                                  DiscoveryHeaders(text: 'CHAPTERS READ'),
                                  Obx(
                                    () => Text(
                                      profileController.totalChaptersRead.value
                                          .toString(),
                                      style: GoogleFonts.notoSans(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        color: ConstantColors.sixth,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: ConstantSizes.spaceBtwItems / 2,
                                  ),
                                  DiscoveryHeaders(text: 'FOLLOWING'),
                                  Text(
                                    '-',
                                    style: GoogleFonts.notoSans(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      color: ConstantColors.sixth,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: ConstantSizes.spaceBtwSections * 2,
                    bottom: ConstantSizes.spaceBtwSections,
                  ),
                  child: Divider(
                    color: ConstantColors.sixth.withOpacity(0.7),
                    indent: 30,
                    endIndent: 30,
                    height: 1,
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: ConstantSizes.spaceBtwItems / 2,
                  ),
                  child: UserFavorites(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
