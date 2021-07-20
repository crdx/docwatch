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
            if first_request_line.nil? || first_request_line.length == 0
                return
            end

            first_request_line.split(' ')[1]
        end

        def respond_with_text(str)
            respond_with(200, str, 'text/plain')
        end

        def respond_with_html(str)
            respond_with(200, str, 'text/html')
        end

        def respond_with_404
            respond_with(404, 'Not Found', 'text/html')
        end

        def respond_with(code, str, content_type)
            println 'HTTP/1.1 %d' % code
            println 'Content-Type: %s; charset=utf8' % content_type
            println
            println str

            close
        end

        private

        def input_lines
            @input_lines ||= @socket.recvmsg[0].lines
        rescue
            []
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
