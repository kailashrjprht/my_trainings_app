import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:my_trainings_app/home_screen/provider/home_screen_provider.dart';
import 'package:my_trainings_app/home_screen/widgets/sliver_custom_appbar.dart';
import 'package:my_trainings_app/home_screen/widgets/sliver_custom_list.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CarouselController carouselController = CarouselController();

  @override
  void initState() {
    super.initState();
    final homeProvider = Provider.of<HomeScreenProvider>(context, listen: false);
    homeProvider.getTrainerDetails();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Consumer<HomeScreenProvider>(builder: (context, homeProvider, _) {
          return CustomScrollView(
            slivers: [
              // Custom sliver app bar with Carousel Swiper to show highlight section
              CarouselSliverAppbar(
                appbarTitle: 'Trainings',
                heading: 'Highlight',
                carouselController: carouselController,
                onSwiperBackButtonPressed: () => carouselController.previousPage(),
                onSwiperForwardButtonPressed: () => carouselController.nextPage(),
                trainerDetail: homeProvider.trainerDataList[0],
              ),

              // Custom sliver List  with custom Trainings card for data trainers detail presentation
              CustomSliverList(
                trainerDetailList:
                    homeProvider.filteredTrainerDataList.isNotEmpty ? homeProvider.filteredTrainerDataList : homeProvider.trainerDataList,
              ),
            ],
          );
        }),
      ),
    );
  }
}
