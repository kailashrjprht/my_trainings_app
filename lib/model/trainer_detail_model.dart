class TrainerDetail {
  final String date;
  final String time;
  final String venue;
  final String status;
  final String title;
  final String trainerName;
  final String trainerProfile;
  final String trainerLocation;
  final bool isOpen;

  TrainerDetail({
    required this.date,
    required this.time,
    required this.venue,
    required this.status,
    required this.title,
    required this.trainerProfile,
    required this.trainerLocation,
    required this.trainerName,
    required this.isOpen,
  });

  // From JSON
  factory TrainerDetail.fromJson(Map<String, dynamic> json) {
    return TrainerDetail(
      date: json['date'] as String,
      time: json['time'] as String,
      venue: json['venue'] as String,
      status: json['status'] as String,
      title: json['title'] as String,
      trainerProfile: json['trainerProfile'] as String,
      trainerLocation: json['trainerLocation'] as String,
      trainerName: json['trainerName'] as String,
      isOpen: json['isOpen'] as bool,
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'time': time,
      'venue': venue,
      'status': status,
      'title': title,
      'trainerProfile': trainerProfile,
      'trainerLocation': trainerLocation,
      'trainerName': trainerName,
      'isOpen': isOpen,
    };
  }
}
