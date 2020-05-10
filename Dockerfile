FROM node:alpine AS builder 

WORKDIR '/app'
EXPOSE 80


COPY package.json .
RUN npm install
RUN npm audit fix
COPY . .
RUN npm run build


FROM nginx

COPY --from=builder /app/build /usr/share/nginx/html
