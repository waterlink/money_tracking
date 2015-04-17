COMMANDS = %w[
  list create update delete
]

COMMANDS.each do |command|
  require "money_tracking/cli/#{command}_command"
end
