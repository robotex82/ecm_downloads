require 'spec_helper'

feature 'Download category admin' do
  include ActiveAdmin::SignInHelper

  def set_resource_class
    @resource_class = Ecm::Downloads::DownloadCategory
  end

  def prepare_for_new
  end

  def fill_new_form
    select I18n.locale.to_s,                         :from => 'ecm_downloads_download_category[locale]'
    fill_in "ecm_downloads_download_category[name]", :with => "Download Category"
  end

  def fill_edit_form
    fill_in     "ecm_downloads_download_category[name]", :with => "An updated name"
  end

  def set_index_check_column
    @index_check_column = "name"
  end

  background do
    I18n.locale = :en
    admin_user = FactoryGirl.create(:admin_user)
    sign_in_with(admin_user.email, admin_user.password)

    set_resource_class
    @resource_path = @resource_class.to_s.underscore.gsub('/', '_').pluralize
    @resource_factory_name = @resource_class.to_s.underscore.gsub('/', '_').to_sym
  end # background

  describe 'new' do
    background do
      prepare_for_new
      visit "/admin/#{@resource_path}/new"
    end

    scenario 'should be visitable' do
      expect(page.current_path).to eq("/admin/#{@resource_path}/new")
    end
    
    describe 'when filling the form correctly' do
      background do
        fill_new_form
        find(:xpath, '//input[@type="submit"]').click
      end

      scenario 'should have created a record' do
        @resource_class.count.should eq(1)
      end

      scenario 'should redirect to the resource show page' do
        @resource = @resource_class.first
        expect(page.current_path).to eq("/admin/#{@resource_path}/#{@resource.to_param}")
      end
    end
  end

  describe 'show' do
    background do
      @resource = FactoryGirl.create(@resource_factory_name)
      visit '/admin/#{@resource_path}/#{@resource.to_param}'
    end
  end

  describe 'edit' do
    background do
      @resource = FactoryGirl.create(@resource_factory_name)
      visit "/admin/#{@resource_path}/#{@resource.to_param}/edit"
    end  

    scenario 'should be visitable' do
      expect(page.current_path).to eq("/admin/#{@resource_path}/#{@resource.to_param}/edit")
    end

    describe 'when filling the form correctly' do
      background do
        fill_edit_form
        find(:xpath, '//input[@type="submit"]').click
      end

      scenario 'should not have created a record' do
        @resource_class.count.should eq(1)
      end

      scenario 'should redirect to the resource show page' do
        @resource = @resource_class.first
        expect(page.current_path).to eq("/admin/#{@resource_path}/#{@resource.to_param}")
      end
    end

  end

  describe 'delete' do
    background do
      @resource = FactoryGirl.create(@resource_factory_name)
    end
  end

  describe 'index' do
    background do
      set_index_check_column
      @resources = FactoryGirl.create_list(@resource_factory_name, 3)
      visit "/admin/#{@resource_path}"
    end

    scenario 'should be visitable' do
      expect(page.current_path).to eq("/admin/#{@resource_path}")
    end

    scenario "should show the resrouces" do
      @resources.each do |resource|
        page.body.should include(resource.send(@index_check_column.to_sym))
      end
    end # scenario
  end
end # feature

#require 'spec_helper'

#feature 'Download admin' do
#  include ActiveAdmin::SignInHelper

#  background do
#    I18n.locale = :en
#    admin_user = FactoryGirl.create(:admin_user)
#    sign_in_with(admin_user.email, admin_user.password)
#  end # background


#  #  scenario 'admin is logged in' do
#  #     expect(page.current_path).to eq('/admin')
#  #  end # scenario

#  describe 'new' do

#    background do
#      visit '/admin/ecm_downloads_download_categories/new'
#    end # background

#    scenario 'should be visitable' do
#      expect(page.current_path).to eq('/admin/ecm_downloads_download_categories/new')
#    end

#    describe 'when filling the form correctly' do
#      before(:each) do
#        select I18n.locale.to_s,                         :from => 'ecm_downloads_download_category[locale]'
#        fill_in "ecm_downloads_download_category[name]", :with => "Download Category"
#        find(:xpath, '//input[@type="submit"]').click
#      end # before(:each)

#      scenario 'should have created one download category' do
#        Ecm::Downloads::DownloadCategory.count.should eq(1)
#      end # scenario

#      scenario 'should redirect to the download category show page' do
#        expect(page.current_path).to eq('/admin/ecm_downloads_download_categories/download-category')
#      end # scenario

#    end # describe 'fill the form correctly'
#  end # describe 'new'

#  describe 'index' do
#    background do
#      visit '/admin/ecm_downloads_download_categories'
#    end # background

#    scenario 'should be visitable' do
#      expect(page.current_path).to eq('/admin/ecm_downloads_download_categories')
#    end # scenario

#    describe 'with existing download categories' do
#      background do
#        @download_categories = FactoryGirl.create_list(:ecm_downloads_download_category, 3)
#        visit '/admin/ecm_downloads_download_categories'
#      end # background

#      scenario 'should show download category names' do
#        @download_categories.each do |download_category|
#          page.body.should include(download_category.name)
#        end
#      end # scenario

#    end # describe 'with existing download categories'
#  end # describe 'index'

#  describe 'show' do
#    background do
#      @download_category = FactoryGirl.create(:ecm_downloads_download_category)
#      visit "/admin/ecm_downloads_download_categories/#{@download_category.to_param}"
#    end # background

#    scenario 'should be visitable' do
#      expect(page.current_path).to eq("/admin/ecm_downloads_download_categories/#{@download_category.to_param}")
#    end # scenario

#  end # describe 'show'

#  describe 'edit' do
#    background do
#      @download_category = FactoryGirl.create(:ecm_downloads_download_category, :name => 'Old name')
#      visit "/admin/ecm_downloads_download_categories/#{@download_category.to_param}/edit"
#    end # background

#    scenario 'should be visitable' do
#      expect(page.current_path).to eq("/admin/ecm_downloads_download_categories/#{@download_category.to_param}/edit")
#    end # scenario

#    describe 'when updating the download category' do
#      background do
#        fill_in "ecm_downloads_download_category[name]", :with => "New name"
#        find(:xpath, '//input[@type="submit"]').click
#        @download_category.reload
#      end # background

#      scenario 'should be on the show page' do
#        expect(page.current_path).to eq("/admin/ecm_downloads_download_categories/#{@download_category.to_param}")
#      end # scenario

#      scenario 'should show the new name' do
#        page.body.should include(@download_category.name)
#      end # scenario
#    end # describe 'when updating the download category'

#  end # describe 'show'
#end # feature

