FROM node:12-alpine3.11

ENV SCREENIE_VERSION=3.0.0-beta.2
ENV SCREENIE_CHROMIUM_ARGS=--no-sandbox
ENV SCREENIE_CHROMIUM_EXEC=/usr/lib/chromium/chrome
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# Installs latest Chromium (77) package
RUN apk update && apk upgrade && \
  apk add --no-cache \
  chromium\
  nss\
  freetype\
  harfbuzz\
  ttf-freefont\
  git&& \
  wget -O /usr/local/bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v1.2.2/dumb-init_1.2.2_amd64 && \
  chmod +x /usr/local/bin/dumb-init

ENTRYPOINT ["dumb-init"]

RUN npm install -g screenie-server@${SCREENIE_VERSION} --unsafe-perm

EXPOSE 3000

CMD /usr/local/bin/screenie
