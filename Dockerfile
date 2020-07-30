FROM debian:10 

#------------------------------------------------------------------
# System requirements
#------------------------------------------------------------------

RUN apt update && \
    apt install -y \
    python3 \
    python3-pip \
    git \
    tor \
    nmap \
    curl \
    jq \
    procps \
    libffi-dev
    
#------------------------------------------------------------------
# Python requirements
#------------------------------------------------------------------

COPY python-requirements.txt ShellBot.sh bot.sh dorks.list ./
RUN pip3 install -r python-requirements.txt
RUN pip3 install -U setuptools && easy_install shodan

#------------------------------------------------------------------
# Install pwned or not
#------------------------------------------------------------------

RUN git clone https://github.com/thewhiteh4t/pwnedOrNot.git && \
    cd pwnedOrNot && \
    ln -s $PWD/pwnedornot.py /usr/bin/pwnedornot

#------------------------------------------------------------------
# Install Karma
#------------------------------------------------------------------

RUN git clone https://github.com/decoxviii/karma && \
    cd karma && \
    python3 setup.py build && \
    python3 setup.py install

#------------------------------------------------------------------
# Install Sherlock 
#------------------------------------------------------------------

RUN git clone https://github.com/sherlock-project/sherlock.git && \
    cd sherlock && \
    ln -s $PWD/sherlock.py /usr/bin/sherlock

#------------------------------------------------------------------
# Install TheHarvester 
#------------------------------------------------------------------

RUN git clone https://github.com/laramies/theHarvester && \
    cd theHarvester && \
    ln -s $PWD/theHarvester.py /usr/bin/theHarvester.py

ENTRYPOINT ["./bot.sh"]
