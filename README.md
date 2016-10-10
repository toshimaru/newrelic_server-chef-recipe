# newrelic_server-chef-recipe

Installs NewRelic Server(newrelic-sysmond).

## Configuration

See `attributes/default.rb`:

```
default["newrelic"]["license_key"]               = ""
default["newrelic"]["server"]["rpm_package_url"] = "https://download.newrelic.com/pub/newrelic/el5/i386/newrelic-repo-5-3.noarch.rpm"
```

1. [**Required**]Set NewRelic license_key.
2. [Optional]Set NewRelic server rpm_package_url
