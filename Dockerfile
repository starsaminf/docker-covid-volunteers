FROM circleci/ruby:2.6.3-stretch-node

USER root

RUN curl -sS http://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
RUN  echo "deb http://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update -qq \
    && apt-get install -y --no-install-recommends \
    build-essential \
    libpq-dev \
    nodejs \
    wget  \
    postgresql-client \
    yarn \
    && rm -rf /var/lib/apt/lists/*t

RUN mkdir /mnt/rails/
WORKDIR /mnt/rails/

COPY . /mnt/rails
COPY Gemfile Gemfile.lock /mnt/rails/
COPY package.json /mnt/rails/
COPY yarn.lock /mnt/rails/

# Bundle install
RUN gem install bundler:2.1.4
RUN bundle install
RUN yarn install --check-files
WORKDIR /mnt/rails/

EXPOSE 5000
