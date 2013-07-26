require 'spec_helper'

describe Verbal, '#start_of_string' do

  subject { verbal }
  let(:verbal) do
    Verbal.new do
      start_of_string
      find 'cat'
    end
  end

  its(:source) { should eq '\A(?:cat)' }
  it { should match 'cat' }
  it { should_not match 'a cat' }

end

