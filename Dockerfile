# node:16.5-buster-slim
FROM node@sha256:ddb4d0ea63591c5a4ef6a9778e3913c3bfcc70328240bb4f97d31d4843587f9b as builder

COPY . /src/app/
WORKDIR /src/app/
RUN npm install
RUN npm run build

# nginx:1.21.1
FROM nginx@sha256:3f13b4376446cf92b0cb9a5c46ba75d57c41f627c4edb8b635fa47386ea29e20

COPY --from=builder /src/app/index.html /usr/share/nginx/html/index.html
COPY --from=builder /src/app/scripts.js /usr/share/nginx/html/scripts.js
COPY --from=builder /src/app/node_modules/openpgp/dist/openpgp.min.js /usr/share/nginx/html/node_modules/openpgp/dist/openpgp.min.js
COPY --from=builder /src/app/proofs.json /usr/share/nginx/html/openpgp/proofs.json
