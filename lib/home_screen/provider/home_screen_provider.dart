import 'package:flutter/material.dart';
import 'package:my_trainings_app/model/trainer_detail_model.dart';

class HomeScreenProvider with ChangeNotifier {
  List<TrainerDetail> trainerDataList = [];
  List<TrainerDetail> filteredTrainerDataList = [];

  notifyfilteredTrainerDataList() {
    notifyListeners();
  }

  //
  List<TrainerDetail> getTrainerDetails() {
    trainerDataList = dummyData.map((json) => TrainerDetail.fromJson(json)).toList();
    return trainerDataList;
  }

//
  final List<Map<String, dynamic>> dummyData = [
    {
      "date": "Nov 15-18",
      "time": "2:00 PM - 4:00 PM",
      "venue": "Room 201",
      "status": "Filing Fast!",
      "title": "Safe Scrum Master(4.9)",
      "trainerName": "John Kransinki",
      "trainerProfile": "assets/dummy.jpeg",
      "trainerLocation": "London",
      "isOpen": true
    },
    {
      "date": "Oct 11-13",
      "time": "10:30 AM - 12:30 PM",
      "venue": "Main Hall",
      "status": "Closed!",
      "title": "Safe Scrum Master(4.6)",
      "trainerName": "John Cena",
      "trainerProfile": "assets/dummy.jpeg",
      "trainerLocation": "New York",
      "isOpen": false
    },
    {
      "date": "Dec 19-21",
      "time": "11:30 AM - 1:30 PM",
      "venue": "Conference Room",
      "status": "Early Bird!",
      "title": "Safe Scrum Master(3.6)",
      "trainerName": "John karmer",
      "trainerProfile": "assets/dummy.jpeg",
      "trainerLocation": "San Francisco",
      "isOpen": true
    },
    {
      "date": "Jan 19-21",
      "time": "11:30 AM - 1:30 PM",
      "venue": "Conference Room",
      "status": "Early Bird!",
      "title": "Safe Scrum Master(5.0)",
      "trainerName": "John jose",
      "trainerProfile": "assets/dummy.jpeg",
      "trainerLocation": "San Francisco",
      "isOpen": true
    },
    {
      "date": "Feb 19-21",
      "time": "11:30 AM - 1:30 PM",
      "venue": "Conference Room",
      "status": "Early Bird!",
      "title": "Safe Scrum Master(3.0)",
      "trainerName": "John david",
      "trainerProfile": "assets/dummy.jpeg",
      "trainerLocation": "San Francisco",
      "isOpen": true
    },
    {
      "date": "Mar 19-21",
      "time": "11:30 AM - 1:30 PM",
      "venue": "Conference Room",
      "status": "Early Bird!",
      "title": "Safe Scrum Master(4.1)",
      "trainerName": "John jose",
      "trainerProfile": "assets/dummy.jpeg",
      "trainerLocation": "San Francisco",
      "isOpen": true
    }
  ];
}
