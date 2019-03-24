all: env docker-compose

env:
	cp .env.dist .env

docker-compose:
	cp docker-compose.yml.dist docker-compose.yml

clean:
	rm .env
	rm docker-compose.yml
