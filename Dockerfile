FROM alpine:latest

# Expose your proxy port
EXPOSE 8080

# Set the working directory
WORKDIR /app

# Install critical dependencies (ca-certificates is mandatory for TLS)
RUN apk add --no-cache ca-certificates wget unzip tzdata

# Download, extract, set permissions, and clean up all in one layer
RUN wget -O v2ray.zip https://github.com/v2fly/v2ray-core/releases/latest/download/v2ray-linux-64.zip && \
    unzip v2ray.zip && \
    rm v2ray.zip config.json && \
    chmod +x v2ray

# Copy your custom configuration file last so you can change it without rebuilding the whole image
COPY config.json /app/config.json

# Run V2Ray explicitly pointing to the config
ENTRYPOINT ["./v2ray", "run", "-c", "config.json"]
