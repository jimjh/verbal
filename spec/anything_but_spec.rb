require 'spec_helper'

describe Verbal, '#anythingBut' do

  subject { verbal }

  let(:verbal) do
    Verbal.new do
      find  'http'
      anything_but 's:.?'
    end
  end

  its(:source) { should eq '(?:http)(?:[^s:\.\?]*)' }

  it 'matches a string without a suffix' do
    (verbal =~ 'http').should eq 0
  end

  it 'matches a string with a suffix' do
    verbal.match('whttps://')[0].should eq 'http'
  end

end


