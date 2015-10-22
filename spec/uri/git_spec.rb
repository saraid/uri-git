require 'uri/git'

describe URI::Git do
  describe '.parse' do
    subject(:valid) { URI::Git.parse('git@github.com:saraid/uri-git.git') }

    it 'returns a URI::Git for a valid git url' do
      expect(valid).to be_instance_of(URI::Git)
      expect(valid.scheme).to eq('git')
      expect(valid.user).to eq('git')
      expect(valid.password).to be_nil
      expect(valid.host).to eq('github.com')
      expect(valid.repo).to eq('saraid/uri-git.git')
    end
  end

  describe '#to_remote_str' do
    subject { URI::Git.parse('git@github.com:saraid/uri-git.git').to_remote_str }

    it 'returns no scheme' do
      expect(subject.include? '://').to be false
    end
  end

  describe '#to_https' do
    subject { URI::Git.parse('git@github.com:saraid/uri-git.git').to_https }

    it 'should return a URI::HTTPS object' do
      expect(subject).to be_a(URI::HTTPS)
    end

    it 'should be usable as a URI object' do
      subject.path += '/pulls'
      expect(subject.to_s).to eq('https://github.com/saraid/uri-git/pulls')
    end
  end
end
