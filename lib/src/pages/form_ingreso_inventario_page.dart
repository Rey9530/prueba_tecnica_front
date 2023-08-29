// ignore_for_file: use_build_context_synchronously, must_be_immutable

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prueba_tecnica/src/components/component.dart';
import 'package:prueba_tecnica/src/provider/provider.dart';
import 'package:prueba_tecnica/src/utils/utils.dart';

class FormIngInvPage extends StatelessWidget {
  FormIngInvPage({super.key, this.item});
  dynamic item;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<InventariProvider>(context, listen: false);
    return Scaffold(
      appBar: appBar(context, "Ingresar Producto a inventario"),
      body: FutureBuilder(
        future: provider.limpiar(item),
        builder: (
          BuildContext context,
          AsyncSnapshot<dynamic> snapshot,
        ) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return const FormBodyInvComponent();
          }
        },
      ),
    );
  }
}

class FormBodyInvComponent extends StatelessWidget {
  const FormBodyInvComponent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final providerProd = Provider.of<ProductProvider>(context, listen: false);
    final providerInven = Provider.of<InventariProvider>(context);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Form(
        key: providerInven.formKey,
        child: Column(
          children: [
            FutureBuilder(
              future: providerProd.getProduct(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (!snapshot.hasData) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasData) {
                  return DrowpDownList(
                    title: "Productos",
                    items: snapshot.data,
                    valueSelected: providerInven.id_producto,
                    onChanged: (String value) async {
                      providerInven.id_producto = value;
                    },
                  );
                }
                return Container();
              },
            ),
            RoundedInputField(
              title: "Cantidad",
              hinText: "Cantidad",
              controller: providerInven.cantidad,
              keyboardType: TextInputType.number,
            ),
            RoundedInputField(
              title: "Descripcion",
              hinText: "Descripcion",
              controller: providerInven.descripcion,
            ),
            RoundedInputField(
              title: "Costo Unitario",
              hinText: "Costo Unitario",
              controller: providerInven.monto_unitario,
              keyboardType: TextInputType.number,
            ),
            const Expanded(child: SizedBox()),
            providerInven.loading
                ? const CircularProgressIndicator()
                : ButtonComponent(
                    onPress: () async {
                      providerInven.formKey.currentState?.validate();
                      if (providerInven.cantidad.text.isNotEmpty &&
                          providerInven.descripcion.text.isNotEmpty &&
                          providerInven.id_producto != "0" &&
                          providerInven.monto_unitario.text.isNotEmpty) {
                        await providerInven.sendData();
                        showSnackbar(
                          title: "Exito",
                          messaje: "Datos Procesados correctamente",
                          type: ContentType.success,
                          context: context,
                        );
                        Navigator.pop(context);
                      }
                    },
                    title: 'Procesar',
                  ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
