FROM rust:1.60.0 AS build

ENV ROCKET_ADDRESS=0.0.0.0
ENV ROCKET_PORT=8000

RUN USER=root cargo new --bin hello_rust_web
WORKDIR /app

# copy over your manifests
COPY ./Cargo.lock ./Cargo.lock
COPY ./Cargo.toml ./Cargo.toml

# this build step will cache your dependencies
RUN cargo build --release
RUN rm src/*.rs

# copy your source tree
COPY ./src ./src

# build for release
RUN rm ./target/release/deps/hello_rust_web*
RUN cargo build --release

# our final base
FROM rust:1.60.0

# copy the build artifact from the build stage
COPY --from=build /app/target/release/hello_rust_web .

# set the startup command to run your binary
CMD ["./hello_rust_web"]