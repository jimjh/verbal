require 'spec_helper'

describe Verbal, '#end_of_line' do

  subject { verbal }

  let(:verbal) do
    Verbal.new do
      find 'x'
      end_of_line
    end
  end

  its(:source) { should eq '(?:x)$' }

  it 'matches a string at the end of a line' do
    (verbal =~ 'zyx').should eq 2
  end

end

