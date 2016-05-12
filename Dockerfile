FROM centos:centos7

RUN yum install -y rpm-build wget git make go

# Install Go 1.5
RUN set -ex ;\
    wget --no-check-certificate https://storage.googleapis.com/golang/go1.6.2.linux-amd64.tar.gz ;\
    tar -C /usr/local -xzf /go1.6.2.linux-amd64.tar.gz ;\
    rm -f /go1.6.2.linux-amd64.tar.gz

# Configure Go
ENV GOROOT /usr/local/go
ENV GOPATH /go
ENV PATH /usr/local/go/bin:/go/bin:$PATH
ENV GO15VENDOREXPERIMENT 1

RUN mkdir -p ${GOPATH}/src ${GOPATH}/src/bin

RUN go get github.com/Masterminds/glide

WORKDIR /go

CMD ["make"]
