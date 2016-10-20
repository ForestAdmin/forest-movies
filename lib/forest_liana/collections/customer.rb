class Forest::Customer
  include  ForestLiana::Collection

  collection :customers

  search_fullname = lambda do |query, search|
    first_name, last_name = search.split
    query.where_values.first << " OR (firstname = '#{first_name}' AND lastname = '#{last_name}')"

    query
  end

  field :fullname, search: search_fullname , type: 'String' do
    "#{object.firstname} #{object.lastname}"
  end
end
