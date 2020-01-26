# screenie-server

HTTP screenshot service based on [Puppeteer](https://github.com/GoogleChrome/puppeteer).

Creates a HTTP server using [Koa](https://github.com/koajs/koa), by default on
port 3000. It renders pages and creates screenshots of them on request.

## Installation / Usage

You can install from npm and run the server manually:

```bash
npm install screenie-server
./node_modules/.bin/screenie-server
```

Alternatively, we provide a Docker image (build from the
[Dockerfile](Dockerfile)) at [eliksir/screenie-server](https://hub.docker.com/r/eliksir/screenie-server/).
This container is not running in sandbox mode because the docker image doesn't
support user namespaces.

## Configuration

Then request a screenshot of an URL using the `url` query parameter:
`http://localhost:3000/?url=http://google.com/&format=jpeg`

The size of the screenshot can be customized through the `width` and `height`
query parameters, but will always be constrained within 2048x2048. The default
size used when the parameters are missing can be customized by environment
variables:

* `SCREENIE_WIDTH`: Default width, as integer, in pixels (default `1024`).
* `SCREENIE_HEIGHT`: Default height, as integer, in pixels (default `768`).

The `format` query parameter can be used to request a specific format of the
screenshot. The supported formats are PNG, JPEG and even PDF. You can
also set the default format through an environment variable:

* `SCREENIE_DEFAULT_FORMAT`: Default format (default `jpeg`).

The Puppeteer pool can also be customized with environment variables:

* `SCREENIE_POOL_MIN`: Minimum number of Puppeteer instances (default `2`).
* `SCREENIE_POOL_MAX`: Maximum number of Puppeteer instances (default `10`).

To control the level of logging that will be performed, customize the
`SCREENIE_LOG_LEVEL` environment variable. Supported values are `error`,
`warn`, `info`, `verbose`, `debug`, and `silly`, though only `info` and
`verbose` are currently in use.

* `SCREENIE_LOG_LEVEL`: Logging level (default `info`).

To open up file scheme in URL parameter:

* `SCREENIE_ALLOW_FILE_SCHEME`: true (default `false`).

Delay from the `load` event until the screenshot is taken. This can solve
issues with rendering (i.e. rendering webfonts) not being complete before the
screenshot.

* `SCREENIE_SCREENSHOT_DELAY`: Time in milliseconds (default `50`).

And lastly, of course the HTTP port can be customized:

* `SCREENIE_PORT`: HTTP port (default `3000`).

## Inspiration

- [https://github.com/Zenika/alpine-chrome](https://github.com/Zenika/alpine-chrome)

## Contributing

We are open to contributions or suggestions. File issues or suggestions on the
[GitHub issues page](https://github.com/eliksir/screenie-server/issues), and
please do submit a pull request if you have the time to implement an
improvement or bugfix.

## License

Published under the MIT license.
