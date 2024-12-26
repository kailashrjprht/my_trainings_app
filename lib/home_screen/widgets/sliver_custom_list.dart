import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_trainings_app/model/trainer_detail_model.dart';
import 'package:my_trainings_app/trainer_summary/trainer_summary_screen.dart';

class CustomSliverList extends StatelessWidget {
  final List<TrainerDetail>? trainerDetailList;
  const CustomSliverList({super.key, required this.trainerDetailList});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) => _buildTrainerCard(context, trainerDetailList![index]),
        childCount: trainerDetailList!.length,
      ),
    );
  }

  /// Builds the main trainer card widget
  Widget _buildTrainerCard(BuildContext context, TrainerDetail trainerDetail) {
    return Container(
      height: 135.h,
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: _cardDecoration(),
      child: Row(
        children: [
          _buildLeftSection(context, trainerDetail),
          _buildDivider(),
          _buildRightSection(context, trainerDetail),
        ],
      ),
    );
  }

  /// Card decoration with shadow
  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          spreadRadius: 2,
          blurRadius: 5,
          offset: const Offset(0, 3),
        ),
      ],
    );
  }

  /// Left section with date and time (35% width)
  Widget _buildLeftSection(BuildContext context, TrainerDetail trainerDetail) {
    return SizedBox(
      width: 125.w,
      child: Padding(
        padding: EdgeInsets.all(12.dg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              trainerDetail.date,
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4.h),
            Text(
              trainerDetail.time,
              style: TextStyle(fontSize: 10.sp, color: Colors.grey),
            ),
            const Spacer(),
            Text(
              trainerDetail.venue,
              style: TextStyle(fontSize: 14.sp, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  /// Custom dotted divider
  Widget _buildDivider() {
    return CustomPaint(
      size: Size(1.w, 100.h),
      painter: DottedLinePainter(),
    );
  }

  /// Right section with trainer details and enroll button
  Widget _buildRightSection(BuildContext context, TrainerDetail trainerDetail) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(12.dg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              trainerDetail.status,
              style: TextStyle(color: Colors.red.shade300, fontSize: 12.sp),
            ),
            SizedBox(height: 4.h),
            Text(
              trainerDetail.title,
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.h),
            _buildTrainerInfo(trainerDetail),
            const Spacer(),
            _buildEnrollButton(context, trainerDetail),
          ],
        ),
      ),
    );
  }

  /// Trainer profile section
  Widget _buildTrainerInfo(TrainerDetail trainerDetail) {
    return Row(
      children: [
        CircleAvatar(
          radius: 15.r,
          backgroundImage: AssetImage(trainerDetail.trainerProfile),
        ),
        SizedBox(width: 8.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              trainerDetail.trainerName,
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
            ),
            Row(
              children: [
                Icon(Icons.location_on, size: 12.h, color: Colors.grey),
                SizedBox(width: 4.w),
                Text(
                  trainerDetail.trainerLocation,
                  style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  /// Enroll button with conditional styling
  Widget _buildEnrollButton(BuildContext context, TrainerDetail trainerDetail) {
    return Align(
      alignment: Alignment.bottomRight,
      child: SizedBox(
        height: 23.h,
        width: 110.w,
        child: ElevatedButton(
          onPressed: () {
            if (trainerDetail.isOpen) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TrainerSummaryScreen(
                    trainerDetail: trainerDetail,
                  ),
                ),
              );
            }
          },
          style: ElevatedButton.styleFrom(
            elevation: trainerDetail.isOpen ? 1 : 0,
            backgroundColor: trainerDetail.isOpen ? const Color.fromARGB(255, 255, 96, 96) : Colors.grey,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          child: Text(
            'Enroll Now',
            maxLines: 1,
            style: TextStyle(color: Colors.white, fontSize: 11.sp),
          ),
        ),
      ),
    );
  }
}

/// Custom painter for dotted divider line
class DottedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey.shade300
      ..strokeWidth = 1
      ..strokeCap = StrokeCap.round;

    const dashHeight = 5;
    const dashSpace = 3;
    double startY = 0;

    while (startY < size.height) {
      canvas.drawLine(
        Offset(0, startY),
        Offset(0, startY + dashHeight),
        paint,
      );
      startY += dashHeight + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
