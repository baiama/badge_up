import 'package:budge_up/presentation/widgets.dart';
import 'package:flutter/material.dart';

class SearchResult extends StatefulWidget {
  final String query;
  const SearchResult({Key? key, required this.query}) : super(key: key);

  @override
  _SearchResultState createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
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
