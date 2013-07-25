require 'spec_helper'

describe VerEx do

  describe '#find' do

    let(:matcher) do
      VerEx.new do
        find 'lions'
      end
    end

    it 'should correctly build find regex' do
      matcher.source.should == '(lions)'
    end

    it 'should correctly match find' do
      matcher.match('lions').should be_true
    end

    it 'should match part of a string with find' do
      matcher.match('lions, tigers, and bears, oh my!').should be_true
    end

    it 'should only match the `find` part of a string' do
      matcher.match('lions, tigers, and bears, oh my!')[0].should == 'lions'
    end
  end

  describe 'URL Regex Test' do

    let(:matcher) do
      VerEx.new do
        start_of_line
        find 'http'
        maybe 's'
        find '://'
        maybe 'www.'
        anything_but ' '
        end_of_line
      end
    end

    it 'successfully builds regex for matching URLs' do
      matcher.source.should == '^(http)(s)?(\:\/\/)(www\.)?([^\ ]*)$'
    end

    it 'matches regular http URL' do
      matcher.match('http://google.com').should be_true
    end

    it 'matches https URL' do
      matcher.match('https://google.com').should be_true
    end

    it 'matches a URL with www' do
      matcher.match('https://www.google.com').should be_true
    end

    it 'fails to match when URL has a space' do
      matcher.match('http://goo gle.com').should be_false
    end

    it 'fails to match with htp:// is malformed' do
      matcher.match('htp://google.com').should be_false
    end
  end
end
