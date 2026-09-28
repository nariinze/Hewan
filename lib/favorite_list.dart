// lib/favorite_list.dart
import 'package:flutter/material.dart';
import 'models.dart';
import 'animal_detail.dart';

class FavoriteListPage extends StatefulWidget {
  const FavoriteListPage({super.key});

  @override
  State<FavoriteListPage> createState() => _FavoriteListPageState();
}

class _FavoriteListPageState extends State<FavoriteListPage> {
  late final Set<Animal> _favoriteAnimals = animalList.toSet();

  @override
  Widget build(BuildContext context) {
    final favoriteAnimals = animalList
        .where((animal) => _favoriteAnimals.contains(animal))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hewan Favorit Saya ❤️'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: favoriteAnimals.isEmpty
          ? const Center(
              child: Text(
                'Belum ada hewan yang difavoritkan.',
                style: TextStyle(fontSize: 16),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: favoriteAnimals.length,
              itemBuilder: (context, index) {
                final animal = favoriteAnimals[index];
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(animal.imageUrl),
                    ),
                    title: Text(animal.name),
                    subtitle: Text(animal.type),
                    trailing: IconButton(
                      icon: const Icon(Icons.favorite, color: Colors.red),
                      onPressed: () {
                        setState(() {
                          _favoriteAnimals.remove(animal);
                        });
                      },
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AnimalDetailPage(animal: animal),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}