// lib/search_page.dart
import 'package:flutter/material.dart';
import 'models.dart';
import 'animal_detail.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();
  List<Animal> filteredList = [];
  String selectedType = 'Semua';

  @override
  void initState() {
    super.initState();
    filteredList = animalList;
  }

  void _applyFilter() {
    String query = searchController.text.toLowerCase();
    setState(() {
      filteredList = animalList.where((animal) {
        bool matchesSearch = animal.name.toLowerCase().contains(query);
        bool matchesType = (selectedType == 'Semua') || (animal.type == selectedType);
        return matchesSearch && matchesType;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> categories = ['Semua', 'Mamalia', 'Unggas', 'Mamalia Laut'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cari & Filter Hewan'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // Input Search
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: searchController,
              onChanged: (_) => _applyFilter(),
              decoration: InputDecoration(
                hintText: 'Cari nama hewan...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),

          // Filter Category Chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: categories.map((type) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: ChoiceChip(
                    label: Text(type),
                    selected: selectedType == type,
                    onSelected: (selected) {
                      if (selected) {
                        selectedType = type;
                        _applyFilter();
                      }
                    },
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 10),

          // List Hasil Filter
          Expanded(
            child: filteredList.isEmpty
                ? const Center(child: Text('Hewan tidak ditemukan'))
                : ListView.builder(
                    itemCount: filteredList.length,
                    itemBuilder: (context, index) {
                      final animal = filteredList[index];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(animal.imageUrl),
                        ),
                        title: Text(animal.name),
                        subtitle: Text(animal.type),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AnimalDetailPage(animal: animal),
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}