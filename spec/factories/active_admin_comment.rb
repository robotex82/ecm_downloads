FactoryGirl.define do
  factory :active_admin_comment, :class => ActiveAdmin::Comment do
    body "This is a test comment."
    namespace "admin"
    association :resource, :factory => :admin_user
  end
end
