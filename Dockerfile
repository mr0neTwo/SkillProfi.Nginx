FROM nginx:1.25.1

COPY nginx.conf /etc/nginx/nginx.conf

RUN rm -r /etc/nginx/conf.d/*

COPY http.conf /etc/nginx/conf.d/http.conf
COPY https.conf /etc/nginx/conf.d/https.conf