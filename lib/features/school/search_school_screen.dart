import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'school_provider.dart';
import '../../data/models/school.dart';

class SearchSchoolScreen extends ConsumerStatefulWidget {
  const SearchSchoolScreen({super.key});

  @override
  ConsumerState<SearchSchoolScreen> createState() => _SearchSchoolScreenState();
}

class _SearchSchoolScreenState extends ConsumerState<SearchSchoolScreen> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final schoolState = ref.watch(schoolSearchProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Search School'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Tafuta shule uliosomea...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          ref.read(schoolSearchProvider.notifier).loadInitialSchools();
                        },
                      )
                    : null,
              ),
              onChanged: (value) {
                if (value.length > 2) {
                  ref.read(schoolSearchProvider.notifier).searchSchools(value);
                }
                setState(() {});
              },
            ),
          ),
          if (schoolState.schools.isEmpty && !schoolState.isLoading)
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.school_outlined, size: 64, color: Colors.grey[400]),
                    const SizedBox(height: 16),
                    Text(
                      'Tafuta shule uliosomea hapo juu\nna ujiunge na uliosoma nao.',
                      style: TextStyle(color: Colors.grey[600]),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            )
          else
            Expanded(
              child: schoolState.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.separated(
                      itemCount: schoolState.schools.length,
                      separatorBuilder: (context, index) => const Divider(height: 1),
                      itemBuilder: (context, index) {
                        final school = schoolState.schools[index];
                        return _SchoolListItem(
                          school: school,
                          onTap: () => _onSchoolSelected(school),
                        );
                      },
                    ),
            ),
        ],
      ),
    );
  }

  void _onSchoolSelected(School school) {
    // Navigate to add education or return selected school
    showModalBottomSheet(
      context: context,
      builder: (context) => _YearSelectionSheet(
        school: school,
        onYearSelected: (startYear, endYear) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Added ${school.displayName} ($startYear - $endYear)')),
          );
        },
      ),
    );
  }
}

class _SchoolListItem extends StatelessWidget {
  final School school;
  final VoidCallback onTap;

  const _SchoolListItem({
    required this.school,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: _getLevelColor(school.type),
        child: Icon(
          _getLevelIcon(school.type),
          color: Colors.white,
          size: 20,
        ),
      ),
      title: Text(
        school.name,
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (school.location != null)
            Text(school.location!),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                margin: const EdgeInsets.only(top: 4),
                decoration: BoxDecoration(
                  color: _getLevelColor(school.type).withAlpha(25),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  school.levelName,
                  style: TextStyle(
                    fontSize: 11,
                    color: _getLevelColor(school.type),
                  ),
                ),
              ),
              if (school.memberCount != null) ...[
                const SizedBox(width: 8),
                Text(
                  '${school.memberCount} members',
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
              ],
            ],
          ),
        ],
      ),
      isThreeLine: true,
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }

  Color _getLevelColor(int type) {
    switch (type) {
      case 1:
        return Colors.green;
      case 2:
        return Colors.blue;
      case 3:
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }

  IconData _getLevelIcon(int type) {
    switch (type) {
      case 1:
        return Icons.child_care;
      case 2:
        return Icons.school;
      case 3:
        return Icons.account_balance;
      default:
        return Icons.school;
    }
  }
}

class _YearSelectionSheet extends StatefulWidget {
  final School school;
  final Function(int startYear, int endYear) onYearSelected;

  const _YearSelectionSheet({
    required this.school,
    required this.onYearSelected,
  });

  @override
  State<_YearSelectionSheet> createState() => _YearSelectionSheetState();
}

class _YearSelectionSheetState extends State<_YearSelectionSheet> {
  late int _startYear;
  late int _endYear;
  final int _currentYear = DateTime.now().year;

  @override
  void initState() {
    super.initState();
    _startYear = _currentYear - 4;
    _endYear = _currentYear;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Add Education',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            widget.school.displayName,
            style: TextStyle(color: Colors.grey[600]),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Start Year'),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<int>(
                      initialValue: _startYear,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      ),
                      items: List.generate(50, (i) => _currentYear - i)
                          .map((year) => DropdownMenuItem(
                                value: year,
                                child: Text('$year'),
                              ))
                          .toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() => _startYear = value);
                        }
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('End Year'),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<int>(
                      initialValue: _endYear,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      ),
                      items: List.generate(50, (i) => _currentYear - i + 4)
                          .where((year) => year >= _startYear)
                          .map((year) => DropdownMenuItem(
                                value: year,
                                child: Text('$year'),
                              ))
                          .toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() => _endYear = value);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => widget.onYearSelected(_startYear, _endYear),
              child: const Text('Add Education'),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
