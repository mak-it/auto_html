#AutoHtml.add_filter(:youtube).with(:width => 390, :height => 250, :frameborder => 0) do |text, options|
AutoHtml.add_filter(:youtube).with(:width => 420, :height => 315, :frameborder => 0, :wmode => nil) do |text, options|
  # Final part of regular expression is from URI::regexp for query part
  regex = /(https?):\/\/(www.)?(youtube\.com\/watch\?v=|youtu\.be\/)([A-Za-z0-9_-]*)((?:[\-_.!~*'()a-zA-Z\d;\/?:@&=+$,\[\]]|%[a-fA-F\d]{2})*)*/
  text.gsub(regex) do
    protocol = $1
    youtube_id = $4
    width = options[:width]
    height = options[:height]
    frameborder = options[:frameborder]
		wmode = options[:wmode]
		src = "#{protocol}://www.youtube.com/embed/#{youtube_id}"
		src += "?wmode=#{wmode}" if wmode
    if options[:thumbnail]
      img = %{<img src="http://img.youtube.com/vi/#{youtube_id}/default.jpg" alt="#{youtube_id}"/>}
      icon = %{<span class="youtube-icon"></span>}
      thumbnail = %{<a class="youtube-thumbnail" href="#open_video">#{img}#{icon}</a>}
    end
    %{#{thumbnail}<iframe width="#{width}" height="#{height}" src="#{src}" frameborder="#{frameborder}" allowfullscreen></iframe>}
  end
end

