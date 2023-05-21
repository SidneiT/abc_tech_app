import 'package:abc_tech_app/controller/order_controller.dart';
import 'package:abc_tech_app/model/assist.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class OrderPage extends GetView<OrderController> {
  const OrderPage({super.key});

  Widget _renderAssists(List<Assist> assistList) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: assistList.length,
        itemBuilder: (context, index) => ListTile(
              title: Text(assistList[index].title),
            ));
  }

  Widget _renderScreen(BuildContext context) {
    return SingleChildScrollView(
        child: Form(
      key: controller.formKey,
      child: Column(children: <Widget>[
        Row(children: [
          Expanded(
              child: Text("Preencha o formulário de ordem de serviço",
                  style: context.theme.textTheme.headlineLarge))
        ]),
        TextFormField(
          controller: controller.operatorIdController,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(labelText: 'Código do prestador'),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 25, bottom: 10),
          child: Row(
            children: [
              Expanded(
                child: Text("Selecione os serviços prestados:",
                    style: context.theme.textTheme.headlineMedium),
              ),
              Ink(
                width: 40,
                height: 40,
                decoration: ShapeDecoration(
                    shape: const CircleBorder(),
                    color: context.theme.primaryColor),
                child: IconButton(
                    icon: const Icon(Icons.search, color: Colors.white),
                    onPressed: () => controller.editAssists()),
              ),
            ],
          ),
        ),
        Obx(() => _renderAssists(controller.selectAssists)),
        Row(
          children: [
            Expanded(
                child: ElevatedButton(
              onPressed: controller.finishStartOrder,
              child: Obx(() {
                if (controller.screenState.value == OrderState.creating) {
                  return const Text("Iniciar");
                } else {
                  return const Text("Finalizar");
                }
              }),
            ))
          ],
        )
      ]),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("ABC Tech App")),
        body: Container(
            constraints: const BoxConstraints.expand(),
            padding: const EdgeInsets.all(10),
            child: controller.obx((state) => _renderScreen(context),
                onLoading: const Center(child: CircularProgressIndicator()))));
  }
}
