FROM texlive/texlive:latest-full

LABEL maintainer="DevContainer LaTeX arXiv"
LABEL description="LaTeX environment for arXiv submissions"

# Create non-root user
ARG USERNAME=vscode
ARG USER_UID=1001
ARG USER_GID=$USER_UID

RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && apt-get update \
    && apt-get install -y sudo \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME \
    && rm -rf /var/lib/apt/lists/*

# Note: latest-full image includes all packages, no need for tlmgr install

# System tools + Java (required for LTeX language server)
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    make \
    zip \
    default-jre-headless \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Note: ltex-ls will be downloaded automatically by the VS Code extension
# which handles multi-architecture support (including ARM64)

# Verify installation
RUN pdflatex --version && bibtex --version

# Switch to non-root user
USER $USERNAME
WORKDIR /home/$USERNAME
