FROM node:12.8.1

RUN apt-get update && apt-get install -yq libgconf-2-4

RUN apt-get update -qqy \
    && apt-get -qqy install \
        openjdk-8-jre-headless \
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/*

ENV YARN_VERSION 1.22.5

RUN curl -fSLO --compressed "https://yarnpkg.com/downloads/$YARN_VERSION/yarn-v$YARN_VERSION.tar.gz" \
    && tar -xzf yarn-v$YARN_VERSION.tar.gz -C /opt/ \
    && ln -snf /opt/yarn-v$YARN_VERSION/bin/yarn /usr/local/bin/yarn \
    && ln -snf /opt/yarn-v$YARN_VERSION/bin/yarnpkg /usr/local/bin/yarnpkg \
    && rm yarn-v$YARN_VERSION.tar.gz

# Get stable version from here https://www.ubuntuupdates.org/pm/google-chrome-stable
ARG CHROME_VERSION="85.0.4183.83"
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list \
    && apt-get update -qqy \
    && apt-get -qqy install google-chrome-stable=${CHROME_VERSION}-1 \
    && rm /etc/apt/sources.list.d/google-chrome.list \
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/*

RUN npm install -g webdriver-manager@12.1.7
RUN webdriver-manager update
