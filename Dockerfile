FROM alpine:latest
WORKDIR /app

COPY pocketbase/pocketbase /app/pocketbase
RUN chmod +x /app/pocketbase

EXPOSE 8080

# Recovery: on efface la DB, on (re)crée le superuser, puis on lance le serveur
CMD ["/bin/sh","-lc","rm -rf /app/pb_data && /app/pocketbase superuser upsert \"professionnel.agregoire@gmail.com\" \"Axel-Strong-2025\" && exec /app/pocketbase serve --http=0.0.0.0:8080"]
