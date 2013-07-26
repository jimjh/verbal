require 'spec_helper'

describe Verbal, '#range' do

  subject { verbal }

  let(:verbal) do
    Verbal.new do
      range 'a', 'z', '0', '9'
      find 'that'
    end
  end

  its(:source) { should eq '[a-z0-9](?:that)' }

  it 'matches a string correctly' do
    (verbal =~ 'W9that').should eq 1
  end

end



