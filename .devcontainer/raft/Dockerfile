FROM mcr.microsoft.com/devcontainers/python:1-3.10

RUN curl -sfL https://direnv.net/install.sh | bash && \
    echo 'eval "$(direnv hook bash)"' >> /etc/bash.bashrc

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
