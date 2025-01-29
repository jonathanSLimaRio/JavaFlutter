package com.javablood.javaFlutter.models.converters;

import com.javablood.javaFlutter.models.Donor.Sexo;
import jakarta.persistence.AttributeConverter;
import jakarta.persistence.Converter;

@Converter(autoApply = true)
public class SexoConverter implements AttributeConverter<Sexo, String> {

    @Override
    public String convertToDatabaseColumn(Sexo sexo) {
        return sexo != null ? sexo.name().toUpperCase() : null;
    }

    @Override
    public Sexo convertToEntityAttribute(String dbData) {
        return dbData != null ? Sexo.valueOf(dbData.toUpperCase()) : null;
    }
}
