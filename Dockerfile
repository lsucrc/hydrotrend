FROM lsucrc/crcbase
USER crcuser
WORKDIR /model

# download the source code
RUN git clone https://github.com/kettner/hydrotrend.git
WORKDIR hydrotrend
RUN mkdir _build 
WORKDIR _build
RUN cmake ./..
RUN make
RUN make install

# running a testing case
WORKDIR ../data
RUN cp -r input/ HYDRO_IN
RUN mkdir HYDRO_OUTPUT
RUN hydrotrend -V
RUN diff HYDRO_OUTPUT/HYDROASCII.Q output/HYDROASCII.Q
