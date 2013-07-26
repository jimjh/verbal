require 'spec_helper'

describe Verbal, '#maybe' do

  subject { verbal }

  let(:verbal) do
    Verbal.new do
      find  'http'
      maybe 's'
    end
  end

  its(:source) { should eq '(?:http)(?:s)?' }

  it 'matches a string without the value' do
    (verbal =~ 'http').should eq 0
  end

  it 'matches a string with the value' do
    (verbal =~ 'https').should eq 0
  end

end

