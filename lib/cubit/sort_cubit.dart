
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum SortOption { newestFirst, oldestFirst, titleAZ, titleZA }

class SortCubit extends Cubit<SortOption> {

  SortCubit(): super(SortOption.newestFirst){
    _loadSortPreference();
  }

  Future<void> _loadSortPreference() async {
    final prefs = await SharedPreferences.getInstance();
    final sortIndex = prefs.getInt('SortOption') ?? 0;
    emit(SortOption.values[sortIndex]);
  }

  Future<void> setSortOption(SortOption option) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('SortOption', option.index);  // ✅ FIXED: Save the NEW option
    emit(option);
  }

  String getSortLabel() {
    switch (state) {
      case SortOption.newestFirst:
        return 'Newest First';
      case SortOption.oldestFirst:
        return 'Oldest First';
      case SortOption.titleAZ:
        return 'Title (A-Z)';
      case SortOption.titleZA:
        return 'Title (Z-A)';
    }
  }
}