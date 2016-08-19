## ACE Recruitment Trello Bot

Looks through the cards from `Completed Coding Challenge` board,
finds those that are stagnant for at least a day, and broadcast it to subscribers.

#### Getting started

Add a `docker_env` file at project root level (same level as Dockerfile). It looks like:
```
BGP_REC_TRELLO_KEY=[key_without_[]]
BGP_REC_TRELLO_TOKEN=[key_without_[]]
BGP_REC_TELEGRAM_TOKEN=[key_without_[]]
BGP_REC_RECIPIENTS=[key_without_[]]

```

Make sure you have `docker` and `docker-compose` installed.

Run `docker-compose up --build -d` at project root level.

#### Config

You can get `BGP_REC_TRELLO_KEY`, and `BGP_REC_TRELLO_TOKEN` from https://trello.com/app-key.

You can use any broadcasters, just add the broadcaster to the telegram group and set your bot's token in `BGP_REC_TELEGRAM_TOKEN`.

When you want to subscribe your telegram group to this bot,
you need to get your group's chat id and add it to `BGP_REC_RECIPIENTS`.
`BGP_REC_RECIPIENTS` is a string which will be split by '|'. Adding multiple recipients looks like this:
```
BGP_REC_RECIPIENTS=7235478283|7235478281|7235478280
```

#### Extending

There are 4 main files.
- `rtr.rb`: Get cards/boards through Trello API with message parsing options.
- `telegram_bot.rb`: Broadcast message.
- `job.rb`: Wrapper that contains important job APIs.
- `app.rb`: Scheduler to run jobs.
