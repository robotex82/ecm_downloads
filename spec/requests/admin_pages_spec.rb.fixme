require 'spec_helper'

RSpec.configure do |c|
  c.include ActiveAdmin::SignInHelper
end

describe "AdminPages" do
  describe "GET /admin/*" do
    before do
      @admin_user = FactoryGirl.create(:admin_user)
      sign_in @admin_user
    end

    describe "check all pages:" do
      # check app path
      all_admin_pages = Dir['app/admin/*.rb'].map { |entry| entry[/[^\/]+\.rb/][0..-4] }
      # check engine path
      all_admin_pages.concat(Dir['../../app/admin/*.rb'].map { |entry| entry[/[^\/]+\.rb/][0..-4] })
      
      if all_admin_pages.delete('dashboard')
        it 'dashboard' do
          get send("admin_dashboard_path")
          response.status.should be(200)
        end
      end

      all_admin_pages.each do |path|
        it "#{path} -> INDEX" do
          get send("admin_#{path.pluralize}_path")
          response.status.should be(200)
        end
      end

      all_admin_pages.each do |path|
        path = path.singularize
        it "#{path} -> NEW" do
          get send("new_admin_#{path}_path")
          response.status.should be(200)
        end

        it "#{path} -> CREATE" do
          #not just attributes_for, because then associated ids are not set up
          instance = FactoryGirl.build(path)
          attributes = instance.attributes.reject() { |k, v| !instance.class.accessible_attributes.include?(k) }
          #admin user should have password, generated with #attributes_for
          attributes.merge!(FactoryGirl.attributes_for(:admin_user)) if path == 'admin_user'
          post send("admin_#{path.pluralize}_path"),
               { path => attributes }
          response.status.should be(302)
          response.should redirect_to(:action => :show, :id => assigns(path))
        end

        it "#{path} -> EDIT" do
          get send("edit_admin_#{path}_path", FactoryGirl.create(path))
          response.status.should be(200)
        end

        it "#{path} -> UPDATE" do
          object = FactoryGirl.create(path)
          attributes = FactoryGirl.attributes_for(path)
          #except password for user
          attributes.except!(:password, :password_confirmation) if path == 'admin_user'
          put send("admin_#{path}_path", object),
               { path => attributes }
          response.status.should be(302)
          updated_object = assigns(path)
          response.should redirect_to(:action => :show, :id => updated_object)
          attributes.each do |k,v|
            # Hack to fix bug in ActiveSupport::TimeWithZone.==
            if updated_object[k].class == ActiveSupport::TimeWithZone
              updated_object[k].to_s.should == v.to_s
            else
              updated_object[k].should == v
            end  
          end
        end

        it "#{path} -> SHOW" do
          get send("admin_#{path}_path", FactoryGirl.create(path))
          response.status.should be(200)
        end

        it "#{path} -> DELETE" do
          delete send("admin_#{path}_path", FactoryGirl.create(path))
          response.status.should be(302)
        end
      end
    end
  end
end

