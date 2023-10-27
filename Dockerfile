FROM golang:1.20 as builder
WORKDIR /app
ADD . .
RUN go mod download
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -ldflags="-s -w" -o /app/my-app-foo


FROM alpine:3.18.4 AS final-stage
RUN apk add --update --no-cache ca-certificates
RUN addgroup -S appuser && adduser -u 1000 -S appuser -G appuser
USER 1000
WORKDIR ${HOME}/app
COPY --from=builder /app/my-app-foo .
EXPOSE 8080
ENTRYPOINT ["./my-app-foo"]
CMD ["start"]
