require 'spec_helper'

describe Verbal do

  describe 'URL Regex Test' do

    let(:matcher) do
      Verbal.new do
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
      matcher.source.should == "^(?:http)(?:s)?(?:://)(?:www\\.)?(?:[^\\ ]*)$"
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
