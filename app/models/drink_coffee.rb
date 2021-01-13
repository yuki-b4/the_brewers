class DrinkCoffee < ActiveHash::Base
  self.data = [
    { id: 1, name: '--' },
    { id: 2, name: '0杯' },
    { id: 3, name: '1杯' },
    { id: 4, name: '2杯' },
    { id: 5, name: '3杯' },
    { id: 6, name: '4杯' },
    { id: 7, name: '5杯以上！！' }
  ]

  include ActiveHash::Associations
  has_many :users
end
