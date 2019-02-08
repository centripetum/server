
FROM postgres:11

RUN sed -e "s/# en_NZ.UTF-8/en_NZ.UTF-8/g" -e "s/# en_US.UTF-8/en_US.UTF-8/g" /etc/locale.gen > /etc/locale.gen && \
    locale-gen

ADD pg_rrule.tar.gz /
