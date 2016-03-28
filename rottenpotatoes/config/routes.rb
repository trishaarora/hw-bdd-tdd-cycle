Rottenpotatoes::Application.routes.draw do
  # map '/' to be a redirect to '/movies'
  resources :movies do
     member do
       get 'same_director'
     end
   end
  root :to => redirect('/movies')
end
