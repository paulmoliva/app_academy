Rails.application.routes.draw do

resources :cats

resources :cat_rental_requests

get 'cats/:id/approve', to: 'cat#approve'
# get 'cat_rental_requests/deny'


end
