require 'spec_helper'

describe Verbal, '#multiple' do

  subject { verbal }

  context 'string' do
    let(:verbal) { Verbal.new { multiple 'zk.+' } }
    its(:source) { should eq '(zk\.\+)+' }
    it 'matches multiples of the given value' do
      (verbal =~ 'whereiszk.+zk.+zk.+qw').should eq 7
    end
  end

  context 'regex' do
    let(:verbal) { Verbal.new { multiple(/[xyz]u/) } }
    its(:source) { should eq '([xyz]u)+' }
    it 'matches multiples of the given value' do
      verbal.match('this is xuxuyuzu')[0].should eq 'xuxuyuzu'
    end
  end

end



