FROM alpine:latest
WORKDIR /app

# Binaire PocketBase Linux déjà présent dans ./pocketbase/pocketbase
COPY pocketbase/pocketbase /app/pocketbase
RUN chmod +x /app/pocketbase

# Entry point
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 8080
CMD ["/entrypoint.sh"]
