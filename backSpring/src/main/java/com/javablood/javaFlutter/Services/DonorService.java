package com.javablood.javaFlutter.Services;

import org.springframework.web.multipart.MultipartFile;
import java.io.IOException;
import java.util.Map;

public interface DonorService {
    void processarJson(MultipartFile file) throws IOException;
    Map<String, Long> contarDoadoresPorEstado();
    Map<String, Double> calcularImcMedioPorFaixaEtaria();
    Map<String, Double> calcularPercentualObesosPorSexo();
    Map<String, Double> calcularMediaIdadePorTipoSanguineo();
    Map<String, Long> contarDoadoresCompativeis();
}
