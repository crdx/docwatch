describe Connection do
    let (:session)  { double('session') }
    let (:renderer) { double('renderer') }
    let (:watcher)  { double('watcher') }
    let (:socket)   { double('socket') }
    let (:logger)   { double('logger') }
    let (:connection) { Connection.new(renderer, watcher, session) }

    it 'handles /' do
        expect(session).to receive(:path).and_return('/')
        expect(session).to receive(:respond_with_html)
        expect(renderer).to receive(:to_html)
        expect(connection).to be_instance_of(Connection)

        connection.handle
    end

    it 'handles /wait' do
        expect(session).to receive(:path).and_return('/wait')
        expect(watcher).to receive(:wait)
        expect(session).to receive(:respond_with_text)
        expect(connection).to be_instance_of(Connection)

        connection.handle
    end
end
