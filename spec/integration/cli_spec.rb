require "aruba_helper"

RSpec.describe "Cli presentation layer" do
  include ArubaHelper

  example "Basic example" do
    money "expenses list"
    expect(output).to match("Empty.")

    money "expenses", "create", "73.9", "euro", "food"
    expect(output).to match(%r{Created new expense with id ([\d\w]{8}).})
    
    id = output.scan(/[\d\w]{8}/)[0]

    money "expenses", "list"
    expect(output).to match(
      %r{#{id} - ....-..-.. ..:..:..: 73\.90 euro \[food\]}
    )

    money "expenses", "update", id, "--amount", "73.95"
    expect(output).to match("Updated expense #{id}.")

    money "expenses", "list"
    expect(output).to match(
      %r{#{id} - ....-..-.. ..:..:..: 73\.95 euro \[food\]}
    )

    money "expenses", "delete", id
    expect(output).to match("Deleted expense #{id}.")

    money "expenses list"
    expect(output).to match("Empty.")
  end

  example "Not found on update" do
    money "expenses", "update", "hello_world", "--amount", "99.99", expected_exit_status: 1
    expect(output).to match("Not found.")
  end

  example "Not found on delete" do
    money "expenses", "delete", "hello_world", expected_exit_status: 1
    expect(output).to match("Not found.")
  end

  example "Not updated on update" do
    money "expenses", "create", "25", "euro", "internet"
    id = output.scan(/[\d\w]{8}/)[0]

    money "expenses", "update", id, expected_exit_status: 1
    expect(output).to match("Not updated.")
  end

  describe "update functionality" do
    let!(:id) do
      money "expenses", "create", "75.39", "euro", "food", "italian"
      output.scan(/[\d\w]{8}/)[0]
    end

    example "updating amount only" do
      money "expenses", "update", id, "--amount", "74.99"
      money "expenses", "list"
      expect(output).to match(
        %r{#{id} - ....-..-.. ..:..:..: 74\.99 euro \[food italian\]}
      )
    end

    example "updating currency only" do
      money "expenses", "update", id, "--currency", "eur"
      money "expenses", "list"
      expect(output).to match(
        %r{#{id} - ....-..-.. ..:..:..: 75\.39 eur \[food italian\]}
      )
    end

    example "adding tags only" do
      money "expenses", "update", id, "--add-tags", "tasty", "pricey"
      money "expenses", "list"
      expect(output).to match(
        %r{#{id} - ....-..-.. ..:..:..: 75\.39 euro \[food italian pricey tasty\]}
      )
    end

    example "removing tags only" do
      money "expenses", "update", id, "--rm-tags", "food"
      money "expenses", "list"
      expect(output).to match(
        %r{#{id} - ....-..-.. ..:..:..: 75\.39 euro \[italian\]}
      )
    end

    example "removing and adding tags only" do
      money "expenses", "update", id, "--rm-tags", "food", "--add-tags", "restaurant", "awesome"
      money "expenses", "list"
      expect(output).to match(
        %r{#{id} - ....-..-.. ..:..:..: 75\.39 euro \[awesome italian restaurant\]}
      )
    end

    example "updating all fields at once" do
      money "expenses", "update", id,
            "--rm-tags", "food",
            "--amount", "95.49",
            "--currency=dollar",
            "--add-tags", "restaurant", "awesome"

      money "expenses", "list"
      expect(output).to match(
        %r{#{id} - ....-..-.. ..:..:..: 95\.49 dollar \[awesome italian restaurant\]}
      )
    end
  end

  private

  def money(*args, expected_exit_status: 0)
    command = money_command(*args)
    run_simple(command, false)
    @last_output = output_from(command)
    assert_exit_status(expected_exit_status)
  end

  def money_command(*args)
    "money #{args.join(" ")}"
  end

  def output
    @last_output
  end
end
