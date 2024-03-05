FROM alpine:3.14
WORKDIR /app
RUN apk add --no-cache python3
COPY . .
CMD ["python3", "app.py"]

