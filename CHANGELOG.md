# 0.13.1 - 2019-12-24

## Changed

* Removed `inflecto` in favor of `dry-inflector` (@solnic)

[Compare v0.13.0...v0.13.1](https://github.com/dry-rb/dry-web-roda/compare/v0.13.0...v0.13.1)

# 0.13.0 - 2019-12-24

## Fixed

* dry-monitor for rom is correctly configured in the generated boot file (@mlk-yozu)

## Changed

* Updated generated Gemfile to use the latest dry-* and rom-* gems (@solnic)
* Fixed dry-types warning from the generated `types.rb` (@solnic)
* ~~Removed `inflecto` in favor of `dry-inflector` (@solnic)~~ actually it was done in `0.13.1`

- Added missing dependency on `dry-inflector` (@solnic)

## Changed

- Removed `inflecto` from runtime dependencies (@solnic)

[Compare v0.13.0...v0.13.1](https://github.com/dry-rb/dry-web-roda/compare/v0.13.0...v0.13.1)

# 0.13.0 - 2019-12-24

## Fixed

* dry-monitor for rom is correctly configured in the generated boot file (@mlk-yozu)

## Changed

* Updated generated Gemfile to use the latest dry-* and rom-* gems (@solnic)
* Fixed dry-types warning from the generated `types.rb` (@solnic)
* ~~Removed `inflecto` in favor of `dry-inflector` (@solnic)~~

[Compare v0.12.0...v0.13.0](https://github.com/dry-rb/dry-web-roda/compare/v0.12.0...v0.13.0)

# 0.12.0 - 2019-04-16

### Changed

- Update generated app to work with latest releases of dry-rb gems, including dry-view 0.7.0 and dry-monitor 0.3.0 (parndt in [#94][pr94])
- [BREAKING] `view` roda helper now expects the dry-view context object to be registered in the container as `"view_context"` (instead of previous `"view.context"`) (parndt in [#94][pr94])

[pr94]: https://github.com/dry-rb/dry-web-roda/pull/94/files

[Compare v0.11.0...v0.12.0](https://github.com/dry-rb/dry-web-roda/compare/v0.11.0...v0.12.0)

# 0.11.0 - 2018-02-21

### Changed

- Use Roda 3.0 and compatible version of roda-flow (GustavoCaso & alejandrobabio)

[Compare v0.10.0...v0.11.0](https://github.com/dry-rb/dry-web-roda/compare/v0.10.0...v0.11.0)

# 0.10.0 - 2018-02-13

### Changed

- Use dry-system and dry-web latest version (solnic + timriley)
- Force `Kernel#system` to receive hash with string values (alejandrobabio)
- Downgrade `roda-flow` to `0.3.1` to avoid 404 on root page (GustavoCaso)
- Replace shotgun with rerun to start the generated projects (GustavoCaso)

    To start a project now:

    ```sh
    bundle exec rerun -- rackup --port 4000 config.ru
    ```

In generated projects:

- Require dry-system 0.9 (GustavoCaso)
- Add ability to define custom view key resolver in `dry_view` Roda plugin (AMHOL)

[Compare v0.9.1...v0.10.0](https://github.com/dry-rb/dry-web-roda/compare/v0.9.1...v0.10.0)

# 0.9.1 - 2017-11-01

### Changed

- In generated projects, require dry-view 0.4 (timriley)

# 0.9.0 - 2017-10-27

### Changed

- `Dry::Web::Roda::Application` no longer automatically enables `error_handler` and `multi_route` Roda plugins (timriley)
- `DryView` Roda plugin no longer automatically enables `csrf` and `flash` Roda plugins (timriley)
- `DryView` Roda plugin no longer populates its `#view_context_options` with flash and CSRF data (timriley)

In generated projects:

- Nest sub-apps under the root project namespace (e.g. `MyApp::Main`) instead of keeping them at the top-level (`Main`) (timriley)
- Rename `Dry::Web::Roda::Application` subclasses from `Application` to `Web` (timriley)
- Comment out `r.multi_route` routing instruction in `Web` classes by default, to avoid future Roda exceptions (timriley)
- Enable more Roda plugins (`csrf`, `error_handler`, `flash`, `multi_route`) directly in `Web` classes (timriley)
- Add default implementation of `#view_context_options` to `Web` classes for `dry_view` Roda plugin  (timriley)

# 0.8.0 - 2017-10-26

### Changed

In generated projects:

- Work with dry-system 0.8 (timriley)
- Use dry-systems own settings component in `boot/settings.rb` for project configuration (timriley)
- Rename `:rom` bootable component to `:persistence` so it can be automatically resolved and lazily loaded (timriley)
- Use rom-rb 4.0 (timriley)

# 0.7.5 - 2017-07-25

### Added

- `Application.container` shortcut (solnic)

### Changed

- An app will use `rack_monitor` only if its container is configured with listeners (solnic)

# 0.7.4 - 2017-07-25

### Added

- Added db:create and db:drop take tasks, to create and drop the application database (GustavoCaso)

### Changed

- Use Postgres environment variables to provide connection info to `pg_dump` command in db:structure:dump rake task (timriley)
- Remove error handling block from generated sub-app application classes, since an error handling block is already provided in the top-level umbrella application class (timriley)

### Fixed

- Prevent duplicate log entries in generated umbrella architecture projects (timriley)

# 0.7.3 - 2017-07-10

### Fixed

- `#call` matcher blocks work properly when inheriting from `Operation` in generated project (alejandrobabio)

### Changed

- In generated project, require `pry-byebug` instead of `byebug` alone (alejandrobabio)
- In generated project's `web_spec_helper.rb`, use updated `save_path` setting for Capybara (alejandrobabio)

# 0.7.2 - 2017-07-03

### Fixed

- Add missing rom-factory dependency to generated project Gemfile (alejandrobabio)
- Fix reference to main application class in generated spec helpers file (alejandrobabio)

# 0.7.1 - 2017-06-22

### Fixed

- Fix spelling of generated "lib/persistence" directory (timriley)
- Stop generating a welcome view in the umbrella system (timriley)

# 0.7.0 - 2017-06-16

### Added

In generated app:

- Shared `Operation` class for all application operations to inherit from (timriley)
- Enable `auto_restrictions` relation plugin for ROM (timriley)
- Register low-level database connection object as "persistence.db" in core container (timriley)

### Changed

In generated app:

- Use full database URL to include credentials in pg_dump (lukkor)
- Move view controller and context classes into main lib/ dirs (timriley)
- Use dry-system 0.7.0 magic comments to prevent auto-registration of base repository, view controller and view context classes (timriley)
- Update dry-system dependency to support string paths for container root configs (timriley)
- [BREAKING] Use Dry::Web::Settings from dry-web 0.7.0, which loads settings from .env files instead of .yml files (timriley)
- [BREAKING] Provide settings object via a bootable component
- [BREAKING] Remove special transactions setup harness, since dry-transaction 0.10.0 supports class-based transactions

# 0.6.3 - 2017-03-02

### Changed

- Use the newly-released rom/rom-sql instrumentation plugin to generate SQL logs, rather than a local monkey patch (timriley)

# 0.6.2 - 2017-02-20

### Fixed

- Support dashed names when generating projects, e.g. `dry-web-roda new my-app` (radar & timriley)
- Require securerandom for generating session keys in new flat architecture projects (alexandru-calinoiu)

# 0.6.1 - 2017-02-08

### Added

- In generated projects, set up dry-monitor for request logging (timriley)
- In generated projects, use dry-monitor to log SQL queries (timriley)
- Add new flat project generator: `dry-web-roda new <your_app> --arch=flat` (timriley)

### Changed

- Renamed sub-app generator from `dry-web-roda generate app` to `dry-web-roda generate sub_app` (timriley)

### Fixed

- Ensure dry-monitor is set up in `Application` regardless of the order in which the application's configs are applied (timriley)

# 0.6.1 - 2017-02-03

### Added

- In generated projects, integrate with dry-monitor (via dry-web) for centralized application logging and error reporting (solnic)

# 0.5.1 - 2016-12-27

### Fixed

- `.gitignore` in generated umbrella app correctly ignores `log/` directory (alsemyonov)

# 0.5.0 - 2016-10-21

### Changed

- Depend on the version of shotgun with fixes for Rack 2.0 (timriley)
- Update to work with latest dry-web and dry-system
  - Expect `system/` dirs instead of `component/` (gotar)
  - Update bootable dependency files to match latest dry-system API for bootable dependencies with lifecycles (gotar)
- Use latest released versions of rom-repository and rom-sql, instead of relying on their master branches (wafcio)
- Replace dry-result_matcher gem with dry-matcher (gotar)
- Add dry-monads and dry-struct gems to generated Gemfile (gotar)
- Expect symbols for flash keys in generated `Page` class (timriley)

### Fixed

- Update `view` roda plugin to expect default namespace in sub-app containers (timriley)

# 0.4.0 - 2016-08-15

Update to dry-web with dry-system (solnic)

# 0.3.0 - 2016-07-26

### Added

- Set a default namespace on sub-app containers generated by the CLI (timriley)

### Changed

- Use latest dry-web for latest dry-component injector API (timriley)

# 0.2.3 / 2016-07-23

### Changed

- By default, don't display warning output when running specs (timriley)

# 0.2.2 / 2016-07-18

### Fixed

- Fixed a misnamed module in sub-app generator (hl)
- Removed a deprecated option from the `pg_dump` invocation after migrations (timriley)

# 0.2.1 / 2016-06-22

### Fixed

- Fixed a broken require in generated apps (timriley)

# 0.2.0 / 2016-06-22

### Added

- Added a `dry-web-roda` executable CLI command, which can generate new dry-web-roda projects and apps within projects (timriley)

    To generate a new project:

    ```sh
    dry-web-roda new my_new_project
    ```

    And to generate a new app within an existing project:

    ```sh
    dry-web-roda generate app my_sub_app --umbrella=my_new_project
    ```
- Added the beginnings of a skeleton-based code generator, to support the above (timriley)

# 0.1.0 / 2016-06-12

- Extracted from dry-web (timriley)
