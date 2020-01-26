FROM alpine:edge

# Installs latest Chromium (77) package.
RUN apk add --no-cache \
      chromium \
      nss \
      ca-certificates \
      harfbuzz \
      freetype \
      freetype-dev \
      ttf-freefont \
      nodejs \
      yarn \
      && rm -rf /var/cache/* \
      && mkdir /var/cache/apk


# Tell Puppeteer to skip installing Chrome. We'll be using the installed package.
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD true

# Add user so we don't need --no-sandbox.
RUN addgroup -S pptruser && adduser -S -g pptruser pptruser \
    && mkdir -p /home/pptruser/Downloads /app \
    && chown -R pptruser:pptruser /home/pptruser \
    && chown -R pptruser:pptruser /app

WORKDIR /app
# Run everything after as non-privileged user.
USER pptruser

ENV CHROME_BIN=/usr/bin/chromium-browser \
    CHROME_PATH=/usr/lib/chromium/ \
    SCREENIE_CHROMIUM_EXEC=/usr/lib/chromium/chrome

COPY package.json yarn.lock /app/
RUN yarn install && \
    yarn cache clean && \
    rm -rf /tmp/*

COPY src /app

EXPOSE 3000

CMD ["node","server.js"]