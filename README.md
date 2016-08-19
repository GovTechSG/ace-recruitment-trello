## ACE Recruitment Trello Bot

#### Getting started

Add a `docker_env` file at project root level (same level as Dockerfile). It looks like:
```
BGP_REC_TRELLO_KEY=[key_without_[]]
BGP_REC_TRELLO_TOKEN=[key_without_[]]
BGP_REC_TELEGRAM_TOKEN=220938507:[key_without_[]]
BGP_REC_RECIPIENTS=[key_without_[]]

```


Make sure you have `docker` and `docker-compose` installed.

Run `docker-compose up --build -d` at project root level.
