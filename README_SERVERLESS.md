## Serverless Framework

Trying it out. This is a wrapper around the AWS SAM configuration. So far it looks like it should be easier to define the config. The services that need to be setup are:

* Api Gateway
  * Cors specifically
* Lambda
  * Env vars would be nice too
* DynamoDB Table
  * Seed data could be nice too
* IAM roles needed for these

```sh
> npm install serverless -g

# Deploy uses local env vars
> export CLIENT_TOKEN=<client_token>
> export REFRESH_TOKEN=<spotify_refresh_token>

> serverless deploy --aws-profile personal
> sls remove --aws-profile personal
```

Variables can resolve at runtime, those are interpolated with
```yaml
# Different ways to resolve variables
environment:
    VARIABLE_WITHIN_YAML: ${self:service}
    VARIABLE_THROUGH_ENV: ${env:FUNC_PREFIX}
    VARIABLE_THROUGH_OPTION_WITH_DEFAULT: ${opt:stage, 'dev'}
```


## Credentials

Like the SAM-CLI, you need to have some AWS creds to create your serverless stack.
Looks like the easiest way to do that is via the `profile: personal` key in the yaml file.
That will use a profile `[personal]` in your aws creds file.

That's how I setup my aws creds personally, but you can also pass an option if you want to use a different one at runtime.
`serverless deploy --aws-profile otherProfileHere`


## Temp
BQDh6U6mZbtlOMz0aLtLmBuv8tOdDQgQTrcJcWSogTU8-f7QkreqRujDnHmY9M7gH0vldMonVLUn0dYlb1KI2qpwQBnvhtrwRHh_uZ7r4t-fBrqpdSOsg52PQCq8HhRkbMob4jq-VeHLKbKotws9

spotify refresh token