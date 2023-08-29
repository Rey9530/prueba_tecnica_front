// ignore_for_file: use_build_context_synchronously, must_be_immutable

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prueba_tecnica/src/components/component.dart';
import 'package:prueba_tecnica/src/provider/provider.dart';
import 'package:prueba_tecnica/src/utils/utils.dart';

class FormDescInvPage extends StatelessWidget {
  FormDescInvPage({super.key, this.item});
  dynamic item;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<InventariProvider>(context, listen: false);
    return Scaffold(
      appBar: appBar(context, "Descargar de inventario"),
      body: FutureBuilder(
        future: provider.limpiarDescargo(item),
        builder: (
          BuildContext context,
          AsyncSnapshot<dynamic> snapshot,
        ) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return const FormBodyDescComponent();
          }
        },
      ),
    );
  }
}

class FormBodyDescComponent extends StatelessWidget {
  const FormBodyDescComponent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final providerInven = Provider.of<InventariProvider>(context);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Form(
        key: providerInven.formKey,
        child: Column(
          children: [
            RoundedInputField(
              readOnly: true,
              title: "Existencias",
              hinText: "Existencias",
              controller: providerInven.cantidad_en_existencia,
              keyboardType: TextInputType.number,
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
            const Expanded(child: SizedBox()),
            providerInven.loading
                ? const CircularProgressIndicator()
                : ButtonComponent(
                    onPress: () async {
                      providerInven.formKey.currentState?.validate();
                      if (providerInven.cantidad.text.isNotEmpty &&
                          providerInven.descripcion.text.isNotEmpty &&
                          providerInven.id_producto != "0") {
                        await providerInven.sendDataDescargar();
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
