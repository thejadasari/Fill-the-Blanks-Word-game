import 'package:blanks/change-notifiers/keys-notifier.dart';
import 'package:blanks/components/coins-converter.view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class KeysView extends StatefulWidget {
  @override
  _KeysViewState createState() => _KeysViewState();
}

class _KeysViewState extends State<KeysView> {
  void launchCoinsConverter(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext _context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: CoinsConverter(
              pop: () {
                Navigator.of(context).pop();
              },
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        launchCoinsConverter(context);
      },
      child: Container(
        height: 30,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColorDark,
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 6,
                vertical: 3,
              ),
              child: Image.asset(
                'assets/images/key.png',
                height: 24,
                width: 24,
              ),
            ),
            Consumer<KeysNotifier>(
              builder: (_, keysNotifier, child) {
                keysNotifier = keysNotifier;
                return Text(keysNotifier.keys.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ));
              },
            ),
            SizedBox(
              width: 6,
            ),
            Icon(
              Icons.add_circle_outline,
              color: Colors.white,
            ),
            SizedBox(
              width: 2,
            ),
          ],
        ),
      ),
    );
  }
}
