FROM elixir:1.13-alpine

ARG MIX_ENV

ENV MIX_ENV=${MIX_ENV}
ENV SHELL=/bin/bash

WORKDIR /app
COPY ./_build/${MIX_ENV}/rel/stream_archiver .

CMD ["./bin/stream_archiver", "start"]
