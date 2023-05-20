import 'package:abc_tech_app/controller/order_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class OrderPage extends GetView<OrderController> {
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    controller.getLocation();
    return Scaffold(
        appBar: AppBar(title: const Text("ABC Tech App")),
        body: Container(
          constraints: const BoxConstraints.expand(),
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
              child: Form(
            key: controller.formKey,
            child: Column(children: <Widget>[
              Row(children: [
                Text("Preencha o formulário de ordem de serviço",
                    style: context.theme.textTheme.headlineLarge)
              ]),
              TextFormField(
                controller: controller.operatorIdController,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                keyboardType: TextInputType.number,
                decoration:
                    const InputDecoration(labelText: "Código do prestador"),
              )
            ]),
          )),
        ));
  }
}
