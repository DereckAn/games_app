import 'package:app_juegos/provider/room_data_provider.dart';
import 'package:app_juegos/widgets/custome_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WaitingLobby extends StatefulWidget {
  const WaitingLobby({super.key});

  @override
  State<WaitingLobby> createState() => _WaitingLobbyState();
}

class _WaitingLobbyState extends State<WaitingLobby> {
  late TextEditingController _usernameController;
  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController(
        text: Provider.of<RoomDataProvider>(context, listen: false)
            .roomData['_id']);
    // print(_usernameController.text.toString());
  }

  @override
  void dispose() {
    super.dispose();
    _usernameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Esperando a que se una otro jugador...',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        const SizedBox(height: 20),
        CustomTextField(
          controller: _usernameController,
          hintText: _usernameController.text.toString(),
          isReadOnly: true,
        ),
        // CircularProgressIndicator(),
      ],
    );
  }
}
