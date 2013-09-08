module Sword
  module Server
    module Injector
      def inject
        send_injections(find_injections)
      end

      def find_injections
        methods.delete_if { |m| not m.to_s.start_with? 'inject_' }
      end

      def send_injections(injections)
        send_last_injections send_general_injections send_first_injections(injections)
      end

      def send_first_injections(injections)
        debugln "Sending high-priority injections..."
        remaining = injections.dup
        injections.delete_if { |i| not i.to_s.end_with? '_first' }
        send_list injections
        remaining - injections
      end

      def send_general_injections(injections)
        debugln "Sending general injections..."
        last = injections.dup.delete_if { |i| not i.to_s.end_with? '_last' }
        send_list (injections - last)
        last
      end

      def send_last_injections(injections)
        debugln "Sending low-priority injections..."
        send_list(injections)
      end

      def send_list(injections)
        injections.each do |i|
          sdebugln i
          send i
        end
      end
    end
  end
end
