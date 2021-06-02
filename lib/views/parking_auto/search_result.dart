import 'package:budge_up/models/park_model.dart';
import 'package:budge_up/presentation/color_scheme.dart';
import 'package:budge_up/presentation/text_styles.dart';
import 'package:budge_up/presentation/widgets.dart';
import 'package:budge_up/views/components/auto_item.dart';
import 'package:budge_up/views/components/avatar_item.dart';
import 'package:budge_up/views/components/time_date_item.dart';
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
          if (provider.results.length == 0) {
            return Container(
              padding: EdgeInsets.only(top: 50),
              alignment: Alignment.center,
              child: EmptyData(
                  title:
                      'К сожалению, пользователь\nне оставил данные о парковке'),
            );
          }

          return Padding(
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: ListView.builder(
                itemCount: provider.results.length,
                itemBuilder: (context, index) {
                  return SearchItem(
                    parkModel: provider.results[index],
                    onTap: (value) {
                      provider.setClosePark = value;
                      Navigator.of(context).pop('selected');
                    },
                  );
                }),
          );
        },
      ),
    );
  }
}

class SearchItem extends StatelessWidget {
  final ParkModel parkModel;
  final Function(ParkModel) onTap;
  const SearchItem({Key? key, required this.parkModel, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 30),
          AvatarItem(image: parkModel.user.photo, height: 123, width: 123),
          SizedBox(height: 24),
          Text(
            parkModel.user.name,
            textAlign: TextAlign.center,
            style: kInterSemiBold18,
          ),
          SizedBox(height: 4),
          Text(
            parkModel.user.phone,
            textAlign: TextAlign.center,
            style: kInterReg16ColorBlack,
          ),
          if (parkModel.user.description.length > 0) SizedBox(height: 28),
          if (parkModel.user.description.length > 0)
            Text(
              parkModel.user.description,
              textAlign: TextAlign.center,
              style: kInterReg16ColorBlack.copyWith(color: kColor999999),
            ),
          SizedBox(height: 20),
          AutoItem(
              auto: parkModel.garageItem, onDelete: null, isLoading: false),
          SizedBox(height: 16),
          Container(
            alignment: Alignment.center,
            child: TimeDateItem(
              date: parkModel.date,
              time: parkModel.time,
            ),
          ),
          SizedBox(height: 30),
          ElevatedButton(
              onPressed: () {
                onTap(parkModel);
              },
              child: Text('Закрыть этот авто')),
          SizedBox(height: 16),
          Divider(
            thickness: 1.5,
          ),
        ],
      ),
    );
  }
}
