import 'package:flutter/material.dart';
import 'package:rise_set/features/rise_set/presentation/providers/rise_set_provider.dart';
import 'package:provider/provider.dart';
import '../../../../../core/util/constants.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    RiseSetProvider riseSetProvider = context.watch<RiseSetProvider>();

    return Scaffold(
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
            //buildLoading(),
            SingleChildScrollView(child: buildResult(context)),
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
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
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
              onPressed: () {},
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Placeholder(
        fallbackHeight: 300,
      ),
    );
  }
}
