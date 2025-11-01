class VegItem {
  final String id;        // Unique product id
  final String name;      // Vegetable / crop name
  final String image;     // Asset or URL path
  final String price;     // Price per KG / unit
  final String seller;    // Farmer or shop owner
  final String type;      // Category like Leafy / Root / Fruit Veg

  VegItem({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.seller,
    required this.type,
  });
}

class VegetablesList {
  final List<VegItem> items = [
    VegItem(
      id: "veg001",
      name: "Tomato",
      image: "assets/homebanner/seed.jpg",
      price: "₹40/kg",
      seller: "GreenFarm Agro",
      type: "Fruit Vegetable",
    ),
    VegItem(
      id: "veg002",
      name: "Potato",
      image: "assets/homebanner/seed.jpg",
      price: "₹25/kg",
      seller: "Krishi Bazaar",
      type: "Root Crop",
    ),
    VegItem(
      id: "veg003",
      name: "Spinach",
      image: "assets/homebanner/seed.jpg",
      price: "₹15/bundle",
      seller: "FreshLeaf Farms",
      type: "Leafy Vegetable",
    ),
    VegItem(
      id: "veg004",
      name: "Onion",
      image: "assets/homebanner/seed.jpg",
      price: "₹30/kg",
      seller: "Local Market",
      type: "Bulb Crop",
    ),
  ];
}

class Trending {
  final List<VegItem> items = [
    VegItem(
      id: "news001",
      name: "Tomato ",
      image: "assets/homebanner/seed.jpg",
      price: "N/A",
      seller: "Agro Times",
      type: "Mula",
    ),
    VegItem(
      id: "news002",
      name: "Government ",
      image: "assets/homebanner/seed.jpg",
      price: "N/A",
      seller: "Farm Daily",
      type: "mula",
    ),
    VegItem(
      id: "news003",
      name: "New ",
      image: "assets/homebanner/seed.jpg",
      price: "N/A",
      seller: "Krishi News",
      type: "Mula",
    ),
  ];
}

class Agro {
  final List<VegItem> items = [
    VegItem(
      id: "news001",
      name: "Tomato prices fall due to bumper harvest",
      image: "assets/homebanner/seed.jpg",
      price: "N/A",
      seller: "Agro Times",
      type: "Alu",
    ),
    VegItem(
      id: "news002",
      name: "Government announces fertilizer subsidy",
      image: "assets/homebanner/seed.jpg",
      price: "N/A",
      seller: "Farm Daily",
      type: "Alu",
    ),
    VegItem(
      id: "news003",
      name: "New high-yield rice variety introduced",
      image: "assets/homebanner/seed.jpg",
      price: "N/A",
      seller: "Krishi News",
      type: "Alu",
    ),
  ];
}


