package com.javablood.javaFlutter.Services;

import com.javablood.javaFlutter.models.Donor;
import com.javablood.javaFlutter.repositories.DonorRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
public class DonorServiceImpl implements DonorService {

    @Autowired
    private DonorRepository donorRepository;

    @Override
    public Map<String, Long> contarDoadoresPorEstado() {
        return donorRepository.countByEstado().stream()
                .collect(Collectors.toMap(
                        e -> (String) e.get("estado"),
                        e -> (Long) e.get("total")));
    }

    @Override
    public void processarJson(List<Donor> doadores) {
        donorRepository.saveAll(doadores);
    }

    @Override
    public Map<String, Double> calcularImcMedioPorFaixaEtaria() {
        List<Map<String, Object>> resultados = donorRepository.calculateImcMedioPorFaixaEtaria();
        return resultados.stream()
                .filter(entry -> entry.get("faixaInicio") != null && entry.get("imcMedio") != null)
                .collect(Collectors.toMap(
                        entry -> {
                            int faixaInicio = ((Number) entry.get("faixaInicio")).intValue();
                            return String.format("%d-%d", faixaInicio, faixaInicio + 9);
                        },
                        entry -> ((Number) entry.get("imcMedio")).doubleValue()));
    }

    @Override
    public Map<String, Double> calcularPercentualObesosPorSexo() {
        List<Map<String, Object>> resultados = donorRepository.calculatePercentualObesosPorSexo();
        return resultados.stream()
                .collect(Collectors.toMap(
                        entry -> (String) entry.get("sexo"),
                        entry -> ((Number) entry.get("percentual")).doubleValue()));
    }

    @Override
    public Map<String, Double> calcularMediaIdadePorTipoSanguineo() {
        List<Map<String, Object>> resultados = donorRepository.calculateMediaIdadePorTipoSanguineo();
        return resultados.stream()
                .collect(Collectors.toMap(
                        entry -> (String) entry.get("tipo"),
                        entry -> ((Number) entry.get("mediaIdade")).doubleValue()));
    }

    @Override
    public Map<String, Long> contarDoadoresCompativeis() {
        List<Object[]> resultados = donorRepository.countDoadoresCompativeis();
        return resultados.stream()
                .collect(Collectors.toMap(
                        entry -> (String) entry[0], // Assuming receptor is at index 0
                        entry -> ((Number) entry[1]).longValue() // Assuming total is at index 1
                ));
    }

}