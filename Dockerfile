FROM elixir:1.13-alpine

ARG MIX_ENV

ENV MIX_ENV=${MIX_ENV}
ENV SHELL=/bin/bash

# TODO move to base image
RUN apk --update-cache --no-cache add ffmpeg && apk add streamlink --no-cache --repository=http://dl-cdn.alpinelinux.org/alpine/edge/testing/

WORKDIR /app
COPY ./_build/${MIX_ENV}/rel/stream_archiver .

CMD ["./bin/stream_archiver", "start"]
