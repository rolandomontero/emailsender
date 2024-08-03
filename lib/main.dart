import 'package:flutter/foundation.dart';
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
  final String senderEmail = 'app@histologyplus.mclautaro.cl';
  final String senderPassword = 'Rmx21071972#';
  final String recipientEmail = 'rolandomontero@hotmail.com';
  final String verificationCode = 'MHG1243';

  const EmailSender({super.key}); // Puedes generar un código dinámicamente

  Future<void> sendEmail() async {
    final smtpServer = SmtpServer('histologyplus.mclautaro.cl',
        username: senderEmail, password: senderPassword);

    final message = Message()
      ..from = Address(senderEmail, 'App')
      ..recipients.add(recipientEmail)
      ..subject = 'Código de Verificación'
      ..text = 'Su código de verificación es: $verificationCode';

    try {
      final sendReport = await send(message, smtpServer);
      if (kDebugMode) {
        print('Mensaje enviado: $sendReport');
      }
    } on MailerException catch (e) {
      if (kDebugMode) {
        print('Error al enviar el mensaje: $e');
      }
      for (var p in e.problems) {
        if (kDebugMode) {
          print('Problema: ${p.code}: ${p.msg}');
        }
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
