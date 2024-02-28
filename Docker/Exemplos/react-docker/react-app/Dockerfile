FROM node AS build

WORKDIR /react-app

COPY /react-app/package.json .
COPY /react-app/package-lock.json .

RUN ["npm", "ci"]

COPY /react-app .

RUN ["npm", "run", "build"]

FROM nginx

COPY --from=build /react-app/dist /usr/share/nginx/html

EXPOSE 80