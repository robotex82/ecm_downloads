require 'spec_helper'

module Ecm
  module Downloads
    describe Download do
      subject { FactoryGirl.build(:ecm_downloads_download) }

      # associations
      it { should belong_to(:ecm_downloads_download_category) }

      # validations
      it { should validate_presence_of(:name) }
      it { should validate_presence_of(:ecm_downloads_download_category) }

      # acts as list
      it { should respond_to(:move_higher) }

      # acts as published
      it { should respond_to(:published?) }
      describe ".published" do
        it "includes records with published flag" do
          published = FactoryGirl.create(:ecm_downloads_download, :published => true)
          Ecm::Downloads::Download.published.should include(published)
        end

        it "excludes records without published flag" do
          non_published = FactoryGirl.create(:ecm_downloads_download, :published => false)
          Ecm::Downloads::Download.published.should_not include(non_published)
        end
      end

      describe ".unpublished" do
        it "includes records with published flag" do
          published = FactoryGirl.create(:ecm_downloads_download, :published => true)
          Ecm::Downloads::Download.unpublished.should_not include(published)
        end

        it "excludes records without unpublished flag" do
          non_published = FactoryGirl.create(:ecm_downloads_download, :published => false)
          Ecm::Downloads::Download.unpublished.should include(non_published)
        end
      end


      # friendly id
      it "should have a friendly id" do
        download = FactoryGirl.create(:ecm_downloads_download,
                                      :name => 'This is a download that should have a friendly id!')
        download.to_param.should == 'this-is-a-download-that-should-have-a-friendly-id'
      end

      # methods
    end
  end
end
