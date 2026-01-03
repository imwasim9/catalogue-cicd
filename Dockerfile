# FROM node:20.19.5-alpine3.21 AS build
# WORKDIR /opt/server
# COPY package.json .
# COPY *.js .
# # This may add extra cache memory
# RUN npm install

# FROM node:20.19.5-alpine3.21
# WORKDIR /opt/server
# RUN addgroup -S roboshop && adduser -S roboshop -G roboshop && \
#     chown -R roboshop:roboshop /opt/server
# EXPOSE 8080
# ENV MONGO="true" \
#     MONGO_URL="mongodb://mongodb:27017/catalogue"
# COPY --from=build --chown=roboshop:roboshop /opt/server /opt/server
# USER roboshop
# CMD ["node","server.js"]

FROM node:20.19.5-alpine3.21 AS build
WORKDIR /opt/server
COPY package.json .
COPY *.js .
RUN npm install

FROM node:20.19.5-alpine3.21
# create a group and user
WORKDIR /opt/server
RUN addgroup -S roboshop && adduser -S roboshop -G roboshop && \
    chown -R roboshop:roboshop /opt/server
EXPOSE 8080
LABEL com.project="roboshop" \
      component="catalogue" \
      created_by="wasim"
ENV MONGO="true" \
    MONGO_URL="mongodb://mongodb:27017/catalogue"
COPY --from=build --chown=roboshop:roboshop /opt/server /opt/server
USER roboshop
CMD ["server.js"]
ENTRYPOINT ["node"]
