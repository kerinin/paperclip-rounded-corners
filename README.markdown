Paperclip Rounded Corners
=============

This processor generates rounded corners.


Usage
=============
Just tell your style how to treat the borders (the syntax is based on CSS3), and add 
the 'round_corners' processor, either to the attached file or to specific styles. 
You probably want to make sure the output format can handle transparency.

    class Image < ActiveRecord::Base
      has_attachached_file :avatar, :processors => [:round_corners], :styles => {
        :style1 => {:border_radius => 10, :format => :png, :geometry => '200x200', :format => :png, :geometry => '200x200'}
        :style2 => {:border_radius_topleft => 10, :border_radius_topright => 10, :format => :png, :geometry => '200x200'}
        :style3 => {:border_radius_bottom_left => 10, :border_radius_bottom_right => 10, :format => :png, :geometry => '200x200'}
        :style4 => {:border_radius_bottom_left => 10, :border_radius_bottom_right => 10, :format => :png, :geometry => '200x200'}    
        }

The radius values should be in pixels and will be applied _after_ the geometry transformation.


Limitations
=============
* No elliptical borders
* No shorthand syntax parsing (:border_radius => '10 5 10 0') as defined in CSS3
* Only pixel values allowed as input
