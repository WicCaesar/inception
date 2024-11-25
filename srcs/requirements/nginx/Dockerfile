FROM alpine:3.20.2

RUN apk update && apk upgrade && apk add --no-cache nginx

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
#-g stands for global directive, meaning command given here will override default settings. In this case, we are disabling daemon mode.
#Running as a daemon, or service, means that it will start automatically during the system initialisation, and in the background. It is crucial for Docker that containerised applications run directly in the foreground, with every log displayed in the terminal for easier debugging.

