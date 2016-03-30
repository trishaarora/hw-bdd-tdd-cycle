require 'rails_helper'
require 'spec_helper'

describe MoviesController, :type => :controller do
    describe 'same_director' do
        it "should find movies with same director" do
            @movie_id = '1'
            @movie = double({:title => "Star Wars", :rating => "PG", :director => "George Lucas", :release_date =>"1977-05-25"})
            expect(Movie).to receive(:find).with(@movie_id).and_return(@movie)
            expect(Movie).to receive(:where).with(:director => @movie.director).and_return(@movie)
            get :same_director, :id => @movie_id
        end
    end 
    
    context 'no_director' do
        it "should find movies with no director" do
            @movie_id = '1234'
            @movie = double({:title => "Alien", :rating => "R", :director => '', :release_date =>"1979-05-25"})
            expect(Movie).to receive(:find).with(@movie_id).and_return(@movie)
            allow(@movie).to receive(:director)
            get :same_director, :id => @movie_id
            expect(response).to redirect_to(movies_path)
            
        end
    end
    
    describe 'index' do
        it "go to index" do
            get :index
        end
    end
    
    describe 'create' do
        it "creates a new movie in table" do
            @star_wars = double("Movie").as_null_object
            allow(Movie).to receive(:create!).and_return(@star_wars)
            get :create, :movie => {}
            expect(response).to redirect_to(movies_path)
        end
    end
    
    describe 'update' do
        it "changes a movie in table" do
            @movie_id = '1'
            @movie = double({:title => "Star Wars", :rating => "PG", :release_date =>"1977-05-25"})
            expect(Movie).to receive(:find).with(@movie_id).and_return(@movie) 
            expect(@movie).to receive(:update_attributes!).with(:director => "George Lucas").and_return(:true)
            put :update, :id => @movie_id, :movie => {:director => "George Lucas"} 
        end
    end
    
    describe 'destroy' do
        it "destroys a movie in table" do
            @movie_id = '1'
            @movie = double({:title => "Star Wars", :rating => "PG", :release_date =>"1977-05-25"})
            expect(Movie).to receive(:find).with(@movie_id).and_return(@movie)
            expect(@movie).to receive(:destroy).and_return(:true)
            delete :destroy, :id => @movie_id
            expect(response).to redirect_to(movies_path)
        end
    end

end 