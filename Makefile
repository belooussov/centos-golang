NAME=centos-golang
REL=1.7.3
USER=mickep76

all: push

clean:
	docker rmi ${NAME} &>/dev/null || true

build: clean
	docker build --pull=true --no-cache -t ${USER}/${NAME}:${REL} --build-arg REL=${REL} .
	docker tag ${USER}/${NAME}:${REL} ${USER}/${NAME}:latest

push: build
	docker login -u ${USER}
	docker push ${USER}/${NAME}:${REL}
	docker push ${USER}/${NAME}:latest
