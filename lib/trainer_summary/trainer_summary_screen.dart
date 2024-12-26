import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_trainings_app/model/trainer_detail_model.dart';

class TrainerSummaryScreen extends StatefulWidget {
  final TrainerDetail? trainerDetail;
  const TrainerSummaryScreen({super.key, this.trainerDetail});

  @override
  State<TrainerSummaryScreen> createState() => _TrainerSummaryScreenState();
}

class _TrainerSummaryScreenState extends State<TrainerSummaryScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(),
        body: _buildBody(),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: true,
      title: Text(widget.trainerDetail!.title),
    );
  }

  Widget _buildBody() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(16.dg),
          child: SizedBox(
            height: 570.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTrainerProfile(),
                SizedBox(height: 24.sp),
                _buildSummarySection(),
                SizedBox(height: 24.sp),
                _buildLectureOverview(),
                const Spacer(),
                _buildEnrollButton(),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _buildTrainerProfile() {
    return Row(
      children: [
        CircleAvatar(
          radius: 40.r,
          backgroundImage: AssetImage(widget.trainerDetail!.trainerProfile),
        ),
        SizedBox(width: 16.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.trainerDetail!.trainerName,
              style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSummarySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Summary',
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16.h),
        Text(
          "Master Agile Scrum methodology through hands-on practice. From fundamentals to advanced concepts including Sprint Planning, Daily Stand-ups, Product Backlogs, and Scrum Ceremonies, preparing you for real-world project management.",
          style: TextStyle(fontSize: 16.sp),
        ),
      ],
    );
  }

  Widget _buildLectureOverview() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Lecture Overview',
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16.h),
        const ListTile(
          leading: Icon(Icons.check_circle),
          title: Text('Agile Methodologies'),
          subtitle: Text('20 lectures'),
        ),
        const ListTile(
          leading: Icon(Icons.check_circle),
          title: Text('Task Assigning'),
          subtitle: Text('15 lectures'),
        ),
      ],
    );
  }

  Widget _buildEnrollButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Enrolled")),
          );
        },
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 16.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
        child: const Text('Enroll Now'),
      ),
    );
  }
}
