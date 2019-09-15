describe Session do
    def get_socket_and_logger
        socket, logger = double('socket'), double('logger')
        expect(socket).to receive(:recvmsg).and_return(['GET / HTTP/1.1'])
        expect(logger).to receive(:log).with('GET / HTTP/1.1')
        [socket, logger]
    end

    def get_session(type, text)
        socket, logger = get_socket_and_logger
        session = Session.new(socket, logger)

        expect(socket).to receive(:print).with("HTTP/1.1 200\r\n")
        expect(socket).to receive(:print).with("Content-Type: %s; charset=utf8\r\n" % type)
        expect(socket).to receive(:print).with("\r\n")
        expect(socket).to receive(:print).with(text + "\r\n")
        expect(socket).to receive(:close)

        session
    end

    it 'parses the path' do
        socket, logger = get_socket_and_logger
        session = Session.new(socket, logger)
        expect(session.path).to eq('/')
    end

    it 'responds with text' do
        get_session('text/plain', 'Hello').respond_with_text('Hello')
    end

    it 'responds with html' do
        get_session('text/html', '<b>Hello</b>').respond_with_html('<b>Hello</b>')
    end
end
