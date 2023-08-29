import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:prueba_tecnica/src/provider/provider.dart';

class ProductProvider extends ChangeNotifier {
  final conection = ConexionesProvider();
  final formKey = GlobalKey<FormState>();
  var listadoProduct = [];
  var listadoProductSelect = [
    {"id": "0", "text": "Seleccione..."}
  ];

  Future getProduct() async {
    final jsonData = await conection.get_('producto');
    if (jsonData.statusCode == 200) {
      var resp = jsonDecode(jsonData.body);
      listadoProduct =
          (resp != null && resp["data"] != null) ? resp["data"] : [];
      var data = listadoProduct.map((e) {
        return {
          "id": e["id_producto"].toString(),
          "text": e["nombre"].toString()
        };
      });
      listadoProductSelect = [
        {"id": "0", "text": "Seleccione..."},
        ...data
      ];
    } else {
      listadoProduct = [];
    }
    return listadoProductSelect;
  }

  var listadoProductHistory = [];
  Future getHistoryProduct(item) async {
    final jsonData =
        await conection.get_('inventario', {"id": item['id_producto']});
    if (jsonData.statusCode == 200) {
      var resp = jsonDecode(jsonData.body);
      listadoProductHistory =
          (resp != null && resp["data"] != null) ? resp["data"] : [];
    } else {
      listadoProductHistory = [];
    }
  }

  var id_producto = "0";
  Future limpiar(item) async {
    if (item == null) {
      nombre.text = "";
      descripcion.text = "";
      precio.text = "";
      id_producto = "0";
    } else {
      id_producto = item["id_producto"];
      nombre.text = item["nombre"];
      descripcion.text = item["descripcion"];
      precio.text = item["precio"];
    }
  }

  TextEditingController nombre = TextEditingController();
  TextEditingController descripcion = TextEditingController();
  TextEditingController precio = TextEditingController();

  bool loading = false;
  Future sendData() async {
    var data = {
      "nombre": nombre.text,
      "descripcion": descripcion.text,
      "precio": double.parse(precio.text.toString())
    };
    loading = true;
    notifyListeners();
    dynamic jsonData;
    if (id_producto != "0") {
      jsonData = await conection
          .put_('producto', jsonEncode(data), {"id": id_producto});
    } else {
      jsonData = await conection.post_('producto', jsonEncode(data));
    }
    if (jsonData.statusCode == 200) {
      await getProduct();
    }
    loading = false;
    notifyListeners();
  }

  bool loadingDelete = false;
  Future eliminarItem() async {
    loadingDelete = true;
    notifyListeners();
    dynamic jsonData = await conection.delte_('producto', {"id": id_producto});
    if (jsonData.statusCode == 200) {
      await getProduct();
    }
    loadingDelete = false;
    notifyListeners();
    return jsonData.statusCode;
  }
}
