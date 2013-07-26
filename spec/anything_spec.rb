require 'spec_helper'

describe Verbal, '#anything' do

  subject { verbal }

  let(:verbal) do
    Verbal.new do
      find  'http'
      anything
    end
  end

  its(:source) { should eq '(?:http)(?:.*)' }

  it 'matches a string without a suffix' do
    (verbal =~ 'http').should eq 0
  end

  it 'matches a string with a suffix' do
    verbal.match('whttps://')[0].should eq 'https://'
  end

end


