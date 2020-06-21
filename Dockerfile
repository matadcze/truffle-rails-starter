FROM oracle/graalvm-ce:20.1.0-java11

MAINTAINER Mateusz Czerwiński (czerwinski.mateusz@pm.me)

RUN gu install native-image ruby

RUN yum -y update && yum install -y postgresql-server postgresql postgresql-libs gcc-c++ make
RUN yum install -y libxml2-devel libxslt libxslt-devel

RUN curl -sL https://rpm.nodesource.com/setup_12.x | bash -
RUN yum install -y nodejs

RUN mkdir /myapp

WORKDIR /myapp

ENV BUNDLE_PATH /gems
ENV GEM_PATH /gems
ENV GEM_HOME /gems

COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock

RUN gem install bundler -v '2.1.4' && bundle install

COPY . /myapp

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 8080

CMD ["rails", "server", "-b", "0.0.0.0"]
