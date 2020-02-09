## Serverless Framework

Trying it out. This is a wrapper around the AWS SAM configuration. So far it looks like it should be easier to define the config. The services that need to be setup are:

* Api Gateway
  * Cors specifically
* Lambda
  * Env vars would be nice too
* DynamoDB Table
  * Seed data could be nice too
* IAM roles needed for these

```bash
npm install serverless -g
```

Variables can resolve at runtime, those are interpolated with
```
# Reference a field within this .yaml
${self:service}

# Reference the --stage X option with default 'dev'
${opt:stage, 'dev'}

# Reference a local environment variable
${env:FUNC_PREFIX}

```


## Credentials

Like the SAM-CLI, you need to have some AWS creds to create your serverless stack.
Looks like the easiest way to do that is via the `profile: personal` key in the yaml file.
That will use a profile `[personal]` in your aws creds file.

That's how I setup my aws creds personally, but you can also pass an option if you want to use a different one at runtime.
`serverless deploy --aws-profile otherProfileHere`
