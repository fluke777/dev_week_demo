GoodData::Model::ProjectBuilder.create("Dev Week test") do |p|
  p.add_date_dimension("committed_on")

  p.add_dataset("repos") do |d|
    d.add_anchor("id")
    d.add_label("name", :reference => "id")
  end

  p.add_dataset("devs") do |d|
    d.add_anchor("id")
    d.add_label("email", :reference => "id")
  end

  p.add_dataset("commits") do |d|
    d.add_fact("lines_changed")
    d.add_date("committed_on", :dataset => "committed_on")
    d.add_reference("dev_id", :dataset => 'devs', :reference => 'id')
    d.add_reference("repo_id", :dataset => 'repos', :reference => 'id')
  end

  p.upload("data/devs.csv", :dataset => 'devs')
  p.upload("data/repos.csv", :dataset => 'repos')
  p.upload("data/commits.csv", :dataset => 'commits')

end