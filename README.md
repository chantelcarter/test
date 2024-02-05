# README
Wildlife Tracker Challenge
The Forest Service is considering a proposal to place in conservancy a forest of virgin Douglas fir just outside of Portland, Oregon. Before they give the go ahead, they need to do an environmental impact study. They've asked you to build an API the rangers can use to report wildlife sightings.

Story 1: In order to track wildlife sightings, as a user of the API, I need to manage animals.

### terminal process
- rails new rails-api -d postgresql -T
 1234 cd rails-api
 1235 rails db:create
 1236 git remote add origin https://github.com/learn-academy-2023-india/wildlife-tracker-chantelcarter.git
 1237 git checkout -b main
 1238 git status
 1239 git add .
 1240 git commit -m "initial commit"
 1241 bundle add rspec-rails
 1242 rails generate rspec:install
 1243 rails s
 1244 git push origin main
 1245 rails g resource Animal common_name:string scientific_binomial:string
 1246 code .
 1247 rails db:migrate
 1248* rails c

Branch: animal-crud-actions

Acceptance Criteria

- Create a resource for animal with the following information: common name and scientific binomial
    - "rails g resource Animal common_name:string scientific_binomial:string"
    - instances used in rails console:
        - Animal.create(common_name: 'Lion', scientific_binomial: 'Panthera leo')
        - Animal.create(common_name: 'Lion', scientific_binomial: 'Panthera leo')
        - Animal.create(common_name: 'Giraffe', scientific_binomial: 'Cervus camelopardalis')
            - didn't use: Animal.create(common_name: 'Zebra', scientific_binomial: 'Equus quagga')

- Can see the data response of all the animals
    - disable authenticity token in app/controllers/application_controller.rb:
        - "skip_before_action :verify_authenticity_token"
    - index method in animal_controller.rb:
        - def index
            animals = Animal.all
            render json: animals
        end
    
### process for postman
GET -> localhost:3000/aniamls
Click the send button
Body -> Pretty -> JSON (upper portion of postman)
### postman results
Body -> Pretty -> JSON (lower portion of postman)
[
    {
        "id": 1,
        "common_name": "Lion",
        "scientific_binomial": "Panthera leo",
        "created_at": "2024-02-05T03:12:38.461Z",
        "updated_at": "2024-02-05T03:12:38.461Z"
    },
    {
        "id": 2,
        "common_name": "Lion",
        "scientific_binomial": "Panthera leo",
        "created_at": "2024-02-05T03:12:50.400Z",
        "updated_at": "2024-02-05T03:12:50.400Z"
    },
    {
        "id": 3,
        "common_name": "Giraffe",
        "scientific_binomial": "Cervus camelopardalis",
        "created_at": "2024-02-05T03:13:46.692Z",
        "updated_at": "2024-02-05T03:13:46.692Z"
    }
]
- show method to show a single instance in animal_controller.rb:
    - def show
        animal = Animal.find(params[:id])
        render json: animal
    end
### process for postman
- GET -> localhost:3000/aniamls/2
- Click the send button
### postman results
- Body -> Pretty -> JSON (in lower portion of postman)
{
    "id": 2,
    "common_name": "Lion",
    "scientific_binomial": "Panthera leo",
    "created_at": "2024-02-05T03:12:50.400Z",
    "updated_at": "2024-02-05T03:12:50.400Z"
}
    
- Can create a new animal in the database
    - create method in animals_controller.rb:
        - def animal_params
            params.require(:animal).permit(:common_name, :scientific_binomial)
        end
### process for postman
- POST -> localhost:3000/aniamls
- Body -> raw -> JSON (in upper portion of postman)
- in body:
{ 
    "common_name": "Mongoose", "scientific_binomial": "Herpestidae"
}
- Click the send button
### postman resutls
- Body -> Pretty -> JSON (in bottom portion of postman)
- should get result (in not check preview for errors):
{
    "id": 4,
    "common_name": "Mongoose",
    "scientific_binomial": "Herpestidae",
    "created_at": "2024-02-05T04:35:28.658Z",
    "updated_at": "2024-02-05T04:35:28.658Z"
}

- Can update an existing animal in the database
    - update method in animals_controller.rb:
        - def update
            animal = Animal.find(params[:id])
            animal.update(animal_params)
            if animal.valid?
                render json: animal
            else
                render json: animal.errors
            end
        end
