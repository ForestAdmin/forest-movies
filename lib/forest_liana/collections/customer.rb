class Forest::Customer
  include  ForestLiana::Collection

  collection :customers

  field :fullname, type: 'String' do
    "#{object.firstname} #{object.lastname}"
  end
end
