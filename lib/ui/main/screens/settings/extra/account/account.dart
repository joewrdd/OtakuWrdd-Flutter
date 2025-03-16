import 'dart:ui';
import 'package:OtakuWrdd/common/widgets/design/circular_container.dart';
import 'package:OtakuWrdd/common/widgets/design/rounded_image.dart';
import 'package:OtakuWrdd/ui/auth/controllers/user/user_controller.dart';
import 'package:OtakuWrdd/ui/main/controllers/discover_scroll_controller.dart';
import 'package:OtakuWrdd/ui/main/screens/discover/widgets/discovery_headers.dart';
import 'package:OtakuWrdd/ui/main/screens/settings/widgets/settings_menu_tile.dart';
import 'package:OtakuWrdd/utils/constants/colors.dart';
import 'package:OtakuWrdd/utils/constants/images.dart';
import 'package:OtakuWrdd/utils/constants/sizes.dart';
import 'package:OtakuWrdd/utils/shimmers/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final discoverScrollController = DiscoverScrollController.instance;
    final userController = UserController.instance;
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
              'Account',
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
                height: 200,
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
                    top: ConstantSizes.spaceBtwSections * 4,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Obx(() {
                              final networkImage =
                                  userController.user.value.profilePicture;
                              final image =
                                  networkImage.isNotEmpty
                                      ? networkImage
                                      : ConstantImages.mainLogo;
                              return userController.isProfileLoading.value
                                  ? const TShimmerEffect(
                                    width: 110,
                                    height: 110,
                                    radius: 100,
                                  )
                                  : Positioned(
                                    child: CustomRoundedImage(
                                      width: 110,
                                      height: 110,
                                      imageUrl: image,
                                      isNetworkImage: networkImage.isNotEmpty,
                                    ),
                                  );
                            }),
                            Positioned(
                              top: 0,
                              left: 250,
                              child: GestureDetector(
                                onTap:
                                    () =>
                                        userController
                                            .uploadUserProfilePicture(),
                                child: CustomCircularContainer(
                                  backgroundColor: ConstantColors.third,
                                  height: 36,
                                  width: 36,
                                  child: Icon(
                                    Icons.create,
                                    color: ConstantColors.secondary.withOpacity(
                                      0.5,
                                    ),
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: ConstantSizes.spaceBtwSections),
                      SettingsMenuTile(
                        text: 'Username',
                        subText: userController.user.value.username,
                        onTap: () {},
                        image: ConstantImages.userNameIcon,
                      ),
                      const SizedBox(height: ConstantSizes.spaceBtwSections),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: DiscoveryHeaders(text: 'USER INFORMATION'),
                      ),
                      const SizedBox(height: ConstantSizes.spaceBtwItems / 2),
                      SettingsMenuTile(
                        text: 'Email',
                        subText: userController.user.value.email,
                        onTap: () {},
                        image: ConstantImages.email2Icon,
                      ),
                      SettingsMenuTile(
                        text: 'First Name',
                        subText: userController.user.value.firstName,
                        onTap: () {},
                        image: ConstantImages.firstNameIcon,
                      ),
                      SettingsMenuTile(
                        text: 'Last Name',
                        subText: userController.user.value.lastName,
                        onTap: () {},
                        image: ConstantImages.lastNameIcon,
                      ),

                      Padding(
                        padding: const EdgeInsets.only(left: 15, top: 4),
                        child: DiscoveryHeaders(
                          text:
                              'All user data are private, will not be shared with anyone. You can delete your account at any time, just reach out to us.',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
