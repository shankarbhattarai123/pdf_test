import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> with WidgetsBindingObserver {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  PdfViewerController controller = PdfViewerController();
  // Page controller is not required
  // late PageController pageController;
  int curentPage = 2;

  @override
  void initState() {
    super.initState();
    // pageController = PageController(initialPage: curentPage);
    WidgetsBinding.instance.addObserver(this);
  }

  Color generateRandomColor() {
    final Random random = Random();
    return Color.fromRGBO(
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
      1.0,
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print('app status ==> ${state.name}');
    if (state.name == 'paused') {
      _save();
    }
  }

  Future<File> _getPdf() async {
    final Directory dir = await getTemporaryDirectory();
    final File file = File('${dir.path}/temp.pdf');

    // Check if the file exists
    if (file.existsSync()) {
      // If file exists, return the file
      return file;
    } else {
      // If file don't exists, create the file from asset and return it
      final ByteData data = await rootBundle.load('assets/name.pdf');
      final Uint8List bytes = data.buffer.asUint8List();
      await file.writeAsBytes(bytes);
      return file;
    }
  }

  Future<void> _save() async {
    final Directory dir = await getTemporaryDirectory();
    // Saving the file to a temporary location
    final File file = File('${dir.path}/temp.pdf');

    // Save annotations to the PDF document
    final List<int> bytes = await controller.saveDocument(
        flattenOption: PdfFlattenOption.formFields);
    await file.writeAsBytes(bytes);
    // controller.jumpToPage(controller.pageNumber);
    // setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              _save();
            }),
        title: const Text('Syncfusion Flutter PDF Viewer'),
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.save),
              onPressed: () {
                _save();
              }),
        ],
      ),
      body: FutureBuilder<File>(
          future: _getPdf(),
          builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              return SfPdfViewer.file(
                snapshot.data!,
                controller: controller,
                key: _pdfViewerKey,
                onPageChanged: (PdfPageChangedDetails val) {
                  curentPage = controller.pageNumber;
                  // It is not recommended to call setState within the onPageChanged callback
                  // setState(() {});
                },
                onAnnotationDeselected: (Annotation annotation) {
                  // controller.clearSelection();
                  // annotation.color = Colors.white;
                  // annotation.opacity = 0;
                  // annotation.author = 'Guest';
                  // annotation.subject = 'Text Markup';

                  // Instead of assigning white color and 0 opacity, we can remove the annotation
                  // if your intention is to remove the annotation
                  controller.removeAnnotation(annotation);
                  // Save the document after removing the annotation
                  _save();
                },
                onAnnotationAdded: (Annotation annotation) {
                  final Color randomColor = generateRandomColor();
                  annotation.color = randomColor;
                  annotation.author = 'Guest';
                  annotation.subject = 'Text Markup';
                  _save();
                },
                // To jump to the desired page number on document load
                // onDocumentLoaded: (details) {
                //   controller.jumpToPage(curentPage);
                // },
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
