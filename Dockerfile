FROM alpine:latest
WORKDIR /app

COPY pocketbase/pocketbase /app/pocketbase
RUN chmod +x /app/pocketbase

EXPOSE 8080

# ⚠️ Efface le répertoire de données à chaque démarrage (OK si tu n'as pas de data)
CMD ["/bin/sh","-lc","rm -rf /app/pb_data && /app/pocketbase serve --http=0.0.0.0:8080"]
