require 'aruba/api'
require 'aruba/reporting'

module ArubaHelper
  include Aruba::Api

  def included(base)
    base.before(:each) do
      @aruba_io_wait_seconds = 1
      @aruba_timeout_seconds = 2

      restore_env
      clean_current_dir
    end
  end
end
