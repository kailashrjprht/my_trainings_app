import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_trainings_app/home_screen/widgets/filter_bottom_sheet.dart';
import 'package:my_trainings_app/model/trainer_detail_model.dart';
import 'package:my_trainings_app/trainer_summary/trainer_summary_screen.dart';

class CarouselSliverAppbar extends StatelessWidget {
  // Required properties for the widget
  final String appbarTitle;
  final String heading;
  final CarouselController carouselController;
  final VoidCallback onSwiperBackButtonPressed;
  final VoidCallback onSwiperForwardButtonPressed;
  final TrainerDetail trainerDetail;
  const CarouselSliverAppbar({
    super.key,
    required this.appbarTitle,
    required this.heading,
    required this.carouselController,
    required this.onSwiperBackButtonPressed,
    required this.onSwiperForwardButtonPressed,
    required this.trainerDetail,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      // Configure SliverAppBar properties
      expandedHeight: 280.h,
      pinned: false,
      flexibleSpace: FlexibleSpaceBar(
        background: _buildAppBarContent(context, trainerDetail),
      ),
    );
  }

  // Build the main content of the AppBar
  Widget _buildAppBarContent(BuildContext context, TrainerDetail trainerDetail) {
    return Stack(
      children: [
        // Gradient Background
        _buildBackground(),

        // Main Content Column
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            _buildCarouselSection(context, trainerDetail),
            _buildFilterButton(context),
          ],
        ),
      ],
    );
  }

  // Gradient background container
  Widget _buildBackground() {
    return Container(
      height: 200.h,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.red.shade400,
            Colors.red.shade400,
          ],
        ),
      ),
    );
  }

  // Header section with title
  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.only(top: 16.h, left: 16.w),
      child: Text(
        appbarTitle,
        style: TextStyle(
          color: Colors.white,
          fontSize: 24.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // Carousel section with navigation buttons
  Widget _buildCarouselSection(BuildContext context, TrainerDetail trainerDetail) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Heading
        Padding(
          padding: EdgeInsets.all(16.w),
          child: Text(
            heading,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),

        // Carousel with navigation
        Stack(
          alignment: Alignment.center,
          children: [
            // Carousel Slider
            CarouselSlider(
              carouselController: carouselController,
              options: CarouselOptions(
                height: 120.h,
                viewportFraction: 0.92,
                enableInfiniteScroll: true,
              ),
              items: _buildCarouselItems(context, trainerDetail),
            ),

            // Navigation Buttons
            _buildNavigationButtons(),
          ],
        ),
      ],
    );
  }

  // Build carousel items
  List<Widget> _buildCarouselItems(BuildContext context, TrainerDetail trainerDetail) {
    return List.generate(
      3, // Number of slides
      (index) => GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => TrainerSummaryScreen(trainerDetail: trainerDetail)));
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 8.w),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: Image.asset(
              "assets/slider_image.png",
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }

  // Navigation buttons for carousel
  Widget _buildNavigationButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildNavigationButton(
          onPressed: onSwiperBackButtonPressed,
          icon: Icons.arrow_back_ios,
          isRight: true,
        ),
        _buildNavigationButton(
          onPressed: onSwiperForwardButtonPressed,
          icon: Icons.arrow_forward_ios,
          isRight: false,
        ),
      ],
    );
  }

  // Single navigation button
  Widget _buildNavigationButton({required VoidCallback onPressed, required IconData icon, required isRight}) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 70.h,
        width: 20.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: const Color.fromARGB(110, 0, 0, 0),
          borderRadius: isRight!
              ? BorderRadius.only(topRight: Radius.circular(10.r), bottomRight: Radius.circular(10.r))
              : BorderRadius.only(topLeft: Radius.circular(10.r), bottomLeft: Radius.circular(10.r)),
        ),
        child: Icon(
          icon,
          color: Colors.white,
        ),
      ),
    );
  }

  // Filter button
  Widget _buildFilterButton(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: SizedBox(
          height: 30.h,
          width: 70.w,
          child: IconButton.outlined(
            style: IconButton.styleFrom(
              side: const BorderSide(color: Colors.grey),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            onPressed: () => showFilterBottomSheet(context),
            icon: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(Icons.filter_list, size: 16.w),
                Text('Filter', style: TextStyle(fontSize: 12.sp)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
