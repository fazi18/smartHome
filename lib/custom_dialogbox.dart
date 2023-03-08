// import 'package:flutter/material.dart';

// Future<void> _showMyDialog({
//   required BuildContext context,
//   required Function() onSaved,
//   required TextEditingController controller,
// }) async {
//   return showDialog<void>(
//     context: context,
//     barrierDismissible: false, // user must tap button!
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: TextFormField(
//           controller: controller,
//           decoration: InputDecoration(
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(30.0),
//               borderSide: BorderSide(color: Colors.grey.shade300),
//             ),
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(30.0),
//               borderSide: BorderSide(color: Theme.of(context).primaryColor),
//             ),
//           ),
//         ),
//         content: const Text(''),
//         actions: <Widget>[
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//             Widget: null,
//             child: const Text('Cancel'),
//           ),
//           TextButton(
//             child: const Text('Save'),
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//           ),
//         ],
//       );
//     },
//   );
// }
