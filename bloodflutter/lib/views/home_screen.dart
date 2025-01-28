import 'package:bloodflutter/blocs/donor_bloc.dart';
import 'package:bloodflutter/views/stats_screen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Banco de Sangue')),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () async {
              final result = await FilePicker.platform.pickFiles();
              if (result != null) {
                context.read<DonorBloc>().add(
                  UploadDonors(result.files.single.path!)
                );
              }
            },
            child: Text('Carregar JSON'),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<DonorBloc>().add(LoadStats());
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => StatsScreen()),
              );
            },
            child: Text('Ver Estatísticas'),
          ),
        ],
      ),
    );
  }
}