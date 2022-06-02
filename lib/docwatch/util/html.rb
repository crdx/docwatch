module Docwatch
    module Util
        class HTML
            def self.render(data)
                case data
                when Hash
                    rows = data.map do |(k, v)|
                        '<th>%s</th><td>%s</td>' % [HTML.render(k), HTML.render(v)]
                    end.join('</tr><tr>')
                    '<table><tr>%s</tr></table>' % rows
                when Array
                    rows = data.map do |v|
                        '<li>%s</li>' % HTML.render(v)
                    end.join
                    '<ul>%s</ul>' % rows
                else
                    CGI.escapeHTML(data.to_s)
                end
            end
        end
    end
end
