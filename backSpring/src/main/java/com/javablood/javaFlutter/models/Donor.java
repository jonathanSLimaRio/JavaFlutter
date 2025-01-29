package com.javablood.javaFlutter.models;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonValue;
import com.javablood.javaFlutter.models.converters.SexoConverter;

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
    private LocalDate dataNasc;

    @Convert(converter = SexoConverter.class)
    @Enumerated(EnumType.STRING)
    @NotNull(message = "Sexo é obrigatório")
    private Sexo sexo;

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
    @Pattern(regexp = "^(A|B|AB|O)[+-]$", message = "Formato inválido. Ex: A+, O-")
    private String tipoSanguineo;

    @Min(value = 1, message = "Altura mínima é 1 metro")
    @Max(value = 3, message = "Altura máxima é 3 metros")
    private Double altura;

    @Min(value = 10, message = "Peso mínimo é 10 kg")
    @Max(value = 300, message = "Peso máximo é 300 kg")
    private Double peso;

    private Integer idade;

    @PrePersist
    @PreUpdate
    private void calcularIdade() {
        if (this.dataNasc != null) {
            this.idade = Period.between(this.dataNasc, LocalDate.now()).getYears();
        }
    }

    @PostLoad
    private void atualizarIdadePosCarregamento() {
        calcularIdade();
    }

    public enum Sexo {
        FEMININO,
        MASCULINO;

        @JsonCreator
        public static Sexo fromString(String value) {
            return valueOf(value.toUpperCase());
        }

        @JsonValue
        public String toValue() {
            return this.name().toLowerCase();
        }
    }
}
