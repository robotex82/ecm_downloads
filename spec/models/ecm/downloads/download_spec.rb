module Ecm
  module Downloads
    describe Download do
      subject { FactoryGirl.build(:ecm_downloads_download) }
      
      # associations
      it { should belong_to(:ecm_downloads_download_category) }
      
      # validations
      it { should validate_presence_of(:name) }
      it { should validate_presence_of(:ecm_downloads_download_category) }      
      # it { should validate_uniqueness_of(:name).scoped_to(:ecm_downloads_download_category_id) }
      
      it "should only accept available locales" do
        download = FactoryGirl.build(:ecm_downloads_download, :locale => 'invalid')
        download.should_not be_valid      
      end 
      
      # acts as list
      it { should respond_to(:move_higher) }
      
      # friendly id
      it "should have a friendly id" do
        download = FactoryGirl.create(:ecm_downloads_download, :name => 'This is a download that should have a friendly id!')
        download.to_param.should == 'this-is-a-download-that-should-have-a-friendly-id'
      end 
      
      # methods
    end
  end  
end  
