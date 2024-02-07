import 'package:flutter/material.dart';

import 'homepage.dart';

void main() {
  runApp(MaterialApp(
    title: 'Syncfusion PDF Viewer Demo',
    theme: ThemeData(
      useMaterial3: false,
    ),
    home: HomePage(),
  ));
}

/// Represents Homepage for Navigation
// class HomePage extends StatefulWidget {
//   @override
//   _HomePage createState() => _HomePage();
// }

// class _HomePage extends State<HomePage> {
//   final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
//   PdfViewerController controller = PdfViewerController();

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Syncfusion Flutter PDF Viewer'),
//         actions: <Widget>[
//           IconButton(
//             icon: const Icon(
//               Icons.bookmark,
//               color: Colors.white,
//               semanticLabel: 'Bookmark',
//             ),
//             onPressed: () {
//               _pdfViewerKey.currentState?.openBookmarkView();
//             },
//           ),
//         ],
//       ),
//       body: SfPdfViewer.asset(
//         'assets/name.pdf',
//         controller: controller,
//         onAnnotationSelected: (Annotation annotation) {
//           annotation.addListener(() {});
          
//         },
//         onAnnotationAdded: (Annotation annotation) {
//           annotation.color = Colors.yellow;
//           log('selected lines ${controller.}');
//         },
//         onAnnotationDeselected: (Annotation annotation) {
//           annotation.color = Colors.white;
//         },
//         onAnnotationEdited: (Annotation annotation) {
//           annotation.color = Colors.blue;
//         },
//         onAnnotationRemoved: (Annotation annotation) {},
//         key: _pdfViewerKey,
//       ),
//     );
//   }
// }
