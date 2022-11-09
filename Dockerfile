# builder image
FROM golang:1.19-alpine as builder
RUN mkdir /build
ADD go.* /build/
ADD *.go /build/
WORKDIR /build
RUN go mod download
RUN CGO_ENABLED=0 GOOS=linux go build -a -o app .


# generate clean, final image for end users
FROM alpine:3.11.3
COPY --from=builder /build/app .

# executable
CMD [ "./app" ]