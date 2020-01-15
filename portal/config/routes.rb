Rails.application.routes.draw do

  resources :tb_avaliacoes, path: :avaliacoes, only: %i(index show)
  devise_for :useres
  root 'principal#index'

  namespace :administracao do
    resources :tb_perguntas, path: :perguntas
    resources :tb_avaliacoes, path: :tb_avaliacoes
    resources :tb_cargos, path: :cargos
    resources :tb_empregados, path: :empregados do
      get :autocomplete, on: :collection
    end
  end

  namespace :gerente do
    resources :tb_avaliacoes, path: :avaliacoes, except: %i(new create destroy)
  end
end
