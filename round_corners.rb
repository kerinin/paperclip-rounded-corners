module Paperclip
  class RoundCorners < Paperclip::Thumbnail

    def parse_opts(key)
      opt = @options["border_radius_#{key}".to_sym] || @options["border_radius_#{key.delete('_')}".to_sym] || @options[:border_radius]
      opt.nil? ? nil : opt.to_i
    end
    
    def transformation
      trans = " \\( +clone  -threshold -1 "
      trans << "-draw 'fill black polygon 0,0 0,#{@topleft} #{@topleft},0 fill white circle #{@topleft},#{@topleft} #{@topleft},0' " unless @topleft.nil?
      trans << "-draw 'fill black polygon #{@width},0 #{@width},#{@topright} #{@width-@topright},0 fill white circle #{@width-@topright},#{@topright} #{@width},#{@topright}' " unless @topright.nil?
      trans << "-draw 'fill black polygon 0,#{@height} #{@bottomleft},#{@height} 0,#{@height-@bottomleft} fill white circle #{@bottomleft},#{@height-@bottomleft} #{@bottomleft},#{@height}' " unless @bottomleft.nil?
      trans << "-draw 'fill black polygon #{@width},#{@height} #{@width},#{@height-@bottomright} #{@width-@bottomright},#{@height} fill white circle #{@width-@bottomright},#{@height-@bottomright} #{@width},#{@height-@bottomright}' " unless @bottomright.nil?
      trans << "\\) +matte -compose CopyOpacity -composite " 
    end    
    
    def round_corners(dst)
      command = "\"#{ File.expand_path( @thumbnail.path ) }[0]\"\n#{ transformation }\n\"#{ File.expand_path(dst.path) }\"\n" 
      Paperclip.run('convert',command)
      dst
    end
        
    def initialize(file, options = {}, attachment = nil)
      super file, options, attachment
      
      @options = options
      
      @topleft      = parse_opts 'top_left'
      @topright     = parse_opts 'top_right'
      @bottomleft   = parse_opts 'bottom_left'
      @bottomright  = parse_opts 'bottom_right'

      @process = @topleft || @topright || @bottomleft || @bottomright
    end
  
    def make
      @thumbnail = super
      
      if @process  
        @width = Paperclip::Geometry.from_file(@thumbnail).width.to_i
        @height = Paperclip::Geometry.from_file(@thumbnail).height.to_i
        
        dst = Tempfile.new([@basename, @format].compact.join("."))
        dst.binmode    
        
        return round_corners( dst )
      else
        return @thumbnail
      end
    end
  end
end
