import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchController = TextEditingController();
  final _focusNode = FocusNode();
  final List<String> _recentSearches = ['Tanzania', 'Football', 'Music', 'Politics'];
  List<Map<String, dynamic>> _searchResults = [];
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _focusNode.requestFocus();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  Future<void> _performSearch(String query) async {
    if (query.isEmpty) {
      setState(() {
        _searchResults = [];
        _isSearching = false;
      });
      return;
    }

    setState(() => _isSearching = true);

    // Simulated search
    await Future.delayed(const Duration(milliseconds: 500));

    setState(() {
      _searchResults = List.generate(
        5,
        (index) => {
          'id': index + 1,
          'title': 'Search result for "$query" - Item ${index + 1}',
          'type': index % 2 == 0 ? 'article' : 'user',
        },
      );
      _isSearching = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: TextField(
          controller: _searchController,
          focusNode: _focusNode,
          decoration: InputDecoration(
            hintText: 'Search articles, users...',
            border: InputBorder.none,
            filled: false,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            suffixIcon: _searchController.text.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      _searchController.clear();
                      _performSearch('');
                    },
                  )
                : null,
          ),
          onChanged: _performSearch,
          onSubmitted: (value) {
            if (value.isNotEmpty && !_recentSearches.contains(value)) {
              setState(() {
                _recentSearches.insert(0, value);
                if (_recentSearches.length > 10) {
                  _recentSearches.removeLast();
                }
              });
            }
          },
        ),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isSearching) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_searchResults.isNotEmpty) {
      return ListView.builder(
        itemCount: _searchResults.length,
        itemBuilder: (context, index) {
          final result = _searchResults[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: result['type'] == 'article' 
                  ? Colors.blue[100] 
                  : Colors.green[100],
              child: Icon(
                result['type'] == 'article' ? Icons.article : Icons.person,
                color: result['type'] == 'article' ? Colors.blue : Colors.green,
              ),
            ),
            title: Text(result['title'] as String),
            subtitle: Text(result['type'] == 'article' ? 'Article' : 'User'),
            onTap: () {
              if (result['type'] == 'article') {
                context.push('/post/${result['id']}', extra: result['title']);
              }
            },
          );
        },
      );
    }

    // Show recent searches
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (_recentSearches.isNotEmpty) ...[
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Recent Searches',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setState(() => _recentSearches.clear());
                  },
                  child: const Text('Clear All'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _recentSearches.length,
              itemBuilder: (context, index) {
                final search = _recentSearches[index];
                return ListTile(
                  leading: const Icon(Icons.history),
                  title: Text(search),
                  trailing: IconButton(
                    icon: const Icon(Icons.close, size: 18),
                    onPressed: () {
                      setState(() => _recentSearches.removeAt(index));
                    },
                  ),
                  onTap: () {
                    _searchController.text = search;
                    _performSearch(search);
                  },
                );
              },
            ),
          ),
        ] else
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.search, size: 64, color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  Text(
                    'Search for articles and users',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
