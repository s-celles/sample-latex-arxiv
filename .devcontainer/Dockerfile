FROM texlive/texlive:latest-small

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

# Update tlmgr and install required packages
RUN tlmgr update --self --all \
    && tlmgr install \
    # Typography and formatting
    titlesec \
    xcolor \
    microtype \
    # References
    cleveref \
    hyperref \
    # Fonts (Type 1 for arXiv compatibility)
    psfonts \
    cm-super \
    # Math packages
    amsmath \
    amssymb \
    mathtools \
    # Figures and tables
    graphicx \
    booktabs \
    float \
    caption \
    subcaption \
    # Layout
    geometry \
    fancyhdr \
    # Bibliography (traditional bibtex for arXiv)
    natbib \
    # Utilities
    lipsum \
    todonotes \
    xspace \
    enumitem

# System tools
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    make \
    zip \
    && rm -rf /var/lib/apt/lists/*

# Verify installation
RUN pdflatex --version && bibtex --version

# Switch to non-root user
USER $USERNAME
WORKDIR /home/$USERNAME
