import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prueba_tecnica/src/components/component.dart';
import 'package:prueba_tecnica/src/pages/pages.dart';
import 'package:prueba_tecnica/src/provider/provider.dart';

class InventarioPage extends StatelessWidget {
  const InventarioPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<InventariProvider>(context, listen: false);
    return Scaffold(
      body: FutureBuilder(
        future: provider.getInvetantary(),
        builder: (
          BuildContext context,
          AsyncSnapshot<dynamic> snapshot,
        ) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {}
          return const InventaryBodyWidget();
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
              builder: (context) => FormIngInvPage(),
            ),
          );
        },
      ),
    );
  }
}

class InventaryBodyWidget extends StatelessWidget {
  const InventaryBodyWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<InventariProvider>(context);
    return SizedBox(
      height: double.infinity,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              width: double.infinity,
              child: const Text(
                "Existencias",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(height: 10),
            for (var item in provider.listadoInventario)
              ItemInventaryWidget(item: item),
            if (provider.listadoInventario.isEmpty)
              Container(
                margin: const EdgeInsets.only(top: 100),
                child: Text(
                  "Vacias",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple.withOpacity(0.5),
                    fontSize: 35,
                  ),
                ),
              ),
            if (provider.listadoInventario.isEmpty)
              Text(
                "De clic en el boton + para agregar nuevas existencias",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple.withOpacity(0.5),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
