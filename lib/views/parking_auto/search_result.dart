import 'package:budge_up/presentation/widgets.dart';
import 'package:flutter/material.dart';

class SearchResult extends StatelessWidget {
  const SearchResult({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Результат поиска'),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 50),
        alignment: Alignment.center,
        child: EmptyData(
            title: 'К сожалению, пользователь\nне оставил данные о парковке'),
      ),
    );
  }
}
