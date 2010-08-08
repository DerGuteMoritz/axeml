require Pathname.new(__FILE__).dirname.join('spec_helper')

describe AxeML do

  describe 'only root' do 
    
    before :each do
      @doc = AxeML.transform([:p, 'hey'])
    end

    it 'should convert to a nokogiri tree' do
      @doc.should be_a(Nokogiri::XML::Document)
    end

    it 'should contain one p element containing hey' do
      @doc.children.size.should == 1
      @doc.root.node_name.should == 'p'
      @doc.root.content.should == 'hey'
    end

  end

  it 'should allow nesting' do
    doc = AxeML.transform([:foo, 'zing', [:bar, [:baz, "hello"], [:another, "here"]]])
    doc.root.node_name.should == 'foo'
    doc.root.content == 'zing'
    doc.root.children.size.should == 2
    doc.root.children[0].should be_a(Nokogiri::XML::Text)
    bar = doc.root.children[1]
    bar.node_name.should == 'bar'
    bar.children.size.should == 2
    bar.children[0].node_name.should == 'baz'
    bar.children[0].content.should == 'hello'
    bar.children[1].node_name.should == 'another'
    bar.children[1].content.should == 'here'
  end

  it 'should allow attributes' do
    doc = AxeML.transform([:foo, { :bar => 'baz', :qux => '123' }, { :bar => 'heh!'}])
    doc.root.attributes['bar'].content.should == 'heh!'
    doc.root.attributes['qux'].content.should == '123'
  end

  it 'should allow arbitrary list wrapping' do
    doc = AxeML.transform([:foo, [[[:foo, 'bar']], [:foo, 'baz']]])
    doc.search('foo foo:first').text.should == 'bar'
    doc.search('foo foo:last').text.should == 'baz'
  end

  it 'should respect html_safe' do
    doc = AxeML.transform([:foo, '<bar>okay</bar>'.html_safe])
    doc.search('bar').text.should == 'okay'
  end
  
end
