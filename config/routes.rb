Rails.application.routes.draw do
  root 'main#landing'
  resource :mugen, controller: :mugen, only: [:show]
end
