# Dockerfile
FROM elixir:1.15

# Install build dependencies
RUN apt-get update && apt-get install -y \
  curl \
  git \
  vim \
  tree \
  inotify-tools \
  nodejs \
  npm \
  && rm -rf /var/lib/apt/lists/*

# Install hex and rebar
RUN mix local.hex --force && \
    mix local.rebar --force 


# Create a developer user
ARG USERNAME=developer
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN groupadd --gid $USER_GID $USERNAME \
    && useradd -s /bin/bash --uid $USER_UID --gid $USER_GID -m $USERNAME

# Ensure permissions for the mix and hex directories
RUN mkdir -p /root/.mix && mkdir -p /root/.hex && \
    chown -R $USER_UID:$USER_GID /root/.mix /root/.hex

# Switch to non-root user
USER developer

# Set environment variables for non-root user
ENV MIX_HOME=/home/$USERNAME/.mix
ENV HEX_HOME=/home/$USERNAME/.hex
ENV PATH="$MIX_HOME/bin:$PATH"

# Install the Phoenix archive
RUN mix archive.install hex phx_new --force

# Set working directory
WORKDIR /workspace

