FROM ruby:latest

RUN apt-get update -qq && apt-get install -yqq build-essential apt-transport-https apt-utils dialog

# for nokogiri
RUN apt-get install -yqq libxml2-dev libxslt1-dev

# node
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN apt-get install -y nodejs

# yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update -qq && apt-get install -y yarn

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN mkdir -p /app

COPY Gemfile* /app/
COPY package.json /app/
COPY yarn.lock /app/

WORKDIR /app

RUN bundle install

COPY . /app

# Add a script to be executed every time the container starts.
COPY entrypoint/run.sh /usr/bin/entrypoint.sh
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["/usr/bin/entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]