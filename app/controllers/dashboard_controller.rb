class DashboardController < ApplicationController
  unloadable

  layout 'base'

  ##
  #
  ##
  def index
  end


  def cost
  end

  def health
  end


  def utilisation
    @dataset = compute_utilisation
  end

  def workload
  end


  def completion
  end



  private

  def top_level_projects
    Project.where("parent_id is null")
  end


  def sum_up_issue_time_utilisation(project, index, level)
    project.issues.each do |issue|

      key = issue.fixed_version.nil? ? project.name : issue.fixed_version.name

      index[key] = {level: level} if index[key].nil?
      index[key][:devs] = {} if index[key][:devs].nil?
      issue.time_entries.each do |time|
         index[key][:devs][time.user.login] = 0 if  index[key][time.user.login].nil?
         index[key][:devs][time.user.login] += time.hours
      end
    end
  end


  def compute_utilisation
    index = {}
    top_level_projects.each do |project|
      parent = project.parent.nil? ? '' : project.parent.name
      index[project.name] = {parent: parent, level: 1}
      sum_up_issue_time_utilisation(project, index, 2)


      project.children.each do |child|
        parent = child.parent.nil? ? '' : child.parent.name
        index[child.name] = {parent: parent, level: 2}
        sum_up_issue_time_utilisation(child, index, 3)
      end

    end

    devs = []

    # compute all names
    index.each do |k,v|
      unless v[:devs].nil?
        v[:devs].each do |d, h|
          devs << d unless devs.include?(d)
        end
      end
    end

    # set all the keys
    index.each do |k,v|
      v[:devs] = {} unless v.include?(:devs)

      devs.each do |dev|
        v[:devs][dev] = 0 unless v[:devs].include?(dev)
      end
    end

    # sort keys
    devs.sort!
    devhours = {}

    index.each do |k,v|
      total = 0
      ds = {}
      devs.each do |d|
        devhours[d] = 0 unless devhours.include?(d)
        ds[d] = v[:devs][d]
        total += v[:devs][d]
        devhours[d] += v[:devs][d]
      end
      v[:devs] = ds
      v[:total] = total
    end

    # convert data into multidimention array
    result = []
    header = ["Project","Lvl"]
    devs.each {|d| header << d }
    header << "Total"

    result << header
    index.each do |k,v|
      # row = [k,"",""] if v[:level] == 1
      # row = ["",k,""] if v[:level] == 2
      # row = ["","",k] if v[:level] == 3

      row = [k, v[:level]]


      v[:devs].each do |d,h|
        row << h
      end
      row << v[:total]
      result << row
    end

    footer = ["Total",""]
    devhours.each { |k,v| footer << v }
    footer << ""
    result << footer



    result

  end


end
