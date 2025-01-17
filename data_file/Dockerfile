FROM gcc:latest AS builder

RUN apt-get update && apt-get install -y make git 

RUN git clone https://github.com/avih/miniweb /app

WORKDIR /app

RUN make 

FROM alpine:latest

RUN apk add --no-cache libc6-compat

COPY --from=builder /app/miniweb  /html/

#COPY index.html /html/
RUN mkdir -p /html/htdocs
RUN echo "<html><body><h1>Bienvenue sur le site de Nom Prénom</h1></body></html>" > /html/htdocs/index.html

RUN chmod +x /html/miniweb

EXPOSE 80

CMD ["/html/miniweb", "-p", "80", "-d", "/html"]
#CMD ["sh", "-c", "./html/miniweb"]
