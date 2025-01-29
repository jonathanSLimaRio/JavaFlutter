import 'package:bloodflutter/blocs/donor_bloc.dart';
import 'package:bloodflutter/widgets/stats_charts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Análise Estatística'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: BlocBuilder<DonorBloc, DonorState>(
        builder: (context, state) {
          if (state is DonorStatsLoaded) {
            return _buildStatsCards(state.stats);
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _buildStatsCards(Map<String, dynamic> stats) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildChartCard(
          title: 'Distribuição por Estados',
          child: StateChart(data: stats['estados']),
        ),
        _buildChartCard(
          title: 'IMC Médio por Faixa Etária',
          child: AgeImcChart(data: stats['imc_por_idade']),
        ),
        _buildChartCard(
          title: 'Obesidade por Gênero',
          child: ObesityChart(data: stats['obesidade']),
        ),
        _buildChartCard(
          title: 'Idade Média por Tipo Sanguíneo',
          child: BloodTypeAgeChart(data: stats['media_idade_tipo_sanguineo']),
        ),
        _buildChartCard(
          title: 'Doadores Compatíveis',
          child: DonorsPerReceiverChart(data: stats['doadores_por_receptor']),
        ),
      ],
    );
  }

  Widget _buildChartCard({required String title, required Widget child}) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(height: 300, child: child),
          ],
        ),
      ),
    );
  }
}
