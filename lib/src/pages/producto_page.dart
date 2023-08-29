import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prueba_tecnica/src/components/component.dart';
import 'package:prueba_tecnica/src/pages/pages.dart';
import 'package:prueba_tecnica/src/provider/provider.dart';

class ProductoPage extends StatelessWidget {
  const ProductoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductProvider>(context, listen: false);
    return Scaffold(
      body: FutureBuilder(
        future: provider.getProduct(),
        builder: (
          BuildContext context,
          AsyncSnapshot<dynamic> snapshot,
        ) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return const ProductBodyWidget();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add,
          size: 40,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FormProductPage(),
            ),
          );
        },
      ),
    );
  }
}

class ProductBodyWidget extends StatelessWidget {
  const ProductBodyWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductProvider>(context);
    return SizedBox(
      height: double.infinity,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              width: double.infinity,
              child: Text(
                "Listado de Productos",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple.withOpacity(0.5),
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(height: 10),
            for (var item in provider.listadoProduct)
              ItemProductWidget(item: item),
          ],
        ),
      ),
    );
  }
}
