SmallWorld::Application.routes.draw do
  resource :grid
  root :to => 'grid#new'
  match ':controller(/:action(/:id))(.:format)'
end
