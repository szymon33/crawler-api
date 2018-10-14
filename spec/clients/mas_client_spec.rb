require 'rails_helper'

describe MasClient do
  let(:mas_client) { described_class.new }
  let(:valid_search_str) { 'Mortgages – a beginner’s guide' }
  let(:invalid_search_str) { 'Lorem ipsum dolor sit amet' }
  let(:server_response) { double('success?': false) }
  let(:stub_server!) { allow(described_class).to receive(:get) { server_response } }

  describe '.build' do
    it 'calls external service with get class method' do
      stub_server!
      expect(described_class).to receive(:get).with('/en/search',
                                                    query: { query: nil })
      described_class.new.build
    end

    context 'with result in English', vcr: { record: :new_episodes,
                                             cassette_name: 'mas-with-result' } do
      subject { described_class.new(valid_search_str).build }

      it { is_expected.to be_a Hash }
      it { is_expected.to_not be_empty }
      it { is_expected.to include(:en) }

      describe 'hash array' do
        subject { described_class.new(valid_search_str).build.fetch(:en) }

        # real data
        it { is_expected.to include(url: 'https://www.moneyadviceservice.org.uk/en/articles/mortgages-a-beginners-guide') }
        it { is_expected.to include(title: 'Mortgages – a beginner’s guide') }
      end
    end

    context 'with result in Welsh', vcr: { record: :new_episodes,
                                           cassette_name: 'mas-with-result' } do
      subject { described_class.new(valid_search_str).build }

      it { is_expected.to include(:cy) }

      describe 'hash array' do
        subject { described_class.new(valid_search_str).build.fetch(:cy) }

        # real data
        it { is_expected.to include(url: 'https://www.moneyadviceservice.org.uk/cy/articles/morgeisi-canllaw-i-ddechreuwyr') }
        it { is_expected.to include(title: 'Morgeisi – canllaw i ddechreuwyr') }
      end
    end

    context 'when no result', vcr: { cassette_name: 'mas-no-results' } do
      subject { described_class.new(invalid_search_str).build }

      it { is_expected.to be_a Hash }
      it { is_expected.to be_empty }
    end

    context 'with empty search query', vcr: { record: :new_episodes,
                                              cassette_name: 'mas-with-empty-search' } do
      subject { described_class.new.build }

      it { is_expected.to be_a Hash }
      it { is_expected.to be_empty }
    end
  end

  describe '.english_version' do
    before { stub_server! }

    it 'returns empty hash when pattern does not match' do
      expect(mas_client.send(:english_version, 'not matching pattern'))
        .to eq({})
    end
  end

  describe '.welsh_version' do
    subject { mas_client.send(:welsh_version) }
    before { stub_server! }

    it 'returns empty hash when welsh url is not set' do
      allow(mas_client).to receive(:welsh_version_url)
      expect(subject).to eq({})
    end

    it 'calls external service with get class method' do
      expect(described_class).to receive(:get)
      subject
    end
  end

  describe '.welsh_version_url' do
    subject { mas_client.send(:welsh_version_url) }
    before { stub_server! }

    it 'retunrs welsh_version_url if welsh_version_url is set' do
      mas_client.instance_variable_set('@welsh_version_url', 'La La Land')
      expect(subject).to eq('La La Land')
    end

    it 'calls external service with get class method' do
      expect(described_class).to receive(:get)
      subject
    end
  end

  it '.strip_tags' do
    result = described_class.new(valid_search_str)
                            .send(:strip_tags, '<b>Test<b>')
    expect(result).to eq 'Test'
  end
end
