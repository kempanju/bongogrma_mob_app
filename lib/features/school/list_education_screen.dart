import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'school_provider.dart';
import '../../core/providers/app_providers.dart';

class ListEducationScreen extends ConsumerWidget {
  const ListEducationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appState = ref.watch(appStateProvider);
    final educationState = ref.watch(educationListProvider);

    if (!appState.isLoggedIn) {
      return Scaffold(
        appBar: AppBar(title: const Text('Education History')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.school_outlined, size: 64, color: Colors.grey[400]),
              const SizedBox(height: 16),
              const Text('Please login to view your education history'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Education History'),
      ),
      body: educationState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : educationState.educationList.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.school_outlined, size: 64, color: Colors.grey[400]),
                      const SizedBox(height: 16),
                      Text(
                        'No education history added',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton.icon(
                        onPressed: () => context.push('/school/search'),
                        icon: const Icon(Icons.add),
                        label: const Text('Add Education'),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: educationState.educationList.length,
                  itemBuilder: (context, index) {
                    final education = educationState.educationList[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: _getLevelColor(education.level),
                          child: Icon(
                            _getLevelIcon(education.level),
                            color: Colors.white,
                          ),
                        ),
                        title: Text(
                          education.schoolName,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(education.levelDisplayName),
                            Text(
                              education.yearRange,
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                          ],
                        ),
                        isThreeLine: true,
                        trailing: PopupMenuButton(
                          itemBuilder: (context) => [
                            const PopupMenuItem(
                              value: 'edit',
                              child: Text('Edit'),
                            ),
                            const PopupMenuItem(
                              value: 'delete',
                              child: Text('Delete'),
                            ),
                          ],
                          onSelected: (value) {
                            if (value == 'delete') {
                              ref
                                  .read(educationListProvider.notifier)
                                  .removeEducation(education.id);
                            }
                          },
                        ),
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/school/search'),
        icon: const Icon(Icons.add),
        label: const Text('Add Education'),
      ),
    );
  }

  Color _getLevelColor(String level) {
    switch (level) {
      case 'plevel':
        return Colors.green;
      case 'olevel':
        return Colors.blue;
      case 'college':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }

  IconData _getLevelIcon(String level) {
    switch (level) {
      case 'plevel':
        return Icons.child_care;
      case 'olevel':
        return Icons.school;
      case 'college':
        return Icons.account_balance;
      default:
        return Icons.school;
    }
  }
}
