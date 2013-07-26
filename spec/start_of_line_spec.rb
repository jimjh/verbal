require 'spec_helper'

describe Verbal, '#start_of_line' do

  subject { verbal }

  let(:verbal) do
    Verbal.new do
      start_of_line
      find 'x'
    end
  end

  its(:source) { should eq '^(?:x)' }

  it 'matches a string at the beginning' do
    (verbal =~ 'xyz').should eq 0
  end

end

