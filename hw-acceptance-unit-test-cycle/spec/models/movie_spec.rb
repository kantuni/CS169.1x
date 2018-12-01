require 'rails_helper'

describe Movie do
  it 'has a valid factory' do
    expect(FactoryGirl.create(:movie)).to be_valid
  end

  it 'returns correct movie ratings' do
    expect(Movie.all_ratings).to eq %w[G PG PG-13 NC-17 R]
  end

  describe 'show similar movies' do
    before :each do
      @the_shawshank_redemption = FactoryGirl.create(:movie)
      @ready_player_one = FactoryGirl.create(:movie, title: 'Ready Player One', director: 'Steven Spielberg')
      @the_terminal = FactoryGirl.create(:movie, title: 'The Terminal', director: 'Steven Spielberg')
    end

    it 'finds movies by the same director' do
      expect(@ready_player_one.similar_movies).to contain_exactly @ready_player_one, @the_terminal
    end

    it 'does not find movies by different directors' do
      expect(@ready_player_one.similar_movies).not_to include @the_shawshank_redemption
    end
  end
end
