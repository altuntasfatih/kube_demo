FROM hexpm/elixir:1.18.3-erlang-27.2.4-debian-bullseye-20250224-slim AS build

# Set environment variables for build
ENV MIX_ENV=prod

# Install build dependencies
RUN apt-get update && apt-get install -y build-essential git \
    && apt-get clean && rm -f /var/lib/apt/lists/*_*

# Install hex + rebar
RUN mix local.hex --force && mix local.rebar --force

# Create app directory and copy the Elixir project into it
WORKDIR /app
COPY . .

# Install dependencies and compile
RUN mix deps.get --only prod
RUN mix compile

# Build release
RUN mix release
# Start a new build stage using the same base image to ensure compatibility
FROM hexpm/elixir:1.18.3-erlang-27.2.4-debian-bullseye-20250224-slim AS app

# Set environment variables for runtime
ENV MIX_ENV=prod \
    PORT=4000

WORKDIR /app

# Copy the release from the build stage
COPY --from=build /app/_build/prod/rel ./

# Expose port
EXPOSE 4000

# Set the entrypoint to the release start script
CMD ["./kube_demo/bin/kube_demo", "start"]