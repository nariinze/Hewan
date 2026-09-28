class Animal {
  final String name;
  final String type;
  final String habitat;
  final String imageUrl;
  final String wikipediaUrl;
  bool isLiked; // Untuk menampung status Like

  Animal({
    required this.name,
    required this.type,
    required this.habitat,
    required this.imageUrl,
    required this.wikipediaUrl,
    this.isLiked = false,
  });
}

// Data Dummy Hewan
final List<Animal> animalList = [
  Animal(
    name: "Harimau Sumatra",
    type: "Mamalia / Karnivora",
    habitat: "Hutan Hujan Tropis",
    imageUrl: "https://images.unsplash.com/photo-1561731216-c3a4d99437d5",
    wikipediaUrl: "https://id.wikipedia.org/wiki/Harimau_sumatra",
  ),
  Animal(
    name: "Komodo",
    type: "Reptil / Karnivora",
    habitat: "Pulai Komodo & Nusa Tenggara",
    imageUrl: "https://images.unsplash.com/photo-1534567153574-2b12153a87f0",
    wikipediaUrl: "https://id.wikipedia.org/wiki/Komodo",
  ),
  Animal(
    name: "Elang Jawa",
    type: "Burung / Karnivora",
    habitat: "Hutan Hujan Jawa",
    imageUrl: "https://images.unsplash.com/photo-1611689342806-0863700ce1e4",
    wikipediaUrl: "https://id.wikipedia.org/wiki/Elang_jawa",
  ),
];