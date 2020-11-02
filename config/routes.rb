Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'api/v1/salesman' => 'api/v1/salesman#show'
  post 'api/v1/salesman' => 'api/v1/salesman#create'
  put 'api/v1/salesman/:id' => 'api/v1/salesman#update'
  post 'api/v1/salesman/:id/add-phone' => 'api/v1/salesman#add_phone'
  put 'api/v1/salesman/:salesman_id/disable-phone/:phone_id' => 'api/v1/salesman#disable_phone'

  get 'api/v1/supplier' => 'api/v1/supplier#show'
  post 'api/v1/supplier' => 'api/v1/supplier#create'
  put 'api/v1/supplier/:id' => 'api/v1/supplier#update'

end
