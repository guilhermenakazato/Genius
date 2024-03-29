import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../components/gradient_button.dart';
import '../../components/input_with_animation.dart';
import '../../utils/application_colors.dart';
import '../../utils/genius_toast.dart';

class SendMail extends StatelessWidget {
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();
  final String email;
  final String type;

  SendMail({
    Key key,
    this.email = 'geniusapp.science@gmail.com',
    this.type = 'contact_dev',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ApplicationColors.appBarColor,
          elevation: 0,
          title: Text(
            _determineAppBarTitle(),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 5, 16, 5),
                child: InputWithAnimation(
                  controller: _subjectController,
                  type: TextInputType.name,
                  label: 'Assunto',
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 5, 16, 5),
                child: InputWithAnimation(
                  controller: _messageController,
                  type: TextInputType.multiline,
                  label: 'Mensagem',
                  allowMultilines: true,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GradientButton(
                  onPressed: () {
                    _sendEmail();
                  },
                  text: 'Enviar',
                  width: 270,
                  height: 50,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  void _sendEmail() async {
    final subject = _subjectController.text;
    final message = _messageController.text;

    final url = Uri(
      scheme: 'mailto',
      path: email,
      query: _encodeQueryParameters(<String, String>{
        'subject': subject,
        'body': message,
      }),
    );

    if (await canLaunch(url.toString())) {
      await launch(url.toString());
    } else {
      GeniusToast.showToast('Não foi possível abrir o link.');
    }
  }

  String _determineAppBarTitle() {
    if (type == 'feed' || type == 'search') {
      return 'Contatar cientistas';
    } else {
      return 'Contatar desenvolvedores';
    }
  }
}
