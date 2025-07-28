import 'dart:io';

class Product {
  String _name;
  String _description;
  double _price;

  Product(this._name, this._description, this._price);

  String get name => _name;
  String get description => _description;
  double get price => _price;

  set name(String newName) {
    _name = newName;
  }

  set description(String newDescription) {
    _description = newDescription;
  }

  set price(double newPrice) {
    _price = newPrice;
  }

  void showDetails() {
    print('Name: $_name');
    print('Description: $_description');
    print('Price: \$${_price.toStringAsFixed(2)}');
  }
}



class ProductManager {
  List<Product> productList = [];

  void addNewProduct() {
    print('\n--- Add New Product ---');
    stdout.write('Enter product name: ');
    String productName = stdin.readLineSync() ?? '';
    stdout.write('Enter product description: ');
    String productDescription = stdin.readLineSync() ?? '';
    stdout.write('Enter product price: ');
    String priceInput = stdin.readLineSync() ?? '';
    double productPrice = double.tryParse(priceInput) ?? 0.0;

    Product newProduct = Product(productName, productDescription, productPrice);
    productList.add(newProduct);

    print('Product added successfully.\n');
  }

  void showAllProducts() {
    print('\n--- Product List ---');
    if (productList.isEmpty) {
      print('No products available.\n');
      return;
    }

    for (int i = 0; i < productList.length; i++) {
      print('\nProduct ID: $i');
      productList[i].showDetails();
    }
    print('');
  }

  void showProductById() {
    print('\n--- View Product ---');
    stdout.write('Enter product ID: ');
    int id = int.tryParse(stdin.readLineSync() ?? '') ?? -1;

    if (id < 0 || id >= productList.length) {
      print('Invalid product ID.\n');
      return;
    }

    print('\nProduct Details:');
    productList[id].showDetails();
    print('');
  }

  void updateProduct() {
    print('\n--- Edit Product ---');
    stdout.write('Enter product ID to edit: ');
    int id = int.tryParse(stdin.readLineSync() ?? '') ?? -1;

    if (id < 0 || id >= productList.length) {
      print('Invalid product ID.\n');
      return;
    }

    stdout.write('Enter new name (leave blank to keep current): ');
    String updatedName = stdin.readLineSync() ?? '';
    stdout.write('Enter new description (leave blank to keep current): ');
    String updatedDescription = stdin.readLineSync() ?? '';
    stdout.write('Enter new price (leave blank to keep current): ');
    String updatedPriceInput = stdin.readLineSync() ?? '';

    if (updatedName.isNotEmpty) {
      productList[id].name = updatedName;
    }

    if (updatedDescription.isNotEmpty) {
      productList[id].description = updatedDescription;
    }

    if (updatedPriceInput.isNotEmpty) {
      double? updatedPrice = double.tryParse(updatedPriceInput);
      if (updatedPrice != null) {
        productList[id].price = updatedPrice;
      }
    }

    print('Product updated successfully.\n');
  }

  void deleteProductById() {
    print('\n--- Delete Product ---');
    stdout.write('Enter product ID to delete: ');
    int id = int.tryParse(stdin.readLineSync() ?? '') ?? -1;

    if (id < 0 || id >= productList.length) {
      print('Invalid product ID.\n');
      return;
    }

    productList.removeAt(id);
    print('Product deleted successfully.\n');
  }
}

// Main application
void main() {
  ProductManager productManager = ProductManager();

  while (true) {
    print('''
===========================
Simple eCommerce CLI App
===========================
1. Add Product
2. View All Products
3. View One Product
4. Edit Product
5. Delete Product
6. Exit
---------------------------
Enter your choice:
''');

    String userChoice = stdin.readLineSync() ?? '';

    switch (userChoice) {
      case '1':
        productManager.addNewProduct();
        break;
      case '2':
        productManager.showAllProducts();
        break;
      case '3':
        productManager.showProductById();
        break;
      case '4':
        productManager.updateProduct();
        break;
      case '5':
        productManager.deleteProductById();
        break;
      case '6':
        print('Thanks for using the application.');
        return;
      default:
        print('Invalid choice. Please try again.\n');
    }
  }
}
