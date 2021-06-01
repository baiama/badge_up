import 'package:budge_up/presentation/widgets.dart';
import 'package:budge_up/views/parking_auto/parking_auto_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchResult extends StatefulWidget {
  final String query;
  const SearchResult({Key? key, required this.query}) : super(key: key);

  @override
  _SearchResultState createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Provider.of<ParkingAutoProvider>(context, listen: false)
          .findAuto(widget.query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Результат поиска'),
      ),
      body: Consumer<ParkingAutoProvider>(
        builder: (context, provider, Widget? child) {
          if (provider.isLoading) {
            return Container(
              padding: EdgeInsets.only(top: 100),
              alignment: Alignment.topCenter,
              child: CircularProgressIndicator(),
            );
          }

          return Container();
        },
      ),
    );
  }
}
