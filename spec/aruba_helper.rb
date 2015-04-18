require "aruba/api"
require "aruba/reporting"
require "aruba/in_process"

require "money_tracking/cli/runner"

Aruba::InProcess.main_class = MoneyTracking::Cli::Runner
Aruba.process = Aruba::InProcess

class Aruba::InProcess
  def output
    @stdout.string + @stderr.string
  end
end

module ArubaHelper
  include Aruba::Api

  def self.included(base)
    base.before(:each) do
      @aruba_io_wait_seconds = 5
      @aruba_timeout_seconds = 5

      restore_env
      clean_current_dir
    end
  end
end
