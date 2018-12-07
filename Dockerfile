FROM golang:1.11.2-alpine3.8

RUN apk update && apk upgrade && \
    apk add --no-cache --virtual .build-deps bash git openssh \
            gcc \ 
            musl-dev \ 
            openssl \ 
            go \
    ;  

ENV GOROOT /usr/local/go
ENV GOPATH /home/go
ENV PATH $GOROOT/bin:$GOPATH/bin:$PATH

RUN mkdir -p /app
WORKDIR /app

ADD . /app
RUN go get github.com/gin-gonic/gin
RUN go get github.com/jinzhu/gorm
RUN go get github.com/jinzhu/gorm/dialects/sqlite
RUN go build ./app.go

EXPOSE 8080

CMD ["./app"]
