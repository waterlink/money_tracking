require "money_tracking/cli"

module MoneyTracking
  module Cli
    class Runner
      def initialize(argv, stdin = STDIN, stdout = STDOUT, stderr = STDERR, kernel = Kernel)
        @argv, @stdin, @stdout, @stderr, @kernel = argv, stdin, stdout, stderr, kernel
      end

      def execute!
        kernel.exit(run_cli { App.start(argv) })
      end

      private

      attr_reader :argv, :stderr, :stdin, :stdout, :kernel

      def setup_streams
        $stderr = stderr
        $stdin = stdin
        $stdout = stdout
      end

      def reset_streams
        $stderr = STDERR
        $stdin = STDIN
        $stdout = STDOUT
      end

      def run_cli
        setup_streams
        yield
        0

      rescue Cli::Error => e
        e.render
        1

      rescue StandardError => e
        b = e.backtrace
        stderr.puts("#{b.shift}: #{e.message} (#{e.class})")
        stderr.puts(b.map{|s| "\tfrom #{s}"}.join("\n"))
        1

      rescue SystemExit => e
        e.status

      ensure
        reset_streams

      end
    end
  end
end
