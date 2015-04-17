require "aruba_helper"

RSpec.describe "Cli presentation layer" do
  include ArubaHelper

  example "Basic example" do
    money "expenses"
    expect(output).to eq("Empty.")
  end

  private

  def money(*args, expected_exit_status: 0)
    command = money_command(*args)
    run_simple(command)
    @last_output = output_from(command)
    assert_exit_status(expected_exit_status)
  end

  def money_command(*args)
    "bundle exec money #{args.join(" ")}"
  end

  def output
    @last_output
  end
end
