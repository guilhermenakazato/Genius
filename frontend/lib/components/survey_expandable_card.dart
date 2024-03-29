import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/survey.dart';
import '../utils/application_colors.dart';
import '../utils/genius_toast.dart';
import '../utils/application_typography.dart';

class SurveyExpandableCard extends StatefulWidget {
  final List<Survey> surveys;
  final String type;
  final Function(Survey) onEdit, onDelete;
  final Color color;

  const SurveyExpandableCard({
    Key key,
    @required this.surveys,
    this.type,
    this.onEdit,
    this.onDelete,
    this.color = ApplicationColors.cardColor,
  }) : super(key: key);

  @override
  _SurveyExpandableCardState createState() => _SurveyExpandableCardState();
}

class _SurveyExpandableCardState extends State<SurveyExpandableCard> {
  List<bool> isOpen;

  @override
  void initState() {
    isOpen = List<bool>.filled(widget.surveys.length, false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionPanelList(
      elevation: 0,
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          isOpen[index] = !isExpanded;
        });
      },
      children: widget.surveys.asMap().entries.map<ExpansionPanel>((entry) {
        return ExpansionPanel(
          canTapOnHeader: true,
          backgroundColor: widget.color,
          isExpanded: isOpen[entry.key],
          body: Align(
            alignment: Alignment.centerLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 12,
                      bottom: 8,
                      top: 8,
                      right: _determineIfShouldHaveRightPadding(),
                    ),
                    child: RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(text: 'Link: '),
                          TextSpan(
                            text: '${entry.value.link}',
                            style: ApplicationTypography.linkStyle,
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                _handleLinkClick(entry.value.link);
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                _determineIfShouldAllowEdition(entry),
              ],
            ),
          ),
          headerBuilder: (BuildContext context, bool isExpanded) {
            return Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(entry.value.name),
              ),
            );
          },
        );
      }).toList(),
    );
  }

  Widget _editWidget(MapEntry<int, Survey> entry) {
    return SizedBox(
      width: 130,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Ink(
              decoration: ShapeDecoration(
                color: ApplicationColors.iconButtonColor,
                shape: CircleBorder(),
              ),
              child: IconButton(
                splashRadius: 24,
                icon: const Icon(
                  Icons.edit_outlined,
                ),
                onPressed: () {
                  widget.onEdit(entry.value);
                },
                color: ApplicationColors.editButtonColor,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Ink(
              decoration: ShapeDecoration(
                color: ApplicationColors.iconButtonColor,
                shape: CircleBorder(),
              ),
              child: IconButton(
                splashRadius: 24,
                icon: const Icon(
                  Icons.close_outlined,
                ),
                onPressed: () {
                  widget.onDelete(entry.value);
                },
                color: ApplicationColors.atentionColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _determineIfShouldAllowEdition(MapEntry<int, Survey> entry) {
    if (widget.type == 'edit') {
      return _editWidget(entry);
    } else {
      return Container();
    }
  }

  double _determineIfShouldHaveRightPadding() {
    if (widget.type == 'edit') {
      return 0;
    } else {
      return 16;
    }
  }

  void _handleLinkClick(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      GeniusToast.showToast('Não foi possível abrir o link.');
    }
  }
}
