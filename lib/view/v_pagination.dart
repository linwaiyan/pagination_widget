import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pagination_widget/controller/c_pagination.dart';

class PaginationPage extends StatelessWidget {
  const PaginationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PaginationController());
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: ValueListenableBuilder(
          valueListenable: controller.data,
          builder: (context, data, child) {
            return ListView.builder(
              padding: EdgeInsets.zero,
              controller: controller.scrollController,
              itemCount: data.length + 1,
              itemBuilder: (context, index) {
                if (index == data.length) {
                  //lastOne
                  return ValueListenableBuilder(
                    valueListenable: controller.xFetching,
                    builder: (context, xFetching, child) {
                      if (xFetching) {
                        return const CupertinoActivityIndicator();
                      } else {
                        return Container();
                      }
                    },
                  );
                } else {
                  //dataDisplay
                  return Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 50,
                    ),
                    // height: Get.height * 0.4,
                    // width: double.infinity,
                    alignment: Alignment.center,
                    child: Text("${index + 1} " + data[index]),
                  );
                }
              },
            );
          },
        ),
      ),
    );
  }
}
