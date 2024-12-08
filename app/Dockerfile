FROM node:lts-slim

WORKDIR /app

COPY package.json .

RUN npm install

EXPOSE 5000

ENV PORT=5000
ENV MONGO_URI=mongodb://mongoadmin:secret@mongo:27017
ENV JWT_SECRET=abc123


COPY backend backend/

CMD ["npm", "run", "server"]