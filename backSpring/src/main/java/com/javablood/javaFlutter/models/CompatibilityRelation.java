package com.javablood.javaFlutter.models;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Data;

@Data // Lombok para gerar Getters, Setters, equals, hashCode e toString automaticamente
@Entity
@Table(name = "relacao_compatibilidade")
public class CompatibilityRelation {

    @Id
    @Column(name = "tipo_doador")
    private String tipoDoador;

    @Column(name = "tipo_receptor")
    private String tipoReceptor;
}
