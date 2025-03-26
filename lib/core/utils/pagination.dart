
import 'package:flutter/material.dart';

class Pagination {
  int nextPage;
  int pagesCount;
  ScrollController scrollController;
  bool isLoading;
  Future<void> Function({int page}) function;
  Pagination(
      {this.nextPage = 1,
      this.pagesCount = 1,
      required this.scrollController,
      this.isLoading = false,
      required this.function}) {
    scrollController.addListener(() async {
      var currentPositions = scrollController.position.pixels;
      var maxScrollLength = scrollController.position.maxScrollExtent;
      if (currentPositions >= 0.7 * maxScrollLength) {
        if (!isLoading) {
          isLoading = true;
          await function(page: nextPage);
          isLoading = false;
        }
      }
    });
  }
}
