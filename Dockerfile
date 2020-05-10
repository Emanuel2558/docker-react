FROM node:alpine AS builder 

WORKDIR '/app'
EXPOSE 80

COPY package.json .
RUN npm cache clean --force
RUN rm -rf node_modules package-lock.json coverage
RUN npm install
COPY . .
RUN npm run build


FROM nginx

COPY --from=builder /app/build /usr/share/nginx/html
