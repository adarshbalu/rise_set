import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:rise_set/features/rise_set/presentation/providers/rise_set_provider.dart';
import 'package:provider/provider.dart';
import '../../../../../core/util/constants.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController latitude, longitude;
  @override
  void initState() {
    latitude = TextEditingController();
    longitude = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    RiseSetProvider riseSetProvider = context.watch<RiseSetProvider>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        actions: [
          IconButton(
              icon: Icon(
                Icons.my_location,
                color: Colors.blue,
                size: 30,
              ),
              onPressed: () async {
                await riseSetProvider.getRiseAndSetTimeFromMyLocation();
              })
        ],
      ),
      bottomNavigationBar: Text(
        'Rise and Set Times',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headline5,
      ),
      body: Container(
        margin: EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            mapEvent(riseSetProvider.status),
            SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Latitude',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                      ),
                      controller: latitude,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: longitude,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Longitude',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                        ),
                      )),
                ),
              ],
            ),
            SizedBox(
              height: 16,
            ),
            RaisedButton(
              elevation: 2,
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              color: ColorConstants.DEEP_BLUE,
              textColor: Colors.white,
              onPressed: () async {
                await riseSetProvider.getRiseSetTimesFromInput(
                    latitude.text, longitude.text);

                longitude.clear();
                latitude.clear();
              },
              child: Text('Get Rise and Set Time'),
            )
          ],
        ),
      ),
    );
  }

  Widget buildLoading() {
    return Center(
      child: Column(
        children: [
          Image.asset(
            LOGO_PNG_LOCATION,
            height: 100,
            width: 100,
          ),
          SizedBox(
            height: 16,
          ),
          CircularProgressIndicator(
            valueColor:
                AlwaysStoppedAnimation<Color>(ColorConstants.LIGHT_YELLOW),
            backgroundColor: ColorConstants.DARK_YELLOW,
          ),
          SizedBox(
            height: 8,
          ),
        ],
      ),
    );
  }

  Widget buildResult(BuildContext context) {
    RiseSetProvider riseSetProvider = context.watch<RiseSetProvider>();
    final DateFormat format = DateFormat.jm();
    String sunRise = format.format(riseSetProvider.riseSet.sunrise.toLocal());
    String sunSet = format.format(riseSetProvider.riseSet.sunset.toLocal());
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Card(
              child: Container(
                  height: 130,
                  width: 130,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(child: SvgPicture.asset('assets/svg/rise.svg')),
                      SizedBox(
                        height: 16,
                      ),
                      Text(sunRise),
                      SizedBox(
                        height: 8,
                      ),
                    ],
                  ))),
          Card(
              child: Container(
                  height: 130,
                  width: 130,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(child: SvgPicture.asset('assets/svg/set.svg')),
                      SizedBox(
                        height: 16,
                      ),
                      Text(sunSet),
                      SizedBox(
                        height: 8,
                      ),
                    ],
                  ))),
        ],
      ),
    );
  }

  Widget buildEmpty() {
    return Container(
      child: Column(
        children: [
          Image.asset(
            LOGO_PNG_LOCATION,
            height: 100,
            width: 100,
          ),
          SizedBox(
            height: 16,
          ),
          Text(
            'Add values to search',
            style: Theme.of(context).textTheme.headline6,
          )
        ],
      ),
    );
  }

  Widget buildError(BuildContext context) {
    RiseSetProvider riseSetProvider = context.watch<RiseSetProvider>();
    return Container(
      child: Column(
        children: [
          Image.asset(
            LOGO_PNG_LOCATION,
            height: 100,
            width: 100,
          ),
          SizedBox(
            height: 16,
          ),
          Text(
            'Error Occurred',
            style: Theme.of(context).textTheme.headline6,
          ),
          Text(
            riseSetProvider.error,
            style: Theme.of(context).textTheme.subtitle1,
          )
        ],
      ),
    );
  }

  Widget mapEvent(Status status) {
    if (status == Status.EMPTY) {
      return buildEmpty();
    } else if (status == Status.ERROR) {
      return buildError(context);
    } else if (status == Status.LOADED) {
      return buildResult(context);
    } else
      return buildLoading();
  }
}
