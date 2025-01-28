package com.javablood.javaFlutter.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import com.javablood.javaFlutter.Services.DonorService;

import java.io.IOException;

@RestController
@RequestMapping("/api/doadores")
public class DonorController {

    @Autowired
    private DonorService donorService;

    // Endpoint de upload do JSON
    @PostMapping("/upload")
    public ResponseEntity<String> uploadJson(@RequestParam("file") MultipartFile file) {
        try {
            donorService.processarJson(file);
            return ResponseEntity.ok("Dados processados com sucesso!");
        } catch (IOException e) {
            return ResponseEntity.badRequest().body("Erro ao processar o arquivo: " + e.getMessage());
        }
    }

    // Endpoints para estatísticas
    @GetMapping("/estatisticas/estados")
    public ResponseEntity<?> getContagemPorEstado() {
        return ResponseEntity.ok(donorService.contarDoadoresPorEstado());
    }

    @GetMapping("/estatisticas/imc-por-idade")
    public ResponseEntity<?> getImcMedioPorFaixaEtaria() {
        return ResponseEntity.ok(donorService.calcularImcMedioPorFaixaEtaria());
    }

    @GetMapping("/estatisticas/obesidade-por-sexo")
    public ResponseEntity<?> getPercentualObesosPorSexo() {
        return ResponseEntity.ok(donorService.calcularPercentualObesosPorSexo());
    }

    @GetMapping("/estatisticas/media-idade-tipo-sanguineo")
    public ResponseEntity<?> getMediaIdadePorTipoSanguineo() {
        return ResponseEntity.ok(donorService.calcularMediaIdadePorTipoSanguineo());
    }

    @GetMapping("/estatisticas/doadores-compativeis")
    public ResponseEntity<?> getDoadoresCompativeis() {
        return ResponseEntity.ok(donorService.contarDoadoresCompativeis());
    }
}
