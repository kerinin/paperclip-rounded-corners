Paperclip Rounded Corners
=============

This processor generates rounded corners using the CSS3 border-radius syntax.


Usage
=============

    class Image < ActiveRecord::Base
      has_attachached_file :avatar, :styles => {
        :style1 => {:size => '200x200', :border_radius => 10}
        :style2 => {:size => '200x200', :border_radius_topleft => 10, :border_radius_topright => 10}
        :style3 => {:size => '200x200', :border_radius_bottom-left => 10, :border_radius_bottom_right => 10}
        :style4 => {:size => '200x200', :border_radius_bottom-left => 10, :border_radius_bottom_right => 10}  
        :style5 => {:size => '200x200', :border_radius => '10 10 0 0'} 
        :style5 => {:size => '200x200', :border_radius => '10 0'}    
        }
