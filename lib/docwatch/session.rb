module Docwatch
    class Session
        def initialize(socket, logger)
            @socket = socket
            @logger = logger

            logger.log first_request_line
        end

        def close
            @socket.close
        end

        def path
            return if first_request_line.length == 0
            first_request_line.split(' ')[1]
        end

        def respond_with_text(str)
            respond_with(str, 'text/plain')
        end

        def respond_with_html(str)
            respond_with(str, 'text/html')
        end

        def respond_with(str, content_type)
            println 'HTTP/1.1 200'
            println 'Content-Type: %s; charset=utf8' % content_type
            # println 'Connection: close'
            println
            println str

            close
        end

        private

        def input_lines
            @input_lines ||= @socket.recvmsg[0].lines rescue []
        end

        def first_request_line
            input_lines.each(&:chomp).first
        end

        def print(msg)
            @socket.print msg rescue nil
        end

        def println(msg = '')
            print msg + "\r\n"
        end
    end
end
