import 'package:flutter/material.dart';
import 'package:flutter_super_scaffold/flutter_super_scaffold.dart';
import 'package:get/get.dart';
import 'package:pagination_widget/model/m_pagination.dart';

class PaginationController extends GetxController {
  List<Beer> beer = [];
  int pageIndex = 1;
  final token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjZiM2M2MWIwLTE3NGMtNDM1NC04YjBjLWQzOTcxZjFhZGE2YSIsInJvbGUiOiJFTkRVU0VSIiwiaWF0IjoxNzA4MzEwODUzLCJleHAiOjE3MDgzOTcyNTN9.hxomOFogOQRhK69yBO6VO8xfs0ONkOJPSFn7ETSuzyw";
  ValueNotifier<bool> xFetching = ValueNotifier(false);
  ValueNotifier<List<String>> data = ValueNotifier([]);
  ScrollController scrollController = ScrollController();
  ValueNotifier<bool> xMoreData = ValueNotifier(true);

  @override
  void onInit() {
    super.onInit();
    initLoad();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  Future<void> initLoad() async {
    scrollController.addListener(() {
      final isTop = scrollController.position.pixels == 0;
      if (isTop) {
        //
      } else {
        if (xMoreData.value) {
          fetchData();
        }
      }
    });
    await fetchData();
  }

  Future<void> fetchData() async {
    GetConnect getConnect = GetConnect(timeout: const Duration(seconds: 30));

    if (!xFetching.value) {
      Response? response;
      xFetching.value = true;
      xFetching.notifyListeners();

      //api
      try {
        response = await getConnect.get(
          // "https://member.appstudiomyanmar.com/api/notifications?page=$pageIndex&pageSize=3",
          'https://api.punkapi.com/v2/beers?page=$pageIndex&per_page=10',
          headers: {
            'Access-Control-Allow-Origin': '*',
            'Accept': '*/*',
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token',
          },
        );
        await Future.delayed(const Duration(seconds: 3));
      } catch (e) {
        null;
      }

      xFetching.value = false;
      xFetching.notifyListeners();

      if (response != null) {
        if (response.statusCode == 200 || response.statusCode == 201) {
          //okayState
          // Iterable iterable = response.body["body"]["data"] ?? [];
          Iterable iterable = response.body;

          if (iterable.isEmpty) {
            xMoreData.value = false;
          }

          for (final each in iterable) {
            data.value.add(each["name"]);
          }
          data.notifyListeners();
          pageIndex = pageIndex + 1;
        }
      }
    }
  }
}
