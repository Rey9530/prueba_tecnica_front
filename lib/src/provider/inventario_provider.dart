// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:prueba_tecnica/src/provider/provider.dart';

class InventariProvider extends ChangeNotifier {
  final conection = ConexionesProvider();
  var listadoInventario = [];
  final formKey = GlobalKey<FormState>();

  Future getInvetantary() async {
    final jsonData = await conection.get_('inventario');
    if (jsonData.statusCode == 200) {
      var resp = jsonDecode(jsonData.body);
      listadoInventario =
          (resp != null && resp["data"] != null) ? resp["data"] : [];
    } else {
      listadoInventario = [];
    }
  }

  Future limpiar(item) async {
    cantidad.text = "";
    descripcion.text = "";
    monto_unitario.text = "";
    id_producto = "0";
  }

  Future limpiarDescargo(item) async {
    cantidad.text = "";
    descripcion.text = "";
    id_producto = item["id_producto"];
    cantidad_en_existencia.text = item["cantidad_en_existencia"];
  }

  TextEditingController cantidad_en_existencia = TextEditingController();
  TextEditingController cantidad = TextEditingController();
  TextEditingController descripcion = TextEditingController();
  TextEditingController monto_unitario = TextEditingController();
  String id_producto = "0";
  bool loading = false;
  Future sendData() async {
    var data = {
      "id_producto": int.parse(id_producto.toString()),
      "cantidad": int.parse(cantidad.text.toString()),
      "descripcion": descripcion.text,
      "monto_unitario": double.parse(monto_unitario.text.toString()),
    };
    loading = true;
    notifyListeners();
    dynamic jsonData = await conection.post_('inventario', jsonEncode(data));

    if (jsonData.statusCode == 200) {
      await getInvetantary();
    }
    loading = false;
    notifyListeners();
  }

  Future sendDataDescargar() async {
    var data = {
      "id_producto": int.parse(id_producto.toString()),
      "cantidad": int.parse(cantidad.text.toString()),
      "descripcion": descripcion.text,
    };
    loading = true;
    notifyListeners();
    dynamic jsonData = await conection
        .put_('inventario', jsonEncode(data), {"id": id_producto});

    if (jsonData.statusCode == 200) {
      await getInvetantary();
    }
    loading = false;
    notifyListeners();
  }
}
