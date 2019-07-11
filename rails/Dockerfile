FROM ruby:2.5.3

ENV REDIS_HOST=localhost
ENV REDIS_PORT=6379
ENV REDIS_URL=redis://redis:6379
ENV PGHOST=postgres
ENV PGPORT=5432
ENV PGUSER=postgres
ENV PGPASSWORD=postgres

RUN /bin/bash -c " \
  apt update \
  && curl -sL https://deb.nodesource.com/setup_11.x | bash - \
  && apt install -y nodejs \
  && apt install -y ca-certificates \
  && curl https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - \
  && echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list \
  && apt update \
  && apt install postgresql-11"