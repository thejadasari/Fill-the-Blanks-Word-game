import 'package:blanks/change-notifiers/game-mode-notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DifficultyOptions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 260,
      padding: EdgeInsets.only(top: 5),
      child: Consumer<GameModeNotifier>(
        builder: (_, gameMode, child) {
          return ListView(
            itemExtent: 80,
            children: <Widget>[
              ...(gameMode.options
                  .map((Map<String, dynamic> option) => Card(
                        key: ValueKey(option['mode']),
                        elevation: 4,
                        child: InkWell(
                          splashColor: Theme.of(context).primaryColorLight,
                          onTap: () {
                            gameMode.updateGameMode(option['mode']);
                          },
                          child: ListTile(
                            title: Text(
                              option['title'],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColorDark,
                              ),
                            ),
                            subtitle: Text(option['subTitle']),
                            trailing: option['selected']
                                ? IconButton(
                                    icon: Icon(Icons.check),
                                    tooltip: "selected",
                                    color: Theme.of(context).primaryColor,
                                    onPressed: () {},
                                    iconSize: 30,
                                  )
                                : SizedBox(
                                    width: 10,
                                    height: 10,
                                  ),
                          ),
                        ),
                      ))
                  .toList())
            ],
          );
        },
      ),
    );
  }
}
