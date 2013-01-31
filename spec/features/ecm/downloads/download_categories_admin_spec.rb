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

