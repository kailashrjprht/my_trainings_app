import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_trainings_app/home_screen/provider/home_screen_provider.dart';
import 'package:my_trainings_app/model/trainer_detail_model.dart';
import 'package:provider/provider.dart';

enum FilterType { sortBy, location, trainingName, trainer }

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({super.key});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  FilterType selectedFilter = FilterType.sortBy;
  String searchQuery = '';
  Map<FilterType, List<String>> filterOptions = {};
  Map<String, List<String>> selectedFilters = {};
  List<TrainerDetail> filteredTrainerList = [];
  List<TrainerDetail> originalTrainerList = [];

  @override
  void initState() {
    super.initState();
    final homeProvider = Provider.of<HomeScreenProvider>(context, listen: false);
    originalTrainerList = homeProvider.getTrainerDetails();
    fetchDataFromTrainerDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450.h,
      padding: EdgeInsets.all(14.dg),
      child: Column(
        children: [
          _buildHeader(),
          const Divider(),
          Expanded(
            child: Row(
              children: [
                _buildFilterCategories(),
                SizedBox(width: 10.w),
                _buildFilterOptions(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Sort and Filters',
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
        ),
        IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }

  Widget _buildFilterCategories() {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.4,
      child: ListView.builder(
        itemCount: FilterType.values.length,
        itemBuilder: (context, index) {
          final filter = FilterType.values[index];
          return _buildFilterCategoryTile(filter);
        },
      ),
    );
  }

  Widget _buildFilterCategoryTile(FilterType filter) {
    return ListTile(
      selected: selectedFilter == filter,
      selectedTileColor: const Color.fromARGB(255, 255, 96, 96).withOpacity(0.1),
      title: Text(
        _getFilterTitle(filter),
        style: TextStyle(
          fontWeight: selectedFilter == filter ? FontWeight.bold : FontWeight.normal,
          fontSize: 14,
          color: Colors.black,
        ),
      ),
      onTap: () => setState(() => selectedFilter = filter),
    );
  }

  String _getFilterTitle(FilterType filter) {
    switch (filter.name.toString()) {
      case "sortBy":
        return "Sort By";
      case "location":
        return "Location";
      case "trainingName":
        return "Training Name";
      case "trainer":
        return "Trainer";
      default:
        return filter.toString().split('.').last;
    }
  }

  Widget _buildFilterOptions() {
    return Expanded(
      child: Column(
        children: [
          _buildSearchBar(),
          SizedBox(height: 16.h),
          _buildFilterOptionsList(),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return TextFormField(
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(2.dg),
        hintText: 'Search',
        prefixIcon: const Icon(Icons.search),
        border: const OutlineInputBorder(),
      ),
      textInputAction: TextInputAction.done,
      onFieldSubmitted: (_) => FocusScope.of(context).unfocus(),
      onChanged: (value) => setState(() => searchQuery = value),
    );
  }

  Widget _buildFilterOptionsList() {
    return Expanded(
      child: Consumer<HomeScreenProvider>(
        builder: (context, homeProvider, _) {
          return ListView.builder(
            itemCount: filterOptions[selectedFilter]!.length,
            itemBuilder: (context, index) {
              final option = filterOptions[selectedFilter]![index];
              return _buildFilterOptionItem(option, homeProvider);
            },
          );
        },
      ),
    );
  }

  Widget _buildFilterOptionItem(String option, HomeScreenProvider homeProvider) {
    final isSelected = selectedFilters[selectedFilter.toString()]?.contains(option) ?? false;

    if (searchQuery.isEmpty || option.toLowerCase().contains(searchQuery.toLowerCase())) {
      return CheckboxListTile(
        title: Text(
          option,
          style: TextStyle(fontSize: 12.sp),
        ),
        controlAffinity: ListTileControlAffinity.leading,
        value: isSelected,
        onChanged: (bool? value) => _handleFilterOptionChange(value, option, homeProvider),
      );
    }
    return const SizedBox.shrink();
  }

  void _handleFilterOptionChange(bool? value, String option, HomeScreenProvider homeProvider) {
    setState(() {
      final filterKey = selectedFilter.toString();
      selectedFilters[filterKey] ??= [];
      if (value ?? false) {
        selectedFilters[filterKey]!.add(option);
      } else {
        selectedFilters[filterKey]!.remove(option);
      }
      updateFilters(homeProvider);
    });
  }

  void fetchDataFromTrainerDetails() {
    // Assuming you have access to the original list
    setState(() {
      filterOptions = {
        FilterType.sortBy: ['Latest First', 'Oldest First'],
        FilterType.location: originalTrainerList.map((e) => e.trainerLocation).toSet().toList(),
        FilterType.trainingName: originalTrainerList.map((e) => e.title).toSet().toList(),
        FilterType.trainer: originalTrainerList.map((e) => e.trainerName).toSet().toList(),
      };
    });
  }

  void updateFilters(HomeScreenProvider homeProvider) {
    selectedFilters.forEach((key, values) {
      if (values.isNotEmpty) {
        FilterType type = FilterType.values.firstWhere((e) => e.toString() == key);

        applyFilters(type, values, homeProvider);
      }
    });
  }

  void applyFilters(FilterType type, List<String> selectedValues, HomeScreenProvider homeProvider) {
    if (selectedValues.isEmpty) {
      filteredTrainerList = List.from(originalTrainerList);
      return;
    }

    filteredTrainerList = originalTrainerList.where((trainer) {
      switch (type) {
        case FilterType.sortBy:
          if (selectedValues.contains('Latest First')) {
            filteredTrainerList.sort((a, b) => b.date.compareTo(a.date));
          } else {
            filteredTrainerList.sort((a, b) => a.date.compareTo(b.date));
          }
          return true;
        case FilterType.location:
          return selectedValues.contains(trainer.trainerLocation);
        case FilterType.trainingName:
          return selectedValues.contains(trainer.title);
        case FilterType.trainer:
          return selectedValues.contains(trainer.trainerName);
      }
    }).toList();
    homeProvider.filteredTrainerDataList = filteredTrainerList;
    homeProvider.notifyfilteredTrainerDataList();
    onApplyPressed();
  }

  void onApplyPressed() {
    Navigator.pop(context);
  }
}

showFilterBottomSheet(BuildContext context) async {
  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) => const FilterBottomSheet());
}
