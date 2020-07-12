import 'package:flutter/material.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

class HtmlText extends StatefulWidget {
  final String text;

  const HtmlText({Key key, this.text}) : super(key: key);

  @override
  _HtmlTextState createState() => _HtmlTextState();
}

class _HtmlTextState extends State<HtmlText> {
  WebViewPlusController _controller;

  var _height = 1.0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _height,
      child: WebViewPlus(
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (controller) {
          _controller = controller;
          controller.loadString(widget.text + _style);
        },
        onPageFinished: (url) async {
          var height = await _controller.getHeight();
          if (mounted)
            setState(() {
              _height = height;
            });
        },
      ),
    );
  }
}

const _style = '''
<style>
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}
body {
    line-height: 1.35;
    color: #373a3c;
    overflow-wrap: break-word;
    word-wrap: break-word;
    word-break: break-word;
    background-color: #fafafa;
}
blockquote.blue {
    padding: 10px 15px;
    background-color: #f5f5f5;
    border-left: 3px solid #0088c7;
}
ul, ol {
    margin-left: 16px;
}
ul.blue {
    list-style: none;
}
ul.blue li::before {
    content: '\\2022';
    color: #0088c7;
    font-weight: bold;
    display: inline-block;
    width: 1em;
    margin-left: -1em;
}
a {
    text-decoration: none;
    color: #6699cc;
}
.snoski {
    padding: 10px;
    background-color: #eef5f7;
}
.specdiv {
    background-color: #f5f5f5;
    border: 1px solid #e8e8e8;
    padding: 10px;
}
</style>
''';
