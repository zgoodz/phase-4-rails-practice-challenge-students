class StudentSerializer < ActiveModel::Serializer
  attributes :id, :name, :major, :age
  has_one :instructor
end
