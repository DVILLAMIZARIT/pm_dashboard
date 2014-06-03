Redmine::Plugin.register :pm_dashboard do
  name 'Project Management Dashboard Plugin'
  author 'Guy van den Berg'
  description 'Grinrod Project Management Dashboard'
  version '0.0.1'
  url 'http://example.com/path/to/plugin'
  author_url 'http://example.com/about'



  menu(:top_menu, :pm_dashboard, {:controller => 'dashboard', :action => 'index'}, :caption => 'Dashboard')


end



require 'awesome_print'

# some test code
module T
  class << self

    ##
    #
    ##
    def add_random_hours

      activity =  TimeEntryActivity.first



      Issue.all.each do |issue|

        hours = 0
        assigned = issue.assigned_to.nil? ? 'unknown' : issue.assigned_to.login


        if issue.time_entries.length == 0
          time = TimeEntry.new({user: issue.assigned_to, project: issue.project, hours: rand(1..20), comments: "seed data - fake entry", activity: activity, spent_on: Time.now})
          issue.time_entries << time
          issue.save if issue.valid?
        end

    #          :id => nil,
    #  :project_id => nil,
    #     :user_id => nil,
    #    :issue_id => nil,
    #       :hours => nil,
    #    :comments => nil,
    # :activity_id => nil,
    #    :spent_on => nil,
    #       :tyear => nil,
    #      :tmonth => nil,
    #       :tweek => nil,
    #  :created_on => nil,
    #  :updated_on => nil




        puts "#{issue.description} - #{assigned} hours: #{hours}"
      end
      nil
    end


    # def test

    #   cursor = Project.where {"parent_id is null"}


    #   # Project.all.each do |p|
    #   #   puts "------------------------- #{p.name}"
    #   #   puts " Parent = #{p.parent.nil? ? 'none' : p.parent.name}"
    #   #   p.children.each do |c|
    #   #     puts "    #{c.name}"
    #   #   end
    #   # end
    #   nil
    # end



  end
end
