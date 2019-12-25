// useHint() {
//     var _draggables = [...dragables];
//     var __draggables = [];
//     for (Map _draggable in _draggables) {
//       __draggables.add({
//         "char": _draggable['char'],
//         "hide": false,
//       });
//     }
//     var _displayedChars = [];
//     for (Map _displayedChar in displayedChars) {
//       if (_displayedChar['hidden']) {
//         _displayedChars.add({
//           "char": "",
//           "hidden": true,
//         });
//       } else {
//         _displayedChars.add(_displayedChar);
//       }
//     }
//     if (__draggables.length == 1) {
//       setState(() {
//         isWordFound = true;
//         updateWordInDB();
//       });
//       return;
//     }
//     int fifty = (dragables.length / 2).ceil();
//     for (var index = 0; index < fifty; index++) {
//       var draggable = _draggables[index]['char'];
//       var i = 10;
//       var charIndex = _word.indexOf(draggable);
//       __draggables.removeAt(0);
//       for (; i > 0; i--) {
//         Map displayedChar = _displayedChars[charIndex];
//         if (displayedChar['hidden'] == true) {
//           print('in');
//           _displayedChars[charIndex] = {
//             "char": draggable,
//             "hidden": false,
//           };
//           break;
//         }
//         charIndex = _word.indexOf(draggable, charIndex + 1);
//       }
//     }
//     setState(() {
//       displayedChars = _displayedChars;
//       dragables = __draggables;
//     });
//   }