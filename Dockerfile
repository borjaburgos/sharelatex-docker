from ubuntu:13.10
RUN apt-get update 
RUN apt-get install -y --force-yes npm git mongodb-server redis-server wget
RUN ln -s /usr/bin/nodejs /usr/bin/node

RUN git clone https://github.com/scottkosty/install-tl-ubuntu.git; \
	cd install-tl-ubuntu; \
	TLREPO=http://mirrors.fe.up.pt/pub/CTAN/ ./install-tl-ubuntu

RUN git clone https://github.com/sharelatex/sharelatex.git; \
	cd sharelatex; \
	npm install; \
	npm install -g grunt-cli; \
	grunt install
ADD user_files /sharelatex/user_files
ADD db /data/db
ADD sharelatex.sh /usr/bin/sharelatex.sh

CMD ./sharelatex.sh

EXPOSE 3000
