import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
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
                          hintText: 'Latitude',
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder()),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                            hintText: 'Longitude',
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder()),
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
              color: Colors.orange,
              textColor: Colors.white,
              onPressed: () {},
              child: Text('Get Rise and Set Time'),
            )
          ],
        ),
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
