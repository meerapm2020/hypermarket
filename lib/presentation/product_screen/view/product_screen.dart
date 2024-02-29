import 'package:flutter/material.dart';
import 'package:hypermarket_addproduct/model/product_model.dart';
import 'package:hypermarket_addproduct/presentation/product_screen/controller/product_controller.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatefulWidget {
  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController quantityController = TextEditingController();

  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text('Product Details',
            style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Consumer<ProductController>(
        builder: (context, productProvider, child) {
          var products = productProvider.products;
          return GridView.builder(
            itemCount: products.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 35,
              crossAxisSpacing: 35,
              mainAxisExtent: 350,
            ),
            itemBuilder: (context, index) => Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.orange,
                      ),
                    ),
                    Text(
                      products[index].productName,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      products[index].category,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      products[index].description,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      '${products[index].price.toString()}',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      '${products[index].quantity.toString()}',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            EditProductBottomSheet(
                                context, products[index], index);
                          },
                          icon: Icon(Icons.edit),
                        ),
                        IconButton(
                          onPressed: () {
                            productProvider.deleteProduct(index);
                          },
                          icon: Icon(Icons.delete, color: Colors.red),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        onPressed: () {
          AddProductBottomSheet(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void AddProductBottomSheet(BuildContext context) {
    var productProvider =
        Provider.of<ProductController>(context, listen: false);
    nameController.text = '';
    categoryController.text = '';
    descriptionController.text = '';
    priceController.text = '';
    quantityController.text = '';
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Add Product',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              _buildForm(context, productProvider),
              ElevatedButton(
                onPressed: () {
                  productProvider.addProduct(
                    Product(
                      productName: nameController.text,
                      category: categoryController.text,
                      description: descriptionController.text,
                      price: double.parse(priceController.text),
                      quantity: double.parse(quantityController.text),
                    ),
                  );
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                ),
                child: Text(
                  'ADD',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void EditProductBottomSheet(
      BuildContext context, Product product, int index) {
    var productProvider =
        Provider.of<ProductController>(context, listen: false);
    nameController.text = product.productName;
    categoryController.text = product.category;
    descriptionController.text = product.description;
    priceController.text = product.price.toString();
    quantityController.text = product.quantity.toString();

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Edit Product',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              _buildForm(context, productProvider),
              ElevatedButton(
                onPressed: () {
                  productProvider.updateProduct(
                    index,
                    Product(
                      productName: nameController.text,
                      category: categoryController.text,
                      description: descriptionController.text,
                      price: double.parse(priceController.text),
                      quantity: double.parse(quantityController.text),
                    ),
                  );
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                ),
                child: Text(
                  'UPDATE',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildForm(BuildContext context, ProductController productProvider) {
    return Column(
      children: [
        SizedBox(height: 16.0),
        TextField(
          controller: nameController,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            labelText: 'Product Name',
          ),
        ),
        SizedBox(height: 10),
        TextField(
          controller: categoryController,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            labelText: 'Category',
          ),
        ),
        SizedBox(height: 10),
        TextField(
          controller: descriptionController,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            labelText: 'Description',
          ),
        ),
        SizedBox(height: 10),
        TextField(
          controller: priceController,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            labelText: 'Price',
          ),
        ),
        SizedBox(height: 10),
        TextField(
          controller: quantityController,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            labelText: 'Quantity',
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
