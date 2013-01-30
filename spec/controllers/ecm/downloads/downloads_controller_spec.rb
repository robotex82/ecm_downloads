require 'spec_helper'

module Ecm::Downloads
  describe DownloadsController do
    describe "GET index" do
      before(:each) do
        @published_downloads = FactoryGirl.create_list(:ecm_downloads_download, 3, :published => true)
        @private_downloads = FactoryGirl.create_list(:ecm_downloads_download, 3, :published => false)
        get :index
      end # before(:each)

      it "assigns all published downloads to @downloads" do
        expect(assigns(:downloads)).to eq(@published_downloads)
      end # it
    end #  describe "GET index"

    describe "GET show" do
      before(:each) do
        @download = FactoryGirl.create(:ecm_downloads_download, :published => true)
        get :show, :id => @download
      end # before(:each)

      it "assigns a download to @download" do
        expect(assigns(:download)).to eq(@download)
      end # it
    end #  describe "GET show"

  end # describe DownloadsController
end # module Ecm::Downloads

