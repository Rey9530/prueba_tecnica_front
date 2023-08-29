// ignore_for_file: use_build_context_synchronously, must_be_immutable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prueba_tecnica/src/components/component.dart';
// import 'package:prueba_tecnica/src/components/component.dart';
import 'package:prueba_tecnica/src/provider/provider.dart';
import 'package:prueba_tecnica/src/utils/utils.dart';

class HistoryProductPage extends StatelessWidget {
  HistoryProductPage({super.key, this.item});
  dynamic item;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductProvider>(context, listen: false);
    return Scaffold(
      appBar: appBar(context, "Historial de ${item['nombre']}"),
      body: FutureBuilder(
        future: provider.getHistoryProduct(item),
        builder: (
          BuildContext context,
          AsyncSnapshot<dynamic> snapshot,
        ) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return const HistoryBodyComponent();
          }
        },
      ),
    );
  }
}

class HistoryBodyComponent extends StatelessWidget {
  const HistoryBodyComponent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductProvider>(context);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Form(
        key: provider.formKey,
        child: Column(
          children: [
            for (var item in provider.listadoProductHistory)
              ItemProductHistoryWidget(item: item)
          ],
        ),
      ),
    );
  }
}
