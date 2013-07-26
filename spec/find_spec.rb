require 'spec_helper'

describe Verbal, '#find' do

  subject { verbal }

  let(:verbal) do
    Verbal.new do
      find 'lions? yup.'
    end
  end

  its(:source) { should eq '(?:lions\?\ yup\.)' }

  it 'matches a string at the correct position' do
    (verbal =~ 'are these lions? yup...').should eq 10
  end

end

