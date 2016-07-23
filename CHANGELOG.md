# 0.3.3 / 2016-07-23

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
