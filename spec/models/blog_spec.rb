require 'spec_helper'
require_relative '../../app/models/blog'
require 'ostruct'

describe Blog do
  before(:each) do
    @it = Blog.new
  end

  it 'has no entries' do
    expect(@it.entries.count).to eq 0
  end

  describe '#new_post' do
    before(:each) do
      @new_post = OpenStruct.new
      @it.post_source = ->{ @new_post}
    end

    it 'returns a new post' do
      expect(@it.new_post).to eq @new_post
    end

    it "sets the post's blog reference to itself" do
      expect(@it.new_post.blog).to eq @it
    end

    it 'accepts an attribute hash on behalf of the post-maker' do
      post_source = double.as_null_object
      expect(post_source).to receive(:call).with({x: 42, y: 'z'})
      @it.post_source = post_source
      @it.new_post(x: 42, y: 'z')
      post_source.verify
    end
  end

  describe '#add_entry' do
    it 'adds the entry to the blog' do
      entry = Object.new
      @it.add_entry(entry)
      expect(@it.entries).to include entry
    end
  end

end
