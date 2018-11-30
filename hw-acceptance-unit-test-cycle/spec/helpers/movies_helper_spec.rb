require 'rails_helper'

describe MoviesHelper do
  describe 'oddness' do
    it 'returns even for 0' do
      expect(oddness(0)).to eq 'even'
    end

    it 'returns odd for 1' do
      expect(oddness(1)).to eq 'odd'
    end
  end
end
