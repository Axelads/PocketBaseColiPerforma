FROM alpine:latest
WORKDIR /app

COPY pocketbase/pocketbase /app/pocketbase
RUN chmod +x /app/pocketbase

EXPOSE 8080

CMD ["/app/pocketbase", "serve", "--http=0.0.0.0:8080"]
