require 'spec_helper'

describe "routing to download categories" do
  it "routes /ecm_downloads_download_categories to ecm/downloads/download_categories#index" do
    expect(:get => "/ecm_downloads_download_categories").to route_to(
      :controller => "ecm/downloads/download_categories",
      :action => "index"
    )
  end # it

  it "routes /ecm_downloads_download_categories/example to ecm/downloads/download_categories#show" do
    expect(:get => "/ecm_downloads_download_categories/example").to route_to(
      :controller => "ecm/downloads/download_categories",
      :action => "show",
      :id => "example"
    )
  end # it
end

describe "routing to downloads" do
  it "routes /ecm_downloads_downloads to ecm/downloads/downloads#index" do
    expect(:get => "/ecm_downloads_downloads").to route_to(
      :controller => "ecm/downloads/downloads",
      :action => "index"
    )
  end # it

  it "routes /ecm_downloads_downloads/example to ecm/downloads/downloads#show" do
    expect(:get => "/ecm_downloads_downloads/example").to route_to(
      :controller => "ecm/downloads/downloads",
      :action => "show",
      :id => "example"
    )
  end # it
end