### process for postman
- PATCH -> localhost:3000/animals/2
- Body -> raw -> JSON (in upper part of postman)
- in body:
{
    "common_name": "Tiger",
    "scientific_binomial": "Panthera tigris"
}
Click the send button
### postman results
- Body -> Pretty -> JSON
- should get result (if not check preview for errors):
{
    "common_name": "Tiger",
    "scientific_binomial": "Panthera tigris",
    "id": 2,
    "created_at": "2024-02-05T03:12:50.400Z",
    "updated_at": "2024-02-05T05:10:32.869Z"
}
- all instances with update:
[
    {
        "id": 1,
        "common_name": "Lion",
        "scientific_binomial": "Panthera leo",
        "created_at": "2024-02-05T03:12:38.461Z",
        "updated_at": "2024-02-05T03:12:38.461Z"
    },
    {
        "id": 3,
        "common_name": "Giraffe",
        "scientific_binomial": "Cervus camelopardalis",
        "created_at": "2024-02-05T03:13:46.692Z",
        "updated_at": "2024-02-05T03:13:46.692Z"
    },
    {
        "id": 4,
        "common_name": "Mongoose",
        "scientific_binomial": "Herpestidae",
        "created_at": "2024-02-05T04:35:28.658Z",
        "updated_at": "2024-02-05T04:35:28.658Z"
    },
    {
        "id": 2,
        "common_name": "Tiger",
        "scientific_binomial": "Panthera tigris",
        "created_at": "2024-02-05T03:12:50.400Z",
        "updated_at": "2024-02-05T05:10:32.869Z"
    }
]

- Can remove an animal entry in the database
    - destroy method in animals_controller.rb:
        - def destroy
            animal = Animal.find(params[:id])
            if animal.destroy
                render json: animal
            else
                render json: animal.errors
            end
        end
### process for postman
- DELETE -> localhost:3000/animals/3
- Click the send button
### postman results
- Body -> Pretty -> JSON
- should get back item destroyed (if not check preview for errors):
{
    "id": 3,
    "common_name": "Giraffe",
    "scientific_binomial": "Cervus camelopardalis",
    "created_at": "2024-02-05T03:13:46.692Z",
    "updated_at": "2024-02-05T03:13:46.692Z"
}
- all instances after destroy:
[
    {
        "id": 1,
        "common_name": "Lion",
        "scientific_binomial": "Panthera leo",
        "created_at": "2024-02-05T03:12:38.461Z",
        "updated_at": "2024-02-05T03:12:38.461Z"
    },
    {
        "id": 4,
        "common_name": "Mongoose",
        "scientific_binomial": "Herpestidae",
        "created_at": "2024-02-05T04:35:28.658Z",
        "updated_at": "2024-02-05T04:35:28.658Z"
    },
    {
        "id": 2,
        "common_name": "Tiger",
        "scientific_binomial": "Panthera tigris",
        "created_at": "2024-02-05T03:12:50.400Z",
        "updated_at": "2024-02-05T05:10:32.869Z"
    }
]

Story 2: In order to track wildlife sightings, as a user of the API, I need to manage animal sightings.

Branch: sighting-crud-actions

Acceptance Criteria

Create a resource for animal sightings with the following information: latitude, longitude, date
Hint: An animal has_many sightings (rails g resource Sighting animal_id:integer ...)
Hint: Date is written in Active Record as yyyy-mm-dd (“2022-07-28")
Can create a new animal sighting in the database
Can update an existing animal sighting in the database
Can remove an animal sighting in the database
Story 3: In order to see the wildlife sightings, as a user of the API, I need to run reports on animal sightings.

Branch: animal-sightings-reports

Acceptance Criteria

Can see one animal with all its associated sightings
Hint: Checkout this example on how to include associated records
Can see all the all sightings during a given time period
Hint: Your controller can use a range to look like this:
class SightingsController < ApplicationController
  def index
    sightings = Sighting.where(date: params[:start_date]..params[:end_date])
    render json: sightings
  end
end
Hint: Be sure to add the start_date and end_date to what is permitted in your strong parameters method
Hint: Utilize the params section in Postman to ease the developer experience
Hint: Routes with params
Stretch Challenges
Story 4: In order to see the wildlife sightings contain valid data, as a user of the API, I need to include proper specs.

Branch: animal-sightings-specs

Acceptance Criteria
Validations will require specs in spec/models and the controller methods will require specs in spec/requests.

Can see validation errors if an animal doesn't include a common name and scientific binomial
Can see validation errors if a sighting doesn't include latitude, longitude, or a date
Can see a validation error if an animal's common name exactly matches the scientific binomial
Can see a validation error if the animal's common name and scientific binomial are not unique
Can see a status code of 422 when a post request can not be completed because of validation errors
Hint: Handling Errors in an API Application the Rails Way
Story 5: In order to increase efficiency, as a user of the API, I need to add an animal and a sighting at the same time.

Branch: submit-animal-with-sightings

Acceptance Criteria

Can create new animal along with sighting data in a single API request
Hint: Look into accepts_nested_attributes_for


This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
