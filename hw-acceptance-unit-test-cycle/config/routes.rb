Rottenpotatoes::Application.routes.draw do
  resources :movies do
    member do
      get :similar
    end
  end

  # map '/' to be a redirect to '/movies'
  root to: redirect('/movies')
end
