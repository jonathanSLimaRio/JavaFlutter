package com.javablood.javaFlutter.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import com.javablood.javaFlutter.Services.DonorService;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.tags.Tag;

import java.io.IOException;

@RestController
@RequestMapping("/api/doadores")
@Tag(name = "Doadores", description = "Gerenciamento de doadores e estatísticas")
public class DonorController {

    @Autowired
    private DonorService donorService;

    @PostMapping("/upload")
    @Operation(
        summary = "Upload JSON de doadores",
        description = "Faz upload de um arquivo JSON com os dados dos doadores.",
        requestBody = @io.swagger.v3.oas.annotations.parameters.RequestBody(
            description = "Arquivo JSON contendo uma lista de doadores.",
            required = true,
            content = @Content(mediaType = "multipart/form-data")
        )
    )
    @ApiResponses({
        @ApiResponse(responseCode = "200", description = "Dados processados com sucesso"),
        @ApiResponse(responseCode = "400", description = "Erro ao processar o arquivo")
    })
    public ResponseEntity<String> uploadJson(
        @Parameter(description = "Arquivo JSON contendo os dados dos doadores", required = true) 
        @RequestParam("file") MultipartFile file
    ) {
        try {
            donorService.processarJson(file);
            return ResponseEntity.ok("Dados processados com sucesso!");
        } catch (IOException e) {
            return ResponseEntity.badRequest().body("Erro ao processar o arquivo: " + e.getMessage());
        }
    }

    @GetMapping("/estatisticas/estados")
    @Operation(
        summary = "Contagem por estado",
        description = "Retorna a contagem de doadores agrupados por estado.",
        responses = {
            @ApiResponse(
                responseCode = "200",
                description = "Contagem de doadores por estado retornada com sucesso.",
                content = @Content(
                    mediaType = "application/json",
                    schema = @Schema(example = "{\"SP\": 100, \"RJ\": 50}")
                )
            )
        }
    )
    public ResponseEntity<?> getContagemPorEstado() {
        return ResponseEntity.ok(donorService.contarDoadoresPorEstado());
    }

    @GetMapping("/estatisticas/imc-por-idade")
    @Operation(
        summary = "IMC médio por faixa etária",
        description = "Calcula o IMC médio dos doadores agrupados por faixa etária.",
        responses = {
            @ApiResponse(
                responseCode = "200",
                description = "IMC médio por faixa etária retornado com sucesso.",
                content = @Content(
                    mediaType = "application/json",
                    schema = @Schema(example = "{\"0-9\": 20.5, \"10-19\": 22.1}")
                )
            )
        }
    )
    public ResponseEntity<?> getImcMedioPorFaixaEtaria() {
        return ResponseEntity.ok(donorService.calcularImcMedioPorFaixaEtaria());
    }

    @GetMapping("/estatisticas/obesidade-por-sexo")
    @Operation(
        summary = "Obesidade por sexo",
        description = "Calcula o percentual de doadores obesos por sexo.",
        responses = {
            @ApiResponse(
                responseCode = "200",
                description = "Percentual de obesidade por sexo retornado com sucesso.",
                content = @Content(
                    mediaType = "application/json",
                    schema = @Schema(example = "{\"MASCULINO\": 15.2, \"FEMININO\": 18.7}")
                )
            )
        }
    )
    public ResponseEntity<?> getPercentualObesosPorSexo() {
        return ResponseEntity.ok(donorService.calcularPercentualObesosPorSexo());
    }

    @GetMapping("/estatisticas/media-idade-tipo-sanguineo")
    @Operation(
        summary = "Média de idade por tipo sanguíneo",
        description = "Retorna a média de idade dos doadores agrupados por tipo sanguíneo.",
        responses = {
            @ApiResponse(
                responseCode = "200",
                description = "Média de idade por tipo sanguíneo retornada com sucesso.",
                content = @Content(
                    mediaType = "application/json",
                    schema = @Schema(example = "{\"A+\": 35.5, \"O-\": 40.3}")
                )
            )
        }
    )
    public ResponseEntity<?> getMediaIdadePorTipoSanguineo() {
        return ResponseEntity.ok(donorService.calcularMediaIdadePorTipoSanguineo());
    }

    @GetMapping("/estatisticas/doadores-compativeis")
    @Operation(
        summary = "Doadores compatíveis",
        description = "Conta os doadores compatíveis com base nos critérios definidos.",
        responses = {
            @ApiResponse(
                responseCode = "200",
                description = "Contagem de doadores compatíveis retornada com sucesso.",
                content = @Content(
                    mediaType = "application/json",
                    schema = @Schema(example = "{\"A+\": 120, \"O+\": 95}")
                )
            )
        }
    )
    public ResponseEntity<?> getDoadoresCompativeis() {
        return ResponseEntity.ok(donorService.contarDoadoresCompativeis());
    }
}
