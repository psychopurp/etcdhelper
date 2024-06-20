FROM golang:1.22.1 AS build

WORKDIR /app

COPY go.mod go.sum ./

RUN go mod download

COPY . .

RUN go build -o main .

FROM gcr.io/distroless/base-debian10


COPY --from=build /app/main /app/etcdhelper

ENTRYPOINT ["/app/etcdhelper"]
