FROM golang:alpine AS builder

RUN apk update && apk add --no-cache git

WORKDIR /usr/src/app
COPY . .

RUN go get -d -v

# RUN go build -v -o /usr/local/bin/app ./...
# RUN go build -o /go/bin/hello
RUN GOOS=linux GOARCH=amd64 go build -ldflags="-w -s" -o /go/bin/hello


#######################################################
FROM scratch

COPY --from=builder /go/bin/hello go/bin/hello

ENTRYPOINT [ "/go/bin/hello"]

# CMD ["app"]
