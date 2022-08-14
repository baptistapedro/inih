FROM fuzzers/afl:2.52

RUN apt-get update
RUN apt install -y build-essential wget git clang cmake  automake autotools-dev  libtool zlib1g zlib1g-dev libexif-dev 
RUN git clone https://github.com/benhoyt/inih.git
WORKDIR /inih/fuzzing
RUN afl-gcc inihfuzz.c ../ini.c -o /inihfuzz
RUN wget http://sample-file.bazadanni.com/download/applications/ini/sample.ini
RUN wget https://raw.githubusercontent.com/grafana/grafana/main/conf/sample.ini
RUN mv *.ini ./testcases


ENTRYPOINT ["afl-fuzz", "-i", "/inih/fuzzing/testcases", "-o", "/inihOut"]
CMD ["/inihfuzz", "@@"]
