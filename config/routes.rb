# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html

RedmineApp::Application.routes.draw do
  get 'dashboard/index'       , :to => 'dashboard#index'
  get 'dashboard/cost'        , :to => 'dashboard#cost'
  get 'dashboard/health'      , :to => 'dashboard#health'
  get 'dashboard/utilisation' , :to => 'dashboard#utilisation'
  get 'dashboard/workload'    , :to => 'dashboard#workload'
  get 'dashboard/completion'  , :to => 'dashboard#completion'
end




# <ul>
#   <li><a href="/dashboard/cost" class="projects">Project Cost</a></li>
#   <li><a href="/dashboard/health" class="projects">Project Health</a></li>
#   <li><a href="/dashboard/utilisation" class="projects">Project Utilisation</a></li>
#   <li><a href="/dashboard/workload" class="projects">Developer Workload</a></li>
#   <li><a href="/dashboard/completion" class="projects">Task Completion</a></li>
# </ul>
