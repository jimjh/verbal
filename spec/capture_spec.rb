require 'spec_helper'

describe Verbal, '#capture' do

  subject { verbal }
  let(:verbal) do
    Verbal.new do
      capture { anything }
      find ' by '
      capture { anything }
    end
  end
  let(:string) { 'this is it by michael jackson' }

  it { should match string }

  context 'matched data' do
    subject { verbal.match string }
    its([1]) { should eq 'this is it' }
    its([2]) { should eq 'michael jackson' }
  end

end

