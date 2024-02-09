FROM --platform=$TARGETPLATFORM maven:3.9.6-amazoncorretto-17 as build
MAINTAINER hussainpithawala@gmail.com
COPY --chown=mvn:mvn . /home/mvn/app
WORKDIR /home/mvn/app
RUN mvn package

FROM --platform=$TARGETPLATFORM amazoncorretto:17-alpine
ENV DIRPATH /src/zeebe-simple-monitor
WORKDIR $DIRPATH/
ADD https://github.com/open-telemetry/opentelemetry-java-instrumentation/releases/download/v1.32.0/opentelemetry-javaagent.jar .
COPY --from=build /home/mvn/app/target/*.jar .

# create the app user with no password and home directory
RUN addgroup -S -g 1001 app && adduser -D -H -S -u 1001 app -G app
# chown all the files to the app user
RUN chown -R app:app $DIRPATH/
# change to the app user
# Switch to non-root user
USER app

EXPOSE 8080
CMD ["java", "-jar","zeebe-simple-monitor-2.7.1-SNAPSHOT.jar"]
