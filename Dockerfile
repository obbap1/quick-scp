FROM alpine:3.7

LABEL "com.github.actions.name"="Quick SCP"
LABEL "com.github.actions.description"="Move your build to your server"
LABEL "com.github.actions.icon"="briefcase"
LABEL "com.github.actions.color"="green"

LABEL version="0.1.0"
LABEL repository="https://github.com/obbap1/quick-gpg-scp"
LABEL homepage="https://paschal.dev/"
LABEL maintainer="Obba Paschal <paschalobba@gmail.com>"

ADD entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh && apk add gnupg

ENTRYPOINT [ "/entrypoint.sh" ]