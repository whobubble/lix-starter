use Mix.Releases.Config,
  # This sets the default release built by `mix release`
  default_release: :default,
  # This sets the default environment used by `mix release`
  default_environment: :dev

# For a full list of config options for both releases
# and environments, visit https://hexdocs.pm/distillery/configuration.html

# You may define one or more environments in this file,
# an environment's settings will override those of a release
# when building in that environment, this combination of release
# and environment configuration is called a profile

environment :dev do
  set(dev_mode: true)
  set(include_erts: false)
  set(cookie: :"39<U/.8Njz1HOAicW}M;J8J/2]F^nNSwG@LC>s>jqhns`o^SBq_wn/whs3F.cDuh")
end

environment :prod do
  set(include_erts: true)
  set(include_src: false)
  set(cookie: :"U2M2^qH.w0|nCS%J/WDg:O.Ek%p,Hi!V4}D0!HK=$?PU@o=*ERI$vg1!jOn[SGYI")
end

# You may define one or more releases in this file.
# If you have not set a default release, or selected one
# when running `mix release`, the first release in the file
# will be used by default

release :engine_interface do
  set(version: current_version(:engine_interface))
end
