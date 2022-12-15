FROM robolaunchio/frontend:latest
WORKDIR /root/robolaunch-frontend/
RUN git pull
RUN yarn
CMD ["yarn","start","&"]