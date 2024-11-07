# Bolt⚡

Bolt⚡ is a Nerves application that checks your internet connection
periodically to ensure connectivity. Signifies connection with LEDs.
A green light means everything is normal.
If connection becomes latent, or drops packets, you will see a yellow light.
If the connection is down or drops 100% of packets, you get a red light and the relay cycles the power.

## FPING

This nerves build requires fping. The fping nerves system is located at: https://github.com/supersimple/fping_rpi0

## Future Goals
- Publish API to show current performance.
- Send a text message when router is restarting

## Design
![](https://github.com/supersimple/bolt/blob/main/src/fritzing.png)

## Targets

Nerves applications produce images for hardware targets based on the
`MIX_TARGET` environment variable. If `MIX_TARGET` is unset, `mix` builds an
image that runs on the host (e.g., your laptop). This is useful for executing
logic tests, running utilities, and debugging. Other targets are represented by
a short name like `rpi3` that maps to a Nerves system image for that platform.
All of this logic is in the generated `mix.exs` and may be customized. For more
information about targets see:

https://hexdocs.pm/nerves/targets.html#content

## Getting Started

To start your Nerves app:
  * `export MIX_TARGET=my_target` or prefix every command with
    `MIX_TARGET=my_target`. For example, `MIX_TARGET=rpi3`
  * Install dependencies with `mix deps.get`
  * Create firmware with `mix firmware`
  * Burn to an SD card with `mix firmware.burn`

## Learn more

  * Official docs: https://hexdocs.pm/nerves/getting-started.html
  * Official website: https://nerves-project.org/
  * Forum: https://elixirforum.com/c/nerves-forum
  * Discussion Slack elixir-lang #nerves ([Invite](https://elixir-slackin.herokuapp.com/))
  * Source: https://github.com/nerves-project/nerves
