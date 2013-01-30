require 'spec_helper'

module Ecm::Downloads
  describe DownloadCategoriesController do
    describe "GET index" do
      before(:each) do
        @download_categories = FactoryGirl.create_list(:ecm_downloads_download_category, 3)
        get :index
      end # before(:each)

      it "assigns all download categories to @download_categories" do
        expect(assigns(:download_categories)).to eq(@download_categories)
      end # it
    end #  describe "GET index"

    describe "GET show" do
      before(:each) do
        @download_category = FactoryGirl.create(:ecm_downloads_download_category)
        get :show, :id => @download_category
      end # before(:each)

      it "assigns a download category to @download_category" do
        expect(assigns(:download_category)).to eq(@download_category)
      end # it
    end #  describe "GET show"

  end # describe DownloadCategoriesController
end # module Ecm::Downloads

