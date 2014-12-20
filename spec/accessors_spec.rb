# -*- encoding : utf-8 -*-

require File.join(File.expand_path(File.dirname(__FILE__)), 'spec_helper')

describe "Accessors" do
  before(:each) do
    @shout = Shout.new
    @description = 'çaffé düdeldø'
    @genre = 'foobar'
    @shout.genre = @genre
    @shout.description = @description
  end
  it "should not change the original encoding" do
    pending 'rb19 only' if RUBY_VERSION < '1.9'
    expect(@shout.description.encoding).to eq(@description.encoding)
    expect(@shout.genre.encoding).to eq(@genre.encoding)
  end
  describe "#original_..." do
    it "should store the original value" do
      expect(@shout.original_description).to eq(@description)
      expect(@shout.original_genre).to eq(@genre)
    end
  end
  it "should get and set the bitrate in audio_info" do
    @shout.bitrate = "128"
    expect(@shout.bitrate).to eq("128")
  end
  describe "#initialize" do
    it "should set the properies from the opts" do
      s = Shout.new :user => 'heinz'
      expect(s.user).to eq('heinz')
    end
  end
  describe "#charset" do
    describe "if it is set" do
      it "should use the set charset" do
        @shout.charset = 'bla'
        expect(@shout.charset).to eq('bla')
      end
    end
    describe "if it is not set" do
      before(:each) do
        @shout.charset = nil
      end
      describe "if the format is set and MP3" do
        it "should be ISO" do
          @shout.format = Shout::MP3
          expect(@shout.charset).to eq('ISO-8859-1')
        end
      end
      describe "if the format isn't set" do
        it "should be UTF8" do
          @shout.format = Shout::OGG
          expect(@shout.charset).to eq('UTF-8')
        end
      end
    end
  end
end

