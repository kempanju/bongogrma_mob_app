import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/school.dart';

class SchoolSearchState {
  final List<School> schools;
  final bool isLoading;
  final String? errorMessage;
  final String searchQuery;

  SchoolSearchState({
    this.schools = const [],
    this.isLoading = false,
    this.errorMessage,
    this.searchQuery = '',
  });

  SchoolSearchState copyWith({
    List<School>? schools,
    bool? isLoading,
    String? errorMessage,
    String? searchQuery,
  }) {
    return SchoolSearchState(
      schools: schools ?? this.schools,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}

class SchoolSearchNotifier extends StateNotifier<SchoolSearchState> {
  SchoolSearchNotifier() : super(SchoolSearchState()) {
    loadInitialSchools();
  }

  Future<void> loadInitialSchools() async {
    state = state.copyWith(isLoading: true);

    try {
      // Simulated API call - replace with actual API
      await Future.delayed(const Duration(milliseconds: 500));

      final sampleSchools = [
        School(id: 1, name: 'Mzumbe', location: 'Morogoro', type: 3, memberCount: 1250),
        School(id: 2, name: 'University of Dar es Salaam', location: 'Dar es Salaam', type: 3, memberCount: 3500),
        School(id: 3, name: 'Azania Secondary', location: 'Dar es Salaam', type: 2, memberCount: 890),
        School(id: 4, name: 'Ilboru Secondary', location: 'Arusha', type: 2, memberCount: 720),
        School(id: 5, name: 'Jangwani Primary', location: 'Dar es Salaam', type: 1, memberCount: 450),
      ];

      state = state.copyWith(
        schools: sampleSchools,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> searchSchools(String query) async {
    if (query.length < 3) {
      loadInitialSchools();
      return;
    }

    state = state.copyWith(isLoading: true, searchQuery: query);

    try {
      // Simulated API call
      await Future.delayed(const Duration(milliseconds: 300));

      // Filter sample data based on query
      final filteredSchools = [
        School(id: 1, name: 'Mzumbe University', location: 'Morogoro', type: 3, memberCount: 1250),
        School(id: 2, name: 'University of Dar es Salaam', location: 'Dar es Salaam', type: 3, memberCount: 3500),
      ].where((s) => s.name.toLowerCase().contains(query.toLowerCase())).toList();

      state = state.copyWith(
        schools: filteredSchools,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
    }
  }
}

final schoolSearchProvider =
    StateNotifierProvider<SchoolSearchNotifier, SchoolSearchState>((ref) {
  return SchoolSearchNotifier();
});

// Education List Provider
class EducationListState {
  final List<Education> educationList;
  final bool isLoading;
  final String? errorMessage;

  EducationListState({
    this.educationList = const [],
    this.isLoading = false,
    this.errorMessage,
  });

  EducationListState copyWith({
    List<Education>? educationList,
    bool? isLoading,
    String? errorMessage,
  }) {
    return EducationListState(
      educationList: educationList ?? this.educationList,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}

class EducationListNotifier extends StateNotifier<EducationListState> {
  EducationListNotifier() : super(EducationListState()) {
    loadEducation();
  }

  Future<void> loadEducation() async {
    state = state.copyWith(isLoading: true);

    try {
      await Future.delayed(const Duration(milliseconds: 500));

      // Sample education data
      final sampleEducation = [
        Education(
          id: 1,
          schoolId: 1,
          schoolName: 'Mzumbe University',
          startYear: 2015,
          endYear: 2019,
          level: 'college',
        ),
        Education(
          id: 2,
          schoolId: 3,
          schoolName: 'Azania Secondary School',
          startYear: 2011,
          endYear: 2014,
          level: 'olevel',
        ),
      ];

      state = state.copyWith(
        educationList: sampleEducation,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> addEducation(Education education) async {
    state = state.copyWith(
      educationList: [...state.educationList, education],
    );
  }

  Future<void> removeEducation(int id) async {
    state = state.copyWith(
      educationList: state.educationList.where((e) => e.id != id).toList(),
    );
  }
}

final educationListProvider =
    StateNotifierProvider<EducationListNotifier, EducationListState>((ref) {
  return EducationListNotifier();
});
