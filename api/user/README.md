# User Service

This is the User service

Generated with

```
micro new api/user --namespace=eyasliu --type=api
```

## Getting Started

- [Configuration](#configuration)
- [Dependencies](#dependencies)
- [Usage](#usage)

## Configuration

- FQDN: eyasliu.api.user
- Type: api
- Alias: user

## Dependencies

Micro services depend on service discovery. The default is consul.

```
# install consul
brew install consul

# run consul
consul agent -dev
```

## Usage

A Makefile is included for convenience

Build the binary

```
make build
```

Run the service
```
./user-api
```

Build a docker image
```
make docker
```