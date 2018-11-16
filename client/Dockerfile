FROM node:alpine as builder
WORKDIR /app
COPY ./package.json .
RUN npm install
COPY . .
RUN npm run build

from nginx
expose 3000
COPY ./nginx/default.conf /etc/nginx/conf.d/default.conf
CMD ["npm","run","start"]
COPY --from=builder /app/build /usr/share/nginx/html
