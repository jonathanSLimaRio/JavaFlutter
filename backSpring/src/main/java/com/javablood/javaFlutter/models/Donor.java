package com.javablood.javaFlutter.models;

import com.fasterxml.jackson.annotation.JsonFormat;
import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import lombok.Data;

import java.time.LocalDate;
import java.time.Period;
@Data 
@Entity
@Table(name = "doadores", indexes = {
    @Index(name = "idx_estado", columnList = "estado"),
    @Index(name = "idx_tipo_sanguineo", columnList = "tipo_sanguineo")
})
public class Donor {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotBlank(message = "Nome é obrigatório")
    private String nome;

    @NotBlank(message = "CPF é obrigatório")
    @Column(unique = true)
    @Pattern(regexp = "\\d{3}\\.\\d{3}\\.\\d{3}-\\d{2}", message = "CPF inválido")
    private String cpf;

    @Column(name = "data_nasc")
    @JsonFormat(pattern = "dd/MM/yyyy")
    @NotNull(message = "Data de nascimento é obrigatória")
    private LocalDate dataNasc;  // Troquei Date por LocalDate (mais moderno)

    @NotBlank(message = "Sexo é obrigatório")
    @Enumerated(EnumType.STRING)
    private Sexo sexo;  // Enum para padronização

    @Email(message = "Email inválido")
    private String email;

    @NotBlank(message = "CEP é obrigatório")
    private String cep;

    private String endereco;
    private Integer numero;
    private String bairro;
    private String cidade;
    private String estado;

    @NotBlank(message = "Tipo sanguíneo é obrigatório")
    @Column(name = "tipo_sanguineo")
    @Pattern(regexp = "^(A|B|AB|O)[+-]$", message = "Tipo sanguíneo inválido")
    private String tipoSanguineo;

    @Min(value = 1, message = "Altura mínima é 1 metro")
    @Max(value = 3, message = "Altura máxima é 3 metros")
    private Double altura;

    @Min(value = 10, message = "Peso mínimo é 10 kg")
    @Max(value = 300, message = "Peso máximo é 300 kg")
    private Double peso;

    private Integer idade;

    // Calcula a idade automaticamente após carregar do banco
    @PostLoad
    private void calcularIdade() {
        if (this.dataNasc != null) {
            this.idade = Period.between(this.dataNasc, LocalDate.now()).getYears();
        }
    }

    // Getters e Setters

    // Enum para sexo
    public enum Sexo {
        MASCULINO, FEMININO
    }
}