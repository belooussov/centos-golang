FROM centos:centos7

ARG REL=?
ENV REL ${REL}

RUN set -ex ;\
    yum install -y rpm-build wget git make glibc-devel.i686 mock sudo ;\
    yum clean all

# Install Go 32 bit
RUN set -ex ;\
    wget --no-check-certificate https://storage.googleapis.com/golang/go${REL}.linux-386.tar.gz ;\
    tar -C /usr/local -xzf /go1.7.3.linux-386.tar.gz ;\
    mv /usr/local/go /usr/local/go32 ;\
    rm -f /go${REL}.linux-386.tar.gz

# Install Go 64 bit
RUN set -ex ;\
    wget --no-check-certificate https://storage.googleapis.com/golang/go${REL}.linux-amd64.tar.gz ;\
    tar -C /usr/local -xzf /go${REL}.linux-amd64.tar.gz ;\
    rm -f /go${REL}.linux-amd64.tar.gz

RUN set -ex ;\
    useradd build ;\
    echo "build    ALL=NOPASSWD: ALL" >/etc/sudoers.d/build ;\
    groupmems -a build -g mock

# Configure Go
ENV GOROOT /usr/local/go
ENV GOPATH /go
ENV PATH /usr/local/go/bin:/go/bin:$PATH

RUN mkdir -p ${GOPATH}/src ${GOPATH}/src/bin

RUN go get github.com/Masterminds/glide

WORKDIR /go

ENTRYPOINT "make"
