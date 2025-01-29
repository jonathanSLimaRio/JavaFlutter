package com.javablood.javaFlutter.Services;

import com.javablood.javaFlutter.models.Donor;
import java.util.List;
import java.util.Map;

public interface DonorService {
    void processarJson(List<Donor> doadores);
    Map<String, Long> contarDoadoresPorEstado();
    Map<String, Double> calcularImcMedioPorFaixaEtaria();
    Map<String, Double> calcularPercentualObesosPorSexo();
    Map<String, Double> calcularMediaIdadePorTipoSanguineo();
    Map<String, Long> contarDoadoresCompativeis();
}
