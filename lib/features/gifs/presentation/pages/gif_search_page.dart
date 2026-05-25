import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import '../../data/gif_repository.dart';
import '../../data/giphy_api.dart';
import '../../data/models/gif_item.dart';

class GifSearchPage extends StatefulWidget {
  const GifSearchPage({super.key});

  @override
  State<GifSearchPage> createState() => _GifSearchPageState();
}
class _GifSearchPageState extends State<GifSearchPage> {
  final ScrollController _scrollController = ScrollController();
  String _currentQuery = '';
  int _offset = 0;
  final int _limit = 25;
  bool _isLoadingMore = false;
  bool _hasMoreResults = true;
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounceTimer;
  late final GifRepository _repository;
  List<GifItem> _gifs = [];
  bool _isLoading = false;
  String? _errorMessage;
  @override
  void initState() {
    super.initState();
    final dio = Dio();
    final api = GiphyApi(dio);
    _repository = GifRepository(api);
    _scrollController.addListener(() {
      final isNearBottom = _scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 300;
      if(isNearBottom) {
        _loadMoreGifs();
      }
    });
}
  @override
  void dispose() {
    _searchController.dispose();
    _debounceTimer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }
  void _onSearchChanged(String value) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      _searchGifs(value);
    });
  }
  Future<void> _searchGifs(String query) async {
    final cleanQuery = query.trim();
    if (cleanQuery.isEmpty) {
      setState(() {
        _currentQuery = '';
        _gifs = [];
        _offset = 0;
        _hasMoreResults = true;
        _errorMessage = null;
      });
      return;
  }
  setState(() {
    _currentQuery = cleanQuery;
    _offset = 0;
    _hasMoreResults = true;
    _isLoading = true;
    _errorMessage = null;
  });
  try {
    final gifs = await _repository.searchGifs(query: cleanQuery);
    if(!mounted) return;
    setState(() {
      _gifs = gifs;
      _offset = gifs.length;
      _hasMoreResults = gifs.length == _limit;
      _isLoading = false;
    });
  } catch (error) {
    if(!mounted) return;
    setState(() {
      _isLoading = false;
      _errorMessage = error.toString();
    });
  }
  }
  Future<void> _loadMoreGifs() async {
    if (_currentQuery.isEmpty || _isLoading || _isLoadingMore || !_hasMoreResults) {
      return;
    }
    setState(() {
      _isLoadingMore = true;
    });
    try {
      final newGifs = await _repository.searchGifs(
        query: _currentQuery,
        limit: _limit,
        offset: _offset,
      );
      if(!mounted) return;
      setState(() {
        _gifs.addAll(newGifs);
        _offset += newGifs.length;
        _hasMoreResults = newGifs.length == _limit;
        _isLoadingMore = false;
      });
    } catch (error) {
      if(!mounted) return;
      setState(() {
        _isLoadingMore = false;
        _errorMessage = error.toString();
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Giphy search"),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(
                  controller: _searchController,
                  onChanged: _onSearchChanged,
                  decoration: InputDecoration(
                    hintText:'Search Gifs...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                   ),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: _buildBody(),
                  ),
              ],)))
    );
  }
  Widget _buildBody() {
    if(_isLoading) {
      return const Center(
        child:CircularProgressIndicator(),
      );
    }
    if(_errorMessage != null){
      return Center(
        child: Text(
          _errorMessage!,
          textAlign:TextAlign.center,
        ),
      );
    }
    if (_gifs.isEmpty) {
      return const Center(
        child: Text('Search foor gifs to see results'),
      );
    }
    return GridView.builder(
      controller: _scrollController,
      itemCount: _gifs.length,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 180, mainAxisSpacing: 8, crossAxisSpacing: 8,),
      itemBuilder:(context, index) {
        final gif = _gifs[index];
        return ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: CachedNetworkImage(
            imageUrl: gif.previewUrl,
            fit: BoxFit.cover,
            placeholder: (context,url) {
              return const Center(
                child: CircularProgressIndicator() ,
                );
            },
          ),
        );
      },
    );
  }
  }