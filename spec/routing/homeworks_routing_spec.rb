require "rails_helper"

RSpec.describe HomeworksController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/homeworks").to route_to("homeworks#index")
    end

    it "routes to #new" do
      expect(:get => "/homeworks/new").to route_to("homeworks#new")
    end

    it "routes to #show" do
      expect(:get => "/homeworks/1").to route_to("homeworks#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/homeworks/1/edit").to route_to("homeworks#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/homeworks").to route_to("homeworks#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/homeworks/1").to route_to("homeworks#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/homeworks/1").to route_to("homeworks#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/homeworks/1").to route_to("homeworks#destroy", :id => "1")
    end

  end
end
