import 'package:dip_menu/core/config/theme.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/config/app_textstyle.dart';

class DescriptionTextWidget extends StatefulWidget {
  final String? text;

  const DescriptionTextWidget({super.key, required this.text});

  @override
  _DescriptionTextWidgetState createState() => _DescriptionTextWidgetState();
}

class _DescriptionTextWidgetState extends State<DescriptionTextWidget> {
  String? firstHalf;
  String? secondHalf;

  bool flag = true;

  @override
  void initState() {
    super.initState();

    if (widget.text!.length > 70) {
      firstHalf = widget.text!.substring(0, 70);
      secondHalf = widget.text!.substring(70, widget.text!.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding:  EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: secondHalf!.isEmpty
          ? Text(firstHalf!,
              textAlign: TextAlign.left,
              style: TextStore.textTheme.titleLarge!
                  .copyWith(color: borderColor))
          : Column(
              children: <Widget>[
                Text(flag ? ("${firstHalf!}...") : (firstHalf! + secondHalf!),
                    textAlign: TextAlign.justify,
                    style: TextStore.textTheme.titleLarge!
                        .copyWith(color: borderColor)),
                Material(
                  type: MaterialType.transparency,
                  child: InkWell(

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          flag ? "show more" : "show less",
                          style: TextStyle(color: mainColor),
                        ),
                      ],
                    ),
                    onTap: () {
                      setState(() {
                        flag = !flag;
                      });
                    },
                  ),
                ),
              ],
            ),
    );
  }
}


class ExpandableText extends StatefulWidget {
  const ExpandableText(
      this.text, {
        Key? key,
        this.trimLines = 2,
      })  : assert(text != null),
        super(key: key);

  final String text;
  final int trimLines;

  @override
  ExpandableTextState createState() => ExpandableTextState();
}

class ExpandableTextState extends State<ExpandableText> {
  bool _readMore = true;
  void _onTapLink() {
    setState(() => _readMore = !_readMore);
  }

  @override
  Widget build(BuildContext context) {
    final colorClickableText = mainColor;
    Color widgetColor =Get.isDarkMode ? Colors.white : borderColor;
    TextSpan link = TextSpan(
        text: _readMore ? " ... see more" : " see less",
        style: TextStore.textTheme.titleLarge!
            .copyWith(color: colorClickableText),
        recognizer: TapGestureRecognizer()..onTap = _onTapLink
    );
    Widget result = LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        assert(constraints.hasBoundedWidth);
        final double maxWidth = constraints.maxWidth;
        final text = TextSpan(
          text: widget.text,
        );
        // Layout and measure link
        TextPainter textPainter = TextPainter(
          text: link,
          textDirection: TextDirection.rtl,//better to pass this from master widget if ltr and rtl both supported
          maxLines: widget.trimLines,
          ellipsis: '...',
        );
        textPainter.layout(minWidth: constraints.minWidth, maxWidth: maxWidth);
        final linkSize = textPainter.size;
        // Layout and measure text
        textPainter.text = text;
        textPainter.layout(minWidth: constraints.minWidth, maxWidth: maxWidth);
        final textSize = textPainter.size;
        // Get the endIndex of data
        int? endIndex;
        final pos = textPainter.getPositionForOffset(Offset(
          textSize.width - linkSize.width,
          textSize.height,
        ));
        endIndex = textPainter.getOffsetBefore(pos.offset);
        var textSpan;
        if (textPainter.didExceedMaxLines) {
          textSpan = TextSpan(
            text: _readMore
                ? widget.text.substring(0, 35)
                : widget.text,
            style:  TextStyle(
              color: widgetColor
            ),
            children: <TextSpan>[link],
          );
        } else {
          textSpan = TextSpan(
            text: widget.text,
          );
        }
        return RichText(
          softWrap: true,
          overflow: TextOverflow.clip,
          text: textSpan,
        );
      },
    );
    return result;
  }
}
