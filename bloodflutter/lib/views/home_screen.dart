import 'package:bloodflutter/blocs/donor_bloc.dart';
import 'package:bloodflutter/views/stats_screen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blood Analytics'),
        actions: [
          IconButton(
            icon: const Icon(Icons.analytics),
            onPressed: () {
              context.read<DonorBloc>().add(LoadStats());
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const StatsScreen()));
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildLocalUploadButton(context),
            const SizedBox(height: 20),
            _buildUploadButton(context),
            const SizedBox(height: 20),
            _buildStatsButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildUploadButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: FilledButton.icon(
        icon: const Icon(Icons.cloud_upload),
        label: const Text('ENVIAR DADOS'),
        style: FilledButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        onPressed: () async {
          final result =
              await FilePicker.platform.pickFiles(type: FileType.any);
          if (result != null) {
            context
                .read<DonorBloc>()
                .add(UploadDonors(result.files.single.path!));
          }
        },
      ),
    );
  }

  Widget _buildStatsButton(BuildContext context) {
    return BlocConsumer<DonorBloc, DonorState>(
      listener: (context, state) {
        if (state is DonorError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          child: FilledButton.icon(
            icon: const Icon(Icons.insights),
            label: state is DonorLoading
                ? const CircularProgressIndicator()
                : const Text('VER ESTATÍSTICAS'),
            style: FilledButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 18),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              backgroundColor: Theme.of(context).colorScheme.secondary,
            ),
            onPressed: () {
              context.read<DonorBloc>().add(LoadStats());
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const StatsScreen()));
            },
          ),
        );
      },
    );
  }

  Widget _buildLocalUploadButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: FilledButton.icon(
        icon: const Icon(Icons.upload_file),
        label: const Text('CARREGAR DADOS LOCAIS'),
        style: FilledButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          backgroundColor: Theme.of(context).colorScheme.tertiary,
        ),
        onPressed: () {
          context.read<DonorBloc>().add(UploadLocalDonors());
        },
      ),
    );
  }
}
