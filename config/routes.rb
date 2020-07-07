Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post 'api/v1/salesman' => 'api/v1/salesman#create'
  put  'api/vi/salesman/:id' => 'api/v1/salesman#update'
end
