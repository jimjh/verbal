require 'spec_helper'

describe Verbal, '#end_of_string' do

  subject { verbal }
  let(:verbal) do
    Verbal.new do
      find 'cat'
      end_of_string
    end
  end

  its(:source) { should eq '(?:cat)\z' }
  it { should match 'cat' }
  it { should_not match 'cats' }

end

