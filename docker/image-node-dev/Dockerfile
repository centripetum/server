ARG NODE_VERSION="latest"

FROM node:${NODE_VERSION}

LABEL maintainer="Andy Deng <andy.z.deng@gmail.com>"

RUN apt-get update && \
    apt-get install -y vim net-tools lsof telnet netcat && \
    apt-get autoclean && \
    yarn global add nodemon eslint create-react-app && \
    echo "alias ls='ls --color=auto'" >> /root/.bashrc && \
    echo "alias l='ls -la'" >> /root/.bashrc && \
    echo "alias ll='ls -l'" >> /root/.bashrc && \
    echo "alias grep='grep --color=auto'" >> /root/.bashrc && \
    echo "export PS1='|n|[|e[35m|]--------|n|t |[|e[33m|]|h |[|e[32m|][|w]|n|[|e[35m|]-------- |[|e[33m|]|u|[|e[32m|]|$ |[|e[m|]'" | sed 's/|/\\/g' >> /root/.bashrc

COPY *.sh /home/node/

ENV NODE_ENV="docker-dev" \
    PROJECT_PATH=project_not_exist \
    START_SCRIPT=start \
    WAIT_SEC=0 \
    WAIT_HOST= \
    WAIT_PORT=

VOLUME [ "/home/node/workspace" ]

WORKDIR /home/node/workspace

CMD sh /home/node/wait_to_start_project.sh ${PROJECT_PATH} ${START_SCRIPT} ${WAIT_SEC} ${WAIT_HOST} ${WAIT_PORT}