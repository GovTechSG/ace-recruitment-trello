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
BOARD_ID=board_id
LIST_EXCEPTIONS=[list_id_without_[]]
CARD_EXCEPTIONS=[card_id_without_[]]
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

You can add the list_id of any list that you do not wish to monitor in the `LIST_EXCEPTIONS` split by '|'.
Adding multiple recipients looks like this:
```
LIST_EXCEPTIONS=58753825c4e037866aebd303|58753825c4e037866aebd302
```
You can just leave it empty if there is no list_id to add, example `LIST_EXCEPTIONS=''`

To get the list_id simply submit a GET request using postman with the following query:
```
https://api.trello.com/1/boards/{board_id_without_{}}/lists?key={your_key_without_{}}&token={your_token_without_{}}
```

You can add the card_id of any card that you do not wish to monitor in the `CARD_EXCEPTIONS` split by '|'.
Adding multiple recipients looks like this:
```
card_EXCEPTIONS=58753825c4e037866aebd303|58753825c4e037866aebd302
```
You can just leave it empty if there is no card_id to add, example `CARD_EXCEPTIONS=''`
You can get the card_id for those card `CARD_EXCEPTIONS` by submitting a GET request using postman with the following query
```
https://api.trello.com/1/boards/{board_id_without_{}}/cards?key={your_key_without_{}}&token={your_token_without_{}}
```

#### Extending

There are 4 main files.
- `rtr.rb`: Get cards/boards through Trello API with message parsing options.
- `telegram_bot.rb`: Broadcast message.
- `job.rb`: Wrapper that contains important job APIs.
- `app.rb`: Scheduler to run jobs.
