FROM ruby:latest

RUN apt-get update -qq && apt-get install -y nodejs yarn
RUN yarn install --check-files
RUN mkdir -p /app

WORKDIR /app

COPY . /app
RUN bundle install

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["/usr/bin/entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]