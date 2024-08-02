import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Enviar Código por Correo'),
        ),
        body:const EmailSender(),
      ),
    );
  }
}

class EmailSender extends StatelessWidget {
  final String senderEmail = 'rolandomontero@mclautaro.cl';
  final String senderPassword = 'Rmx21071972#';
  final String recipientEmail = 'rolandomontero@hotmail.com';
  final String verificationCode = 'MHG1243';

  const EmailSender({super.key}); // Puedes generar un código dinámicamente

  Future<void> sendEmail() async {
    final smtpServer = SmtpServer('mail.mclautaro.cl',
        username: senderEmail, password: senderPassword);

    final message = Message()
      ..from = Address(senderEmail, 'Rolando Montero')
      ..recipients.add(recipientEmail)
      ..subject = 'Código de Verificación'
      ..text = 'Su código de verificación es: $verificationCode';

    try {
      final sendReport = await send(message, smtpServer);
      print('Mensaje enviado: ' + sendReport.toString());
    } on MailerException catch (e) {
      print('Error al enviar el mensaje: $e');
      for (var p in e.problems) {
        print('Problema: ${p.code}: ${p.msg}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: sendEmail,
        child:const Text('Enviar Código'),
      ),
    );
  }
}
