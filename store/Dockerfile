FROM elixir:1.15.7

WORKDIR /app

COPY mix.exs mix.lock ./

RUN mix do deps.get, deps.compile

COPY . .

CMD ["mix", "phx.server"]