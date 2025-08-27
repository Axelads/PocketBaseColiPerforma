FROM alpine:latest

WORKDIR /app

# Copier le binaire PocketBase
COPY pocketbase/pocketbase /app/pocketbase

# Rendre exécutable
RUN chmod +x /app/pocketbase

# Exposer le port PocketBase
EXPOSE 8080

# Lancer PocketBase
CMD ["/app/pocketbase", "serve", "--http=0.0.0.0:8080"]
