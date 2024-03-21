FROM ubuntu:22.04

# TODO: Clean up unused build files.
# TODO: Check does the bash file actually get used?

# Ubuntu | Update to latest version
RUN <<EOF
apt-get update -y
apt-get upgrade -y
echo 'Operating system:' && cat /etc/lsb-release
EOF

# BashRC | Create Bash read command for environment variables
RUN <<EOF
touch ~/.bashrc
EOF

# Command Line Utils
# CLI | Install GIT
RUN <<EOF
apt-get install git -y
echo 'git version:' && git --version
EOF

# CLI | Install Curl
RUN <<EOF
apt-get install curl -y
echo 'curl version:' && curl --version
EOF

# CLI | Install Vim
RUN <<EOF
apt-get install vim -y
EOF

# Node | Install Node JS & NPM
RUN <<EOF
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
. ~/.bashrc # source bashrc
nvm install --lts
nvm alias default lts/*
nvm use default
echo 'node version:' && node --version
echo 'npm version:' && npm --version
EOF

# C | Install Clang
RUN <<EOF
apt-get install clang -y
echo 'clang version:' && clang --version
EOF

# C | Install Cmake
RUN <<EOF
apt-get install cmake -y
echo 'cmake version:' && cmake --version
EOF

# Rust | Install Rust
RUN <<EOF
curl https://sh.rustup.rs -sSf | sh -s -- -y
. $HOME/.cargo/env >> ~/.bashrc # source cargo PATH
. ~/.bashrc
rustup component add rust-analyzer
echo 'rustc version:' && rustc --version
echo 'cargo version:' && cargo --version
echo 'clippy version:' && cargo clippy --version
echo 'rustfmt version:' && cargo fmt --version
echo 'rust-analyzer version:' && rust-analyzer --version
EOF

# Rust | C | Install Mold Linker
RUN <<EOF
    git clone https://github.com/rui314/mold.git
    mkdir mold/build
    cd mold/build
    git checkout v2.4.0
    ../install-build-deps.sh
    cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_COMPILER=c++ ..
    cmake --build . -j $(nproc)
    cmake --build . --target install
EOF

# Set Mold as linker instead of ld by setting symbolic link & remove build folder
RUN update-alternatives --install /usr/bin/ld ld /usr/local/bin/mold 100 && rm mold -rf

# Rust | Cargo | Install Cargo Watch
RUN <<EOF
. ~/.bashrc
cargo install cargo-watch
echo 'cargo-watch version:' && cargo-watch --version
EOF

# Rust | Cargo | Install Ripgrep CLI
RUN <<EOF
. ~/.bashrc
cargo install ripgrep
echo 'ripgrep version:' && rg --version
EOF

# Rust | Cargo | Install Exa
RUN <<EOF
. ~/.bashrc
cargo install exa
echo 'Exa version:' && exa --version
EOF


# Python | Install Python 3
RUN <<EOF
apt-get install python3 -y
apt-get install python3-pip -y
echo 'python version:' && python3 --version
EOF

# Python | Pip | Install Pipenv
RUN <<EOF
python3 -m pip install pipenv
echo 'pipenv version:' && pipenv --version
EOF

# Start at bash
CMD ["/bin/bash"]
