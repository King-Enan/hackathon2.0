import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/product_model.dart';

class ProductService {
  final CollectionReference _productCollection =
  FirebaseFirestore.instance.collection('products');

  /// 🟢 Add a new product to Firestore
  /// Firestore auto-generates the productId (document ID)
  Future<void> addProduct(ProductModel product) async {
    try {
      // Generate a new document reference (auto ID)
      final docRef = _productCollection.doc();

      // Create a new product with that auto ID
      final newProduct = ProductModel(
        productId: docRef.id,
        productName: product.productName,
        category: product.category,
        description: product.description,
        farmName: product.farmName,
        imageURL: product.imageURL,
        price: product.price,
        sellerUid: product.sellerUid,
        status: product.status,
        views: product.views,
        purchases: product.purchases,
        trandingScore: product.trandingScore,
        stock: product.stock,
        createdAt: product.createdAt,
      );

      // Save it to Firestore
      await docRef.set(newProduct.toMap());
    } catch (e) {
      print('❌ Error adding product: $e');
      rethrow;
    }
  }

  /// 🟡 Fetch all products
  Future<List<ProductModel>> fetchProducts() async {
    try {
      final snapshot = await _productCollection.get();
      return snapshot.docs
          .map((doc) =>
          ProductModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('❌ Error fetching products: $e');
      rethrow;
    }
  }

  /// 🟡 Fetch products filtered by category
  /// 🟡 Fetch products, filter by category if not 'All'
  Future<List<ProductModel>> fetchProductsByCategory(String category) async {
    try {
      QuerySnapshot snapshot;

      if (category.toLowerCase() == 'all') {
        // Fetch all products
        snapshot = await _productCollection.get();
      } else {
        // Fetch only products of the given category
        snapshot = await _productCollection
            .where('category', isEqualTo: category)
            .get();
      }

      return snapshot.docs
          .map((doc) => ProductModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('❌ Error fetching products by category: $e');
      rethrow;
    }
  }



  /// 🟡 Fetch trending products
  Future<List<ProductModel>> fetchTrendingProducts() async {
    try {
      final snapshot = await _productCollection
          .orderBy('trendingScore', descending: true)   // 🔥 SORT BY TRENDING SCORE
          .limit(20)                                    // optional
          .get();

      return snapshot.docs
          .map((doc) =>
          ProductModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('❌ Error fetching trending products: $e');
      rethrow;
    }
  }

  /// Fetch a product by farmer email
  Future<List<ProductModel>> getProductsByFarmer(String sellerEmail) async {
    try {
      final snapshot = await _productCollection
          .where('sellerUid', isEqualTo: sellerEmail)
          .get();

      return snapshot.docs
          .map((doc) => ProductModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('❌ Error fetching products by farmer: $e');
      rethrow;
    }
  }

  /// 🔵 Fetch a single product by ID
  Future<ProductModel?> getProductById(String productId) async {
    try {
      final doc = await _productCollection.doc(productId).get();
      if (doc.exists) {
        return ProductModel.fromMap(doc.data() as Map<String, dynamic>);
      }
      return null;
    } catch (e) {
      print('❌ Error fetching product by ID: $e');
      rethrow;
    }
  }

  /// 🟠 Update an existing product
  Future<void> updateProduct(ProductModel product) async {
    try {
      await _productCollection.doc(product.productId).update(product.toMap());
    } catch (e) {
      print('❌ Error updating product: $e');
      rethrow;
    }
  }

  /// 🔴 Delete a product
  Future<void> deleteProduct(String productId) async {
    try {
      await _productCollection.doc(productId).delete();
    } catch (e) {
      print('❌ Error deleting product: $e');
      rethrow;
    }
  }

  //incress views of product
  Future<void> increaseViews(String productId) async {
    final docRef = FirebaseFirestore.instance.collection('products').doc(productId);

    await FirebaseFirestore.instance.runTransaction((transaction) async {
      final snapshot = await transaction.get(docRef);

      int views = snapshot['views'] + 1;
      double purchases = snapshot['purchases'];
      double score = (views * 0.4) + (purchases * 0.6);

      transaction.update(docRef, {
        'views': views,
        'trendingScore': score.toDouble(),
      });
    });
  }

  //incress purchases
  Future<void> increasePurchase(String productId) async {
    final docRef = FirebaseFirestore.instance.collection('products').doc(productId);

    await FirebaseFirestore.instance.runTransaction((transaction) async {
      final snapshot = await transaction.get(docRef);

     double purchases = snapshot['purchases'] + 1;
      int views = snapshot['views'];
      double score = (views * 0.4) + (purchases * 0.6);

      transaction.update(docRef, {
        'purchases': purchases,
        'trendingScore': score.toDouble(),
      });
    });
  }


}
