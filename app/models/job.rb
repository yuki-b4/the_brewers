class Job < ActiveHash::Base
  self.data = [
    {id: 1, name: "--"},
    {id: 2, name: "コーヒーが関わる仕事をしている"},
    {id: 3, name: "コーヒー大好きだけど、これから業界で働く予定"},
    {id: 4, name: "仕事は別だけど、コーヒー愛している"},
    {id: 5, name: "これからもっとコーヒーを好きになる"},
  ]

  include ActiveHash::Associations
  has_many :users
end
