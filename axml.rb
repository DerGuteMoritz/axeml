require 'rubygems'
require 'nokogiri'

module AxML
  
  def self.transform(axml)
    doc = Nokogiri::XML::Document.new
    transform_element(axml, doc)
    doc
  end

  def self.transform_element(axml, doc, parent = doc)
    el = parent.add_child(Nokogiri::XML::Element.new(axml[0].to_s, doc))
    
    axml[1..-1].each do |e|
      case e 
      when Array
        el.add_child(transform_element(e, doc, el))
      when String
        el.content += e
      when Fixnum, Float
        el.content += e.to_s
      when Hash
        e.each do |k,v|
          el[k.to_s] = v
        end
      end
    end

    el
  end

end
