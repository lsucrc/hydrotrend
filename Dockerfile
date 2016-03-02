FROM lsucrc/crcbase
         
WORKDIR /root
RUN wget https://github.com/kettner/hydrotrend/archive/master.zip 
RUN unzip master.zip 
WORKDIR hydrotrend-master
RUN mkdir _build 
WORKDIR _build
RUN cmake ./..
RUN make
RUN make install

WORKDIR ../data
RUN cp -r input/ HYDRO_IN
RUN mkdir HYDRO_OUTPUT
RUN hydrotrend -V
RUN diff HYDRO_OUTPUT/HYDROASCII.Q output/HYDROASCII.Q
