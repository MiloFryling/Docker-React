# build phase
FROM node:alpine as builder
WORKDIR '/app'
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# /app/build will contain the built image
# run phase
FROM nginx

# elastic beanstalk will use port 80
EXPOSE 80

# copy from the "builder" phase named above
COPY --from=builder /app/build /usr/share/nginx/html

# nginx starts up automatically because starting is its default command