[gem]: https://rubygems.org/gems/dry-web-roda
[travis]: https://travis-ci.org/dry-rb/dry-web-roda
[codeclimate]: https://codeclimate.com/github/dry-rb/dry-web-roda
[inchpages]: http://inch-ci.org/github/dry-rb/dry-web-roda/

# dry-web-roda [![Join the chat at https://gitter.im/dry-rb/chat](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/dry-rb/chat?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

[![Gem Version](https://badge.fury.io/rb/dry-web-roda.svg)][gem]
[![Build Status](https://travis-ci.org/dry-rb/dry-web-roda.svg?branch=master)][travis]
[![Code Climate](https://codeclimate.com/github/dry-rb/dry-web-roda/badges/gpa.svg)][codeclimate]
[![Test Coverage](https://codeclimate.com/github/dry-rb/dry-web-roda/badges/coverage.svg)][codeclimate]
[![Inline docs](http://inch-ci.org/github/dry-rb/dry-web-roda.svg?branch=master&style=flat)][inchpages]

Integration between [dry-web](https://github.com/dry-rb/dry-web) and [roda](https://github.com/jeremyevans/roda).

dry-web-roda offers a CLI for generating new projects.

### Umbrella projects

To generate a new _umbrella project_ (functionality divided into sub-apps):

```sh
$ dry-web-roda new <your_project_name>
```

And to generate sub-apps within your project:

```sh
$ dry-web-roda generate sub_app <your_sub_app_name> --umbrella=<your_project_name>
```

### Flat projects

To generate a new _flat project_ (a simpler architecture, with a single module for your entire app):

```sh
$ dry-web-roda new <your_project_name> --arch=flat
```

## LICENSE

See `LICENSE` file.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/dry-rb/dry-web-roda.

## Acknowledgements

The support code for testing the CLI and generated app are derived from
[hanami/hanami](https://github.com/hanami/hanami). Thank you to Luca and the
Hanami team!
