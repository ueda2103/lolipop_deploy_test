FROM ruby:2.5.8

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && apt-get update -qq \
    && apt-get install -y nodejs yarn \
    && mkdir /lolipop_deploy_test1

WORKDIR /lolipop_deploy_test1
COPY Gemfile /lolipop_deploy_test1/Gemfile
COPY Gemfile.lock /lolipop_deploy_test1/Gemfile.lock
RUN bundle install
COPY . /lolipop_deploy_test1

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]