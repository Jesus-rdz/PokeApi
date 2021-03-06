### STAGE 1: Build ###
FROM node:14-alpine AS build

RUN mkdir -p /app

#### make the 'app' folder the current working directory
WORKDIR /app

#### copy both 'package.json' and 'package-lock.json' (if available)
COPY package.json /app

#### install angular cli
RUN npm install -g @angular/cli

#### install project dependencies
RUN npm install

#### copy things
COPY . /app

#### generate build --prod
RUN npm run build --prod

### STAGE 2: Run ###
FROM nginx:1.17.1-alpine

#### copy artifact build from the 'build environment'
COPY --from=build /app/dist/PokeApi /usr/share/nginx/html
