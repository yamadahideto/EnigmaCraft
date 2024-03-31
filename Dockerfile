FROM ruby:3.2.2

ENV TZ Asia/Tokyo

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs && apt-get install -y vim

RUN apt-get update -qq && apt-get install -y postgresql-client

RUN curl -sL https://deb.nodesource.com/setup_20.x | bash - \
  && wget --quiet -O - /tmp/pubkey.gpg https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
  && apt-get update -qq \
  && apt-get install -y nodejs yarn

RUN apt-get update
RUN apt-get install vim

WORKDIR /EnigmaCraft

COPY Gemfile Gemfile.lock /EnigmaCraft/

RUN bundle install

COPY package.json yarn.lock /EnigmaCraft/

RUN yarn install

RUN yarn add daisyui

RUN apt-get update && apt-get install -y imagemagick

COPY . /EnigmaCraft/

COPY entrypoint.sh /usr/bin/

RUN chmod +x /usr/bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]

CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]