package com.javablood.javaFlutter.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import com.javablood.javaFlutter.models.Donor;

import java.util.List;
import java.util.Map;

public interface DonorRepository extends JpaRepository<Donor, Long> {

    // 1. Contagem de doadores por estado
    @Query("SELECT d.estado as estado, COUNT(d) as total FROM Donor d GROUP BY d.estado")
    List<Map<String, Object>> countByEstado();

    // 2. IMC médio por faixa etária (agrupamento de 10 em 10 anos)
    @Query("SELECT FLOOR(d.idade / 10) * 10 as faixaInicio, AVG(d.peso / (d.altura * d.altura)) as imcMedio FROM Donor d GROUP BY FLOOR(d.idade / 10) * 10")
    List<Map<String, Object>> calculateImcMedioPorFaixaEtaria();

    // 3. Percentual de obesos por sexo (IMC > 30)
    @Query("SELECT UPPER(d.sexo) as sexo, " +
            "(SUM(CASE WHEN (d.peso / (d.altura * d.altura)) > 30 THEN 1 ELSE 0 END) * 100.0 / COUNT(d)) as percentual "
            +
            "FROM Donor d GROUP BY UPPER(d.sexo)")
    List<Map<String, Object>> calculatePercentualObesosPorSexo();

    // 4. Média de idade por tipo sanguíneo
    @Query("SELECT d.tipoSanguineo as tipo, AVG(d.idade) as mediaIdade FROM Donor d GROUP BY d.tipoSanguineo")
    List<Map<String, Object>> calculateMediaIdadePorTipoSanguineo();

    // 5. Doadores compatíveis para cada tipo receptor (usando a tabela de
    // compatibilidade)
    @Query("SELECT r.tipoReceptor as receptor, COUNT(d) as total FROM Donor d JOIN CompatibilityRelation r ON d.tipoSanguineo = r.tipoDoador WHERE d.idade BETWEEN 16 AND 69 AND d.peso > 50 GROUP BY r.tipoReceptor")
    List<Object[]> countDoadoresCompativeis();

}
