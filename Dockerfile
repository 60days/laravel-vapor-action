FROM composer:2

LABEL repository="https://github.com/ubient/laravel-vapor-action"
LABEL homepage="https://github.com/ubient/laravel-vapor-action"
LABEL maintainer="Claudio Dekker <claudio@ubient.net>"

# Install required extenstions for laravel
# https://laravel.com/docs/6.x#server-requirements
RUN apk add oniguruma-dev libxml2-dev && \
    docker-php-ext-install bcmath xml tokenizer mbstring

# Install Vapor + Prestissimo (parallel/quicker composer install)
RUN set -xe && \
    composer global require laravel/vapor-cli && \
    composer clear-cache

# Install Node.js (needed for Vapor's NPM Build) and python2 (needed to generate pyc files for converter)
RUN apk add --update --no-cache nodejs npm python2

# Prepare out Entrypoint (used to run Vapor commands)
COPY vapor-entrypoint /usr/local/bin/vapor-entrypoint

ENTRYPOINT ["/usr/local/bin/vapor-entrypoint"]
