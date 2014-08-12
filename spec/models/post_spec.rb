require 'spec_helper'
require_relative '../../app/models/post'

describe Post do
  before do
    @it = Post.new
  end

  it 'starts with blank attributes ' do
    expect(@it.title).to be_nil
    expect(@it.body).to be_nil
  end

  it 'supports reading and writing a title' do
    @it.title = 'foo'
    expect(@it.title).to eq 'foo'
  end

  it 'supports reading and writing a post body' do
    @it.body = 'foo'
    expect(@it.body).to eq 'foo'
  end

  it 'supports reading and writing a blog reference' do
    blog = Object.new
    @it.blog = blog
    expect(@it.blog).to eq blog
  end

  it 'supports setting attributes in the initializer' do
    it = Post.new(title: 'mytitle', body: 'mybody')
    expect(it.title).to eq 'mytitle'
    expect(it.body).to eq 'mybody'
  end

  describe '#publish' do
    before(:each) do
      @blog = double.as_null_object
      @it.blog = @blog
    end

    after(:each) do
      @blog.verify
    end

    it 'adds the post to the blog' do
      expect(@blog).to receive(:add_entry).with(@it)
      @it.publish
    end
  end
end