// ignore_for_file: use_build_context_synchronously, must_be_immutable

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prueba_tecnica/src/components/component.dart';
import 'package:prueba_tecnica/src/provider/provider.dart';
import 'package:prueba_tecnica/src/utils/utils.dart';

class FormProductPage extends StatelessWidget {
  FormProductPage({super.key, this.item});
  dynamic item;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductProvider>(context, listen: false);
    return Scaffold(
      appBar: appBar(
          context, item == null ? "Crear Producto" : "Actualizar Producto"),
      body: FutureBuilder(
        future: provider.limpiar(item),
        builder: (
          BuildContext context,
          AsyncSnapshot<dynamic> snapshot,
        ) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return const FormBodyComponent();
          }
        },
      ),
    );
  }
}

class FormBodyComponent extends StatelessWidget {
  const FormBodyComponent({
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
            RoundedInputField(
              title: "Nombre",
              hinText: "Nombre",
              controller: provider.nombre,
            ),
            RoundedInputField(
              title: "Descripcion",
              hinText: "Descripcion",
              controller: provider.descripcion,
            ),
            RoundedInputField(
              title: "Precio",
              hinText: "Precio",
              controller: provider.precio,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 5),
            provider.loading
                ? const CircularProgressIndicator()
                : ButtonComponent(
                    onPress: () async {
                      provider.formKey.currentState?.validate();
                      if (provider.nombre.text.isNotEmpty &&
                          provider.descripcion.text.isNotEmpty &&
                          provider.precio.text.isNotEmpty) {
                        await provider.sendData();
                        showSnackbar(
                          title: "Exito",
                          messaje: "Datos Procesados correctamente",
                          type: ContentType.success,
                          context: context,
                        );
                        Navigator.pop(context);
                      } else {
                        showSnackbar(
                          title: "Atención",
                          messaje:
                              "Ha ocurrido un error favor intentarlo mas tarde",
                          type: ContentType.failure,
                          context: context,
                        );
                      }
                    },
                    title: 'Procesar',
                  ),
            const Expanded(child: SizedBox()),
            if (provider.id_producto != "0")
              provider.loadingDelete
                  ? const CircularProgressIndicator()
                  : ButtonComponent(
                      color: Colors.red,
                      onPress: () async {
                        var data = await provider.eliminarItem();
                        if (data == 200) {
                          showSnackbar(
                            title: "Exito",
                            messaje: "Datos Procesados correctamente",
                            type: ContentType.success,
                            context: context,
                          );
                          Navigator.pop(context);
                        } else {
                          showSnackbar(
                            title: "Atención",
                            messaje:
                                "Ha ocurrido un error favor intentarlo mas tarde",
                            type: ContentType.failure,
                            context: context,
                          );
                        }
                      },
                      title: 'Eliminar item',
                    ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
