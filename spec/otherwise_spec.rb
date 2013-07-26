require 'spec_helper'

describe Verbal, '#otherwise' do

  subject { verbal }
  let(:verbal) do
    Verbal.new do
      find 'http'
      maybe 's'
      find '://'
      otherwise
      maybe 's'
      find 'ftp://'
    end
  end

  it { should match 'http://' }
  it { should match 'https://' }
  it { should match 'ftp://' }
  it { should match 'sftp://' }

end

