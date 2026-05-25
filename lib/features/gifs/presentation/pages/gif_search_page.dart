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
}
  @override
  void dispose() {
    _searchController.dispose();
    _debounceTimer?.cancel();
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
        _gifs = [];
        _errorMessage = null;
      });
      return;
  }
  setState(() {
    _isLoading = true;
    _errorMessage = null;
  });
  try {
    final gifs = await _repository.searchGifs(query: cleanQuery);
    if(!mounted) return;
    setState(() {
      _gifs = gifs;
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