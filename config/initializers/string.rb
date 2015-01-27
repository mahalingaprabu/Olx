class String
    def is_i?
       !!(self =~ /^[-+]?[0-9]+$/)
    end

    def in?( *values )
    	values.include?( self )
    end
end
