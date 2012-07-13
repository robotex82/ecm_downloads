module Ecm
  module Downloads
    describe DownloadCategory do
      subject { FactoryGirl.build(:ecm_downloads_download_category) }
      
      it { should have_many(:ecm_downloads_downloads) }
      
      it "should respond to root" do
        download_category = FactoryGirl.create(:ecm_downloads_download_category)
        download_category.should respond_to(:root)
      end
      
      it "should require a locale if it is a root node" do
        download_category = FactoryGirl.create(:ecm_downloads_download_category)
        download_category.should be_root
        
        download_category.locale = nil
        download_category.should_not be_valid
      end
      
      it "should not accept a locale if it is not a root node" do
        download_category = FactoryGirl.create(:ecm_downloads_download_category_with_parent)
        download_category.should_not be_root
        
        download_category.locale = I18n.locale
        download_category.should_not be_valid
      end
      
      it "should only accept available locales" do
        download_category = FactoryGirl.build(:ecm_downloads_download_category, :locale => 'invalid')
        download_category.should_not be_valid      
      end
      
      it "should have a friendly id" do
        download_category = FactoryGirl.create(:ecm_downloads_download_category, :name => 'Look, a slugged category!')
        download_category.to_param.should == 'look-a-slugged-category'
      end
    end
  end
end    
