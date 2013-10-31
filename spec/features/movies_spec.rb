require 'spec_helper'

feature 'When viewing showtimes for a movie' do
  let!(:city_all) { FactoryGirl.create(:city, name: 'All') }
  let!(:city_A) { FactoryGirl.create(:city) }
  let!(:city_B) { FactoryGirl.create(:city) }
  let!(:cinema_A) { FactoryGirl.create(:cinema, city:city_A) }
  let!(:cinema_B) { FactoryGirl.create(:cinema, city:city_A) }
  let!(:cinema_C) { FactoryGirl.create(:cinema, city:city_B) }
  let!(:movie_A) { FactoryGirl.create(:movie) }
  let!(:movie_B) { FactoryGirl.create(:movie) }

  scenario 'We get all current showtimes for the country' do
    showtime_A = FactoryGirl.create(:showtime, movie:movie_A, cinema:cinema_A)
    showtime_B = FactoryGirl.create(:showtime, movie:movie_A, cinema:cinema_B)
    showtime_C = FactoryGirl.create(:showtime, movie:movie_A, cinema:cinema_C)
    visit root_path
    first(:link, movie_A.name.titleize).click
    expect(page).to have_content(movie_A.name.titleize)
    expect(page).to have_content(cinema_A.name.titleize)
    expect(page).to have_content(cinema_B.name.titleize)
    expect(page).to have_content(cinema_C.name.titleize)
    expect(page).to have_content(showtime_A.humanize_showing_at)
    expect(page).to have_content(showtime_B.humanize_showing_at)
    expect(page).to have_content(showtime_C.humanize_showing_at)
  end

  scenario 'We do not get old showtimes for the country' do
    showtime_A = FactoryGirl.create(:showtime, movie:movie_A, cinema:cinema_A, showing_at: 4.days.from_now)
    showtime_B = FactoryGirl.create(:showtime, movie:movie_A, cinema:cinema_C)
    Timecop.freeze(3.days.from_now) do
      visit root_path
      first(:link, movie_A.name.titleize).click
      expect(page).to have_content(cinema_A.name.titleize)
      expect(page).not_to have_content(cinema_C.name.titleize)
      expect(page).to have_content(showtime_A.humanize_showing_at)
      expect(page).not_to have_content(showtime_B.humanize_showing_at)
    end
  end

  scenario 'We get all current showtimes for the city' do
    showtime_A = FactoryGirl.create(:showtime, movie:movie_A, cinema:cinema_A)
    showtime_B = FactoryGirl.create(:showtime, movie:movie_A, cinema:cinema_B)
    visit root_path
    first(:link, movie_A.name.titleize).click
    expect(page).to have_content(movie_A.name.titleize)
    expect(page).to have_content(cinema_A.name.titleize)
    expect(page).to have_content(cinema_B.name.titleize)
    expect(page).to have_content(showtime_A.humanize_showing_at)
    expect(page).to have_content(showtime_B.humanize_showing_at)
  end

  scenario 'We only get current showtimes for the city' do
    showtime_A = FactoryGirl.create(:showtime, movie:movie_A, cinema:cinema_A, showing_at: 4.days.from_now)
    showtime_B = FactoryGirl.create(:showtime, movie:movie_A, cinema:cinema_A)
    showtime_C = FactoryGirl.create(:showtime, movie:movie_A, cinema:cinema_B)
    Timecop.freeze(3.days.from_now) do
      visit root_path
      click_link(city_A.name)
      first(:link, movie_A.name.titleize).click
      expect(page).to have_content(cinema_A.name.titleize)
      expect(page).to have_content(showtime_A.humanize_showing_at)
      expect(page).not_to have_content(cinema_B.name.titleize)
      expect(page).not_to have_content(showtime_B.humanize_showing_at)
    end
  end

  scenario 'We do not get showtimes for another city' do
    showtime_A = FactoryGirl.create(:showtime, movie:movie_A, cinema:cinema_A)
    showtime_B = FactoryGirl.create(:showtime, movie:movie_A, cinema:cinema_C, showing_at: showtime_A.showing_at+1.hour)
      visit root_path
      click_link(city_A.name)
      first(:link, movie_A.name.titleize).click
      expect(page).not_to have_content(cinema_C.name.titleize)
      expect(page).not_to have_content(showtime_B.humanize_showing_at)
    end

  scenario 'We get a message when trying to access showtimes for an out of date movie' do
    visit city_movie_path(city_all,movie_A)
    expect(page).to have_content("That movie isn't currently showing in the specified location")
  end

end


