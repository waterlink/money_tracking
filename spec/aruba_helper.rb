require 'aruba/api'
require 'aruba/reporting'

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
