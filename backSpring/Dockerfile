FROM mysql:8.0

# Define variáveis de ambiente (opcional, já configuradas no compose)
ENV MYSQL_ROOT_PASSWORD=rootpassword
ENV MYSQL_DATABASE=meubancoDonor
ENV MYSQL_USER=usuariojavaflutter
ENV MYSQL_PASSWORD=senhajavaflutter

# Expõe a porta padrão do MySQL
EXPOSE 3306

# Ponto de montagem para dados persistentes (opcional, já configurado no compose)
VOLUME /var/lib/mysql

# Scripts de inicialização personalizados (opcional)
COPY ./db/init-scripts/ /docker-entrypoint-initdb.d/