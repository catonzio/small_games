# Stage 1
FROM debian:latest AS build-env

RUN apt-get update 
RUN apt-get install -y curl git wget unzip libgconf-2-4 gdb libstdc++6 libglu1-mesa fonts-droid-fallback lib32stdc++6 python3
RUN apt-get clean

RUN git clone https://github.com/flutter/flutter.git /usr/local/flutter

ENV PATH="/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:${PATH}"

RUN flutter doctor -v

RUN flutter channel stable
# RUN flutter upgrade
RUN flutter config --enable-web

RUN mkdir /app/
COPY ./app /app/
WORKDIR /app/
RUN rm -rf ./build pubspeck.lock .dart_tool/ .metadata
RUN flutter clean
RUN flutter pub get
RUN flutter build web --base-href "/small-games/"
# --no-tree-shake-icons

# Stage 2
FROM nginx:1.21.1-alpine
COPY --from=build-env /app/build/web /usr/share/nginx/html/small-games
# COPY --from=build-env /app/build/web /usr/share/nginx/html/small-games
# COPY nginx.conf /etc/nginx/conf.d/default.conf
# RUN sed -i 's/<base href="\/">/<base href="\/small-games\/">/g' /usr/share/nginx/html/small-games/index.html
# CMD ["flutter", "run", "-d", "web-server", "--web-port", "8080", "--web-hostname", "0.0.0.0"]
