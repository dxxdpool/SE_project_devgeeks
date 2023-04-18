import 'package:flutter/material.dart';
import 'package:productivity_app/trapezoid_button.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

// note we have to change .yaml file

class ResourceHomePage extends StatefulWidget {
  const ResourceHomePage({super.key});

  @override
  _ResourceHomePageState createState() => _ResourceHomePageState();
}

class _ResourceHomePageState extends State<ResourceHomePage> {
  List<String> books = ['Descriptive_statistics.pdf',
    'SQL_Practice_Problems.pdf',
    'Differential_Calculus_for_Engineers.pdf',
    'Object_Oriented_Programming_With_Cpp.pdf',
    'Computer_Architecture.pdf'
  ];

  List <String> notes = [
    'Number_Theory.pdf',
    'Numerical_Diff.pdf',
    'Numerical_Integration.pdf'

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: TrapezoidalAppBar(
        title : 'E - Library', color: Colors.blue.shade800,),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BookListPage(books),
                  ),
                );
              },
              child: Image.asset(
                'assets/Icons/Group 18 (2).png',
                width: 300,
                height: 300,
              ),
            ),
            const SizedBox(height: 30),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NoteListPage(notes),
                  ),
                );
              },
              child: Image.asset(
                'assets/Icons/Group 19.png',
                width: 175,
                height: 175,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class BookListPage extends StatelessWidget {
  final List<String> books;

  BookListPage(this.books);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Book List'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: books.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Container(
                      width: 200.0, // custom width of the ListTile
                      height: 100.0, // custom height of the ListTile
                      child: ListTileTheme(
                        tileColor: Colors.blue.shade200.withOpacity(0.45),
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          leading: Icon(Icons.book),
                          title: Text(books[index]),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PdfViewerPage(
                                  key: UniqueKey(),
                                  assetPath: 'assets/books/${books[index]}',
                                  bookName: books[index],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}



// --------------------------------------------------------------------------------------------------------------------




class NoteListPage extends StatelessWidget {
  final List<String> notes;

  NoteListPage(this.notes);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Notes List'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Container(
                      width: 200.0, // custom width of the ListTile
                      height: 100.0, // custom height of the ListTile
                      child: ListTileTheme(
                        tileColor: Colors.blue.shade200,
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          leading: Icon(Icons.book),
                          title: Text(notes[index]),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PdfViewerPage(
                                  key: UniqueKey(),
                                  assetPath: 'assets/notes/${notes[index]}',
                                  bookName: notes[index],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}


// --------------------------------------------------------------------------------------------------------------------




class PdfViewerPage extends StatefulWidget {
  final String assetPath;
  final String bookName;
  PdfViewerPage({required Key key, required this.assetPath, required this.bookName}) : super(key: key);

  @override
  _PdfViewerPageState createState() => _PdfViewerPageState();
}

class _PdfViewerPageState extends State<PdfViewerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.bookName),
      ),
      body: Center(
        child: SfPdfViewer.asset(
          widget.assetPath,
          canShowScrollHead: false,
        ),
      ),
    );
  }
}


// --------------------------------------------------------------------------------------------------------------------
