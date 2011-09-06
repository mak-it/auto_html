require File.expand_path('../../unit_test_helper', __FILE__)

class YouTubeTest < Test::Unit::TestCase

  def test_transform
    result = auto_html('http://www.youtube.com/watch?v=BwNrmYRiX_o') { youtube }
    assert_equal '<iframe class="youtube-player" type="text/html" width="390" height="250" src="http://www.youtube.com/embed/BwNrmYRiX_o" frameborder="0">
</iframe>', result
  end

  def test_transform2
    result = auto_html('http://www.youtube.com/watch?v=BwNrmYRiX_o&eurl=http%3A%2F%2Fvukajlija.com%2Fvideo%2Fklipovi%3Fstrana%3D6&feature=player_embedded') { youtube }
    assert_equal '<iframe class="youtube-player" type="text/html" width="390" height="250" src="http://www.youtube.com/embed/BwNrmYRiX_o" frameborder="0">
</iframe>', result
  end

  def test_transform3
    result = auto_html('http://www.youtube.com/watch?v=BwNrmYRiX_o&feature=related') { youtube }
    assert_equal '<iframe class="youtube-player" type="text/html" width="390" height="250" src="http://www.youtube.com/embed/BwNrmYRiX_o" frameborder="0">
</iframe>', result
  end

  def test_transform_url_without_www
    result = auto_html('http://youtube.com/watch?v=BwNrmYRiX_o') { youtube }
    assert_equal '<iframe class="youtube-player" type="text/html" width="390" height="250" src="http://www.youtube.com/embed/BwNrmYRiX_o" frameborder="0">
</iframe>', result
  end

  def test_transform_with_options
    result = auto_html('http://www.youtube.com/watch?v=BwNrmYRiX_o') { youtube(:width => 300, :height => 255, :frameborder => 1) }
    assert_equal '<iframe class="youtube-player" type="text/html" width="300" height="255" src="http://www.youtube.com/embed/BwNrmYRiX_o" frameborder="1">
</iframe>', result
  end

  def test_transform_without_html_truncate
    result = auto_html('http://www.youtube.com/watch?v=BwNrmYRiX_o<p>My HTML</p>') { youtube }
    assert_equal '<iframe class="youtube-player" type="text/html" width="390" height="250" src="http://www.youtube.com/embed/BwNrmYRiX_o" frameborder="0">
</iframe><p>My HTML</p>', result
  end

  def test_transform_without_continious_text_truncate
    result = auto_html('http://www.youtube.com/watch?v=BwNrmYRiX_o My Text') { youtube }
    assert_equal '<iframe class="youtube-player" type="text/html" width="390" height="250" src="http://www.youtube.com/embed/BwNrmYRiX_o" frameborder="0">
</iframe>My Text', result
  end

  def test_transform_with_thumbnail
    result = auto_html('http://www.youtube.com/watch?v=BwNrmYRiX_o') { youtube({:thumbnail => true}) }
    assert_equal '<a class="youtube-thumbnail" href="#open_video"><img src="http://img.youtube.com/vi/BwNrmYRiX_o/default.jpg" alt="BwNrmYRiX_o"/></a><iframe class="youtube-player" type="text/html" width="390" height="250" src="http://www.youtube.com/embed/BwNrmYRiX_o" frameborder="0">
</iframe>', result
  end
end
