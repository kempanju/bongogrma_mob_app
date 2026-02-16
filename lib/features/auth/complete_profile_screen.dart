import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'auth_provider.dart';
import '../../core/constants/api_constants.dart';

class CompleteProfileScreen extends ConsumerStatefulWidget {
  const CompleteProfileScreen({super.key});

  @override
  ConsumerState<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends ConsumerState<CompleteProfileScreen> {
  final _fullNameController = TextEditingController();
  final _summaryController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  int _selectedGender = 0;
  String? _profileImageUrl;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() {
    final authState = ref.read(authProvider);
    if (authState.user != null) {
      _fullNameController.text = authState.user!.name ?? '';
      _profileImageUrl = authState.user!.profilePic;
    }
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _summaryController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    // Image picker would go here
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Image picker not implemented yet')),
    );
  }

  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) return;

    final success = await ref.read(authProvider.notifier).updateProfile(
          fullName: _fullNameController.text.trim(),
          summary: _summaryController.text.trim(),
          gender: _selectedGender,
        );

    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully!')),
      );
      context.go('/');
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Complete Profile'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Profile Image
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.grey[200],
                      backgroundImage: _profileImageUrl != null
                          ? CachedNetworkImageProvider(
                              '${ApiConstants.photoPath}/$_profileImageUrl',
                            )
                          : null,
                      child: _profileImageUrl == null
                          ? Icon(Icons.person, size: 60, color: Colors.grey[400])
                          : null,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: _pickImage,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Center(
                child: TextButton(
                  onPressed: _pickImage,
                  child: const Text('Change Profile Picture'),
                ),
              ),
              const SizedBox(height: 24),

              // Full Name
              TextFormField(
                controller: _fullNameController,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  prefixIcon: Icon(Icons.person_outlined),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your full name';
                  }
                  if (value.length < 3) {
                    return 'Name must be at least 3 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Summary/Bio
              TextFormField(
                controller: _summaryController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'About You',
                  hintText: 'Tell us about yourself...',
                  prefixIcon: Icon(Icons.info_outlined),
                  alignLabelWithHint: true,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please provide a short bio';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Gender
              DropdownButtonFormField<int>(
                initialValue: _selectedGender,
                decoration: const InputDecoration(
                  labelText: 'Gender',
                  prefixIcon: Icon(Icons.people_outlined),
                ),
                items: const [
                  DropdownMenuItem(value: 0, child: Text('Select Gender')),
                  DropdownMenuItem(value: 1, child: Text('Male')),
                  DropdownMenuItem(value: 2, child: Text('Female')),
                  DropdownMenuItem(value: 3, child: Text('Other')),
                ],
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _selectedGender = value);
                  }
                },
              ),
              const SizedBox(height: 32),

              // Save Button
              ElevatedButton(
                onPressed: authState.isLoading ? null : _saveProfile,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: authState.isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Save Profile'),
              ),

              if (authState.errorMessage != null) ...[
                const SizedBox(height: 16),
                Text(
                  authState.errorMessage!,
                  style: const TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
