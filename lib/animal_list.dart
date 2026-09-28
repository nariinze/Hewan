import 'package:flutter/material.dart';
import 'models.dart';
import 'animal_detail.dart';
import 'search_page.dart';
import 'favorite_list.dart';
import 'login.dart';

class AnimalListPage extends StatefulWidget {
  final String username;

  const AnimalListPage({super.key, required this.username});

  @override
  State<AnimalListPage> createState() => _AnimalListPageState();
}

class _AnimalListPageState extends State<AnimalListPage> {
  final Set<String> _favoriteAnimals = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        title: Text('Selamat Datang, ${widget.username}! 🐾'),
        actions: [
          // Tombol Pencarian & Filter
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SearchPage()),
              );
            },
          ),
          // Tombol Halaman Favorit
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FavoriteListPage()),
              );
            },
          ),
          // Tombol Logout dengan AlertDialog Konfirmasi
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Konfirmasi Logout'),
                  content: const Text('Apakah Anda yakin ingin keluar?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Batal'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Mengarahkan kembali ke LoginPage & membersihkan tumpukan navigasi
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ),
                          (route) => false,
                        );
                      },
                      child: const Text('Ya, Keluar'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: animalList.length,
        itemBuilder: (context, index) {
          final animal = animalList[index];
          final isFavorite = _favoriteAnimals.contains(animal.name);

          return Card(
            elevation: 3,
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(12),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  animal.imageUrl,
                  width: 70,
                  height: 70,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.pets, size: 50, color: Colors.grey),
                ),
              ),
              title: Text(
                animal.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Text(
                    animal.type,
                    style: TextStyle(
                      color: Colors.deepPurple.shade400,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              trailing: IconButton(
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? Colors.red : Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    if (isFavorite) {
                      _favoriteAnimals.remove(animal.name);
                    } else {
                      _favoriteAnimals.add(animal.name);
                    }
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