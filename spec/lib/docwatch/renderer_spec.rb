describe Renderer do
    let (:markdown_renderer) do
        renderer = Renderer.by_filetype('markdown.md')
        expect(renderer).to receive(:contents).at_least(1).and_return('# Header')
        expect(renderer.head).to include('<style>')
        expect(renderer.body).to include('<h1 id="header">Header</h1>')
        renderer
    end

    let (:html_renderer) do
        renderer = Renderer.by_filetype('html.html')
        html = '<html><head><title>Hello</title></head><body><b>body</b></body></html>'
        expect(renderer).to receive(:contents).at_least(1).and_return(html)
        expect(renderer.body).to include('<b>body</b>')
        expect(renderer.head).to include('<title>Hello</title>')
        renderer
    end

    it 'picks HTML renderer' do
        expect(html_renderer).to be_instance_of(HtmlRenderer)
    end

    it 'picks the markdown renderer' do
        expect(markdown_renderer).to be_instance_of(MarkdownRenderer)
    end

    it 'mentions reloading and fetch' do
        expect(markdown_renderer.to_html).to include('location.reload')
        expect(markdown_renderer.to_html).to include('fetch')
    end
end
