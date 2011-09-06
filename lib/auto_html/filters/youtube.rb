AutoHtml.add_filter(:youtube).with(:width => 390, :height => 250, :frameborder => 0) do |text, options|
  regex = /http:\/\/(www.)?youtube\.com\/watch\?v=([A-Za-z0-9._%-]*)(\&[^< ]+)?(\s+)?/
  text.gsub(regex) do
    youtube_id = $2
    width = options[:width]
    height = options[:height]
    frameborder = options[:frameborder]
    query_string = "?wmode=#{options[:wmode]}" if options[:wmode]
    if options[:thumbnail]
      img = %{<img src="http://img.youtube.com/vi/#{youtube_id}/default.jpg" alt="#{youtube_id}"/>}
      icon = %{<span class="youtube-icon"></span>}
      thumbnail = %{<a class="youtube-thumbnail" href="#open_video">#{img}#{icon}</a>}
    end
    %{#{thumbnail}<iframe class="youtube-player" type="text/html" width="#{width}" height="#{height}" src="http://www.youtube.com/embed/#{youtube_id}#{query_string}" frameborder="#{frameborder}">
</iframe>}
  end
end

