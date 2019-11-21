FROM alpine:3.8

RUN mkdir -p /home/appuser && \
    addgroup -S app && \
    adduser -u 1000 -S -h /home/appuser -G app appuser

WORKDIR /home/appuser
COPY /code/app.o .

RUN chown -R appuser:app /home/appuser
USER appuser

CMD ["./app.o"]
