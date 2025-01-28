// stats_screen.dart
import 'package:bloodflutter/blocs/donor_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class StatsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Estatísticas')),
      body: BlocBuilder<DonorBloc, DonorState>(
        builder: (context, state) {
          if (state is DonorStatsLoaded) {
            final stats = state.stats;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildStateChart(stats['estados']),
                  const SizedBox(height: 20),
                  _buildAgeImcChart(stats['imc_por_idade']),
                  const SizedBox(height: 20),
                  _buildObesityChart(stats['obesidade']),
                  const SizedBox(height: 20),
                  _buildBloodTypeAgeChart(stats['media_idade_tipo_sanguineo']),
                  const SizedBox(height: 20),
                  _buildDonorsPerReceiverChart(stats['doadores_por_receptor']),
                ],
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _buildStateChart(Map<String, int> data) {
    return SfCartesianChart(
      title: const ChartTitle(text: 'Candidatos por Estado'),
      primaryXAxis: const CategoryAxis(),
      series: <ColumnSeries<MapEntry<String, int>, String>>[
        ColumnSeries(
          dataSource: data.entries.toList(),
          xValueMapper: (entry, _) => entry.key,
          yValueMapper: (entry, _) => entry.value,
          dataLabelSettings: const DataLabelSettings(isVisible: true),
        )
      ],
    );
  }

  Widget _buildAgeImcChart(Map<String, double> data) {
    return SfCartesianChart(
      title: const ChartTitle(text: 'IMC Médio por Faixa Etária'),
      primaryXAxis: const CategoryAxis(),
      series: <LineSeries<MapEntry<String, double>, String>>[
        LineSeries(
          dataSource: data.entries.toList(),
          xValueMapper: (entry, _) => entry.key,
          yValueMapper: (entry, _) => entry.value,
          markerSettings: const MarkerSettings(isVisible: true),
        )
      ],
    );
  }

  Widget _buildObesityChart(Map<String, double> data) {
    return SfCircularChart(
      title: const ChartTitle(text: 'Percentual de Obesidade'),
      legend: const Legend(isVisible: true),
      series: <PieSeries<MapEntry<String, double>, String>>[
        PieSeries(
          dataSource: data.entries.toList(),
          xValueMapper: (entry, _) => entry.key,
          yValueMapper: (entry, _) => entry.value,
          dataLabelSettings: const DataLabelSettings(isVisible: true),
        )
      ],
    );
  }

  Widget _buildBloodTypeAgeChart(Map<String, double> data) {
    return SfCartesianChart(
      title: const ChartTitle(text: 'Média de Idade por Tipo Sanguíneo'),
      primaryXAxis: const CategoryAxis(),
      series: <BarSeries<MapEntry<String, double>, String>>[
        BarSeries(
          dataSource: data.entries.toList(),
          xValueMapper: (entry, _) => entry.key,
          yValueMapper: (entry, _) => entry.value,
          dataLabelSettings: const DataLabelSettings(isVisible: true),
        )
      ],
    );
  }

  Widget _buildDonorsPerReceiverChart(Map<String, int> data) {
    return SfCartesianChart(
      title: const ChartTitle(text: 'Doadores por Tipo Receptor'),
      primaryXAxis: const CategoryAxis(),
      series: <ColumnSeries<MapEntry<String, int>, String>>[
        ColumnSeries(
          dataSource: data.entries.toList(),
          xValueMapper: (entry, _) => entry.key,
          yValueMapper: (entry, _) => entry.value,
          dataLabelSettings: const DataLabelSettings(isVisible: true),
        )
      ],
    );
  }
}
