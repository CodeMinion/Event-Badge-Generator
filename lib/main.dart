import 'dart:async';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';

import 'package:another_brother/label_info.dart';
import 'package:another_brother/printer_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:ui' as ui;

import 'package:translator/translator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String _activeLanguageCode = 'ar';

  final Map<String, String> _languageMap = {
    /*
    "Afrikaans": "af",
    "Albanian": "sq",
    "Amharic": "Amharic",
    "Arabic": "ar",
    "Armenian": "hy",
    "Azerbaijani": "az",
    "Basque": "eu",
    "Belarusian": "be",
    "Bengali": "bn",
*/

  "Hindi": "hi",
  "Pashto":"ps",
  "Portuguese": "pt",
  "Hmong": "hmn",
  "Croatian":"hr",
  "Haitian Creole":"ht",
  "Hungarian": "hu",
  "Yiddish": "yi",
  "Armenian": "hy",
  "Yoruba":"yo",
  "Indonesian": "id",
  "Igbo": "ig",
  "Afrikaans": "af",
  "Icelandic":"is",
  "Italian":"it",
  "Amharic": "am",
  "Hebrew": "iw",
  "Arabic": "ar",
  "Japanese": "ja",
  "Azerbaijani": "az",
  "Zulu": "zu",
  "Romanian": "ro",
  "Cebuano": "ceb",
  "Belarusian": "be",
  "Russian": "ru",
  "Bulgarian": "bg",
  "Kinyarwanda": "rw",
  "Bengali": "bn",
  "Javanese": "jw",
  "Bosnian": "bs",
  "Sindhi":"sd",
  "Georgian":"ka",
  "Sinhala": "si",
  "Slovak": "sk",
  "Slovenian": "sl",
  "Samoan": "sm",
  "Shona":"sn",
  "Somali":"so",
  "Albanian":"sq",
  "Catalan": "ca",
  "Serbian": "sr",
  "Kazakh": "kk",
  "Sesotho": "st",
  "Khmer": "km",
  "Sundanese": "su",
  "Kannada": "kn",
  "Swedish": "sv",
  "Korean": "ko",
  "Swahili":"sw",
  "Chinese (Traditional)": "zh-TW",
  "Kurdish (Kurmanji)": "ku",
  "Corsican": "co",
  "Tamil": "ta",
  "Kyrgyz": "ky",
  "Czech": "cs",
  "Telugu": "te",
  "Tajik": "tg",
  "Thai": "th",
  "Latin": "la",
  "Luxembourgish": "lb",
  "Welsh": "cy",
  "Turkmen": "tk",
  "Filipino": "tl",
  "Danish": "da",
  "Turkish": "tr",
  "Tatar": "tt",
  "German": "de",
  "Lao": "lo",
  "Lithuanian": "lt",
  "Latvian": "lv",
  "Chinese (Simplified)": "zh-CN",
  "Uyghur": "ug",
  "Ukrainian": "uk",
  "Malagasy":"mg",
  "Maori": "mi",
  "Urdu": "ur",
  "Macedonian": "mk",
  "Hawaiian": "haw",
  "Malayalam": "ml",
  "Mongolian": "mn",
  "Marathi": "mr",
  "Uzbek": "uz",
  "Malay": "ms",
  "Greek": "el",
  "Maltese": "mt",
  "English": "en",
  "Esperanto": "eo",
  "Myanmar (Burmese)": "my",
  "Spanish":"es",
  "Estonian": "et",
  "Basque": "eu",
  "Vietnamese": "vi",
  "Nepali": "ne",
  "Persian": "fa",
  "Dutch":"nl",
  "Norwegian": "no",
  "Finnish": "fi",
  "Chichewa": "ny",
  "French": "fr",
  "Frisian": "fy",
  "Irish": "ga",
  "Scots Gaelic": "gd",
  "Odia (Oriya)": "or",
  "Galician": "gl",
  "Gujarati": "gu",
  "Xhosa": "xh",
  "Punjabi": "pa",
  "Hausa": "ha",
    "Polish":"pl",
  };

  Future<Translation> getNameTagHeader({String to = 'ar'}) {
    final translator = GoogleTranslator();
    final input = "Hello, I'm".toUpperCase();
    return translator.translate(input, from: 'en', to: to);
  }

  Future<ByteData> getTag() async {

    PictureRecorder recorder = PictureRecorder();
    Canvas c = Canvas(recorder);
    Paint paint = new Paint();
    paint.color = Color.fromRGBO(255, 0, 0, 1);
    Rect bounds = new Rect.fromLTWH(0, 0, 300, 100);
    c.drawRect(bounds, paint);
    
    ui.Image badgeBackground = await loadImage("assets/images/IMG_Blank.PNG");
    c.drawImage(badgeBackground, Offset.zero, paint);

    //Translation translation = await getNameTagHeader(to:_activeLanguageCode);
    Translation translation = await getNameTagHeader(to:"ja");

    int tagWidth = 2048;
    int tagHeight = 1471;
    double tagHorizontalPadding = 100;
    int tagNameSectionHeight = 552;

    /*
    final TextPainter textPainter = TextPainter(
        text: TextSpan(text: translation.text, style: TextStyle(
          color: Colors.white,
              fontSize: 300,
        )),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      maxLines: 1
    )
      ..layout(maxWidth: tagWidth.toDouble());

    textPainter.paint(c, Offset.zero);
*/
    double fontSize = 300;
    TextStyle style = TextStyle(
      color: Colors.white,
      fontSize: fontSize,
    );

    ui.ParagraphBuilder paragraphBuilder = ui.ParagraphBuilder(
        ui.ParagraphStyle(
          fontSize:   style.fontSize,
          fontFamily: style.fontFamily,
          fontStyle:  style.fontStyle,
          fontWeight: style.fontWeight,
          textAlign: TextAlign.center,
          maxLines: 1,
        )
    )
      ..pushStyle(style.getTextStyle())
      ..addText(translation.text);

    ui.Paragraph paragraph = paragraphBuilder.build()..layout(ui.ParagraphConstraints(width: tagWidth.toDouble() - tagHorizontalPadding*2));
    // TODO Find font size that best fits the tag. Some greetings might be longer.
    print ("Exceed Line Limit: ${paragraph.didExceedMaxLines}");

    while (paragraph.didExceedMaxLines) {
      fontSize -= 10;
      style = TextStyle(
        color: Colors.white,
        fontSize: fontSize,
      );
      paragraphBuilder = ui.ParagraphBuilder(
          ui.ParagraphStyle(
            fontSize:   style.fontSize,
            fontFamily: style.fontFamily,
            fontStyle:  style.fontStyle,
            fontWeight: style.fontWeight,
            textAlign: TextAlign.center,
            maxLines: 1,
          )
      )
        ..pushStyle(style.getTextStyle())
        ..addText(translation.text);

      paragraph = paragraphBuilder.build()..layout(ui.ParagraphConstraints(width: tagWidth.toDouble() - tagHorizontalPadding*2));
    }

    double leftOffset = (tagWidth - paragraph.width) /2;
    double topOffset = (tagNameSectionHeight - paragraph.height ) /2;
    c.drawParagraph(paragraph, Offset(leftOffset, topOffset));

    var picture = await recorder.endRecording().toImage(tagWidth, tagHeight);

    return picture.toByteData(format: ImageByteFormat.png);
  }

  Future<ui.Image> loadImage(String assetPath) async {
    final ByteData img = await rootBundle.load(assetPath);
    final Completer<ui.Image> completer = new Completer();
    ui.decodeImageFromList(new Uint8List.view(img.buffer), (ui.Image img) {
      return completer.complete(img);
    });
    return completer.future;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FutureBuilder(
                future: getTag(),
                builder: (buildContext, AsyncSnapshot<ByteData> snapshot) {
                    if (snapshot.hasData) {
                      return Image.memory(snapshot.data.buffer.asUint8List());
                    }
                    else {
                      return Text("No Translation");
                    }
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          showDialog(context: context, builder: (BuildContext dialogContext){
            return AlertDialog(
              contentPadding: EdgeInsets.only(left: 15),
              title: Text("Select Printer"),
              content: Container(
                  height: MediaQuery.of(context).size.width*0.8,
                  child: WifiPrinterListPage()),
            );
          });
        },
        tooltip: 'Print',
        child: Icon(Icons.print),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class WifiPrinterListPage extends StatefulWidget {
  WifiPrinterListPage({Key key, this.imageToPrint}) : super(key: key);

  final ui.Image imageToPrint;

  @override
  _WifiPrinterListPageState createState() => _WifiPrinterListPageState();
}

class _WifiPrinterListPageState extends State<WifiPrinterListPage> {
  Future<List<NetPrinter>> getMyNetworkPrinters() async {
    Printer printer = new Printer();
    PrinterInfo printInfo = new PrinterInfo();

    await printer.setPrinterInfo(printInfo);
    return printer.getNetPrinters([Model.QL_1110NWB.getName()]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder(
        future: getMyNetworkPrinters(),
        builder: (buildContext, snapShot) {
          if (snapShot.connectionState == ConnectionState.waiting) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Looking for network printers."),
            );
          }

          if (snapShot.hasData) {
            // TODO Return a list
            List<NetPrinter> foundPrinters = snapShot.data;

            if (foundPrinters.isEmpty) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("No printers found."),
              );
            }

            return ListView.builder(
                itemCount: foundPrinters.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text("Printer: ${foundPrinters[index].modelName}"),
                      subtitle: Text("IP: ${foundPrinters[index].ipAddress}"),
                      onTap: () async {
                        print ("Printing Image....");

                        if (!await Permission.storage.request().isGranted) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                  "Storage permissions are required to print."),
                            ),
                          ));
                          return;
                        }
                        Printer printer = new Printer();
                        PrinterInfo printInfo = new PrinterInfo();
                        printInfo.port = Port.NET;
                        printInfo.printerModel = Model.QL_1110NWB;
                        printInfo.isAutoCut = true;
                        printInfo.ipAddress = foundPrinters[index].ipAddress;
                        printInfo.labelNameIndex =
                            QL1100.ordinalFromID(QL1100.W62.getId());
                        printInfo.printMode = PrintMode.FIT_TO_PAGE;

                        printer.setPrinterInfo(printInfo);

                        PrinterStatus status =
                        await printer.printImage(widget.imageToPrint);

                        print ("Got Error Code: ${status.errorCode}");
                        if (status.errorCode != ErrorCode.ERROR_NONE) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                  "Print failed with error: ${status.errorCode.getName()}."),
                            ),
                          ));
                        }
                      },
                    ),
                  );
                });
          } else if (snapShot.hasError) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Error connecting to another_brother."),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Looking for network printers."),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          setState(() {});
        },
        tooltip: 'Retry',
        child: Icon(Icons.refresh),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
