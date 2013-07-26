require 'spec_helper'

describe Verbal, '#line_break' do

  subject { verbal }

  let(:verbal) do
    Verbal.new do
      find  'this'
      line_break
      find 'that'
    end
  end

  its(:source) { should eq '(?:this)(?:\n|(?:\r\n))(?:that)' }

  it 'matches a string correctly' do
    verbal.match("this\nthat and w")[0].should eq "this\nthat"
  end

end


