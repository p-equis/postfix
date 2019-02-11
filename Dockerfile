FROM ruby:latest

RUN apt-get update && apt-get install -y \ 
  build-essential  

COPY . ./
RUN gem install bundler && bundle install --jobs 20 --retry 5

RUN git config --global user.email "you@example.com" \
  && git config --global user.name "Your Name"

ENTRYPOINT ["bundle", "exec", "rake"]

